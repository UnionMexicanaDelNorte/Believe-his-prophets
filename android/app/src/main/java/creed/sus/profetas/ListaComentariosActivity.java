package creed.sus.profetas;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

public class ListaComentariosActivity extends AppCompatActivity {
    public int dia, mes, anio;
    static final ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_escribir, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_escribir) {

            Intent intent = new Intent(this, EscribeComentarioActivity.class);
            intent.putExtra("dia", dia);
            intent.putExtra("mes", mes);
            intent.putExtra("anio", anio);
            startActivity(intent);
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        //return activeNetworkInfo != null && activeNetworkInfo.isConnected();
        return activeNetworkInfo != null && activeNetworkInfo.isConnectedOrConnecting();
    }
    @Override
    protected void onStart()
    {
        super.onStart();
        final ListView listView = (ListView)findViewById(R.id.listViewMensajesDelDia);

        final ListaComentariosActivity reference = this;

        if(isNetworkAvailable())
        {
            final ProgressDialog progress = new ProgressDialog(this);
            progress.setTitle(getString(R.string.loading));
            progress.setMessage(getString(R.string.espera));
            progress.show();
            Thread background = new Thread(new Runnable() {
                public void run() {
                    try {
                        String url = "http://unionnorte.org/bhp/bhp.php";
                        URL obj = new URL(url);
                        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                        con.setRequestMethod("POST");
                        String urlParameters = "servicio=mensajes&accion=listDia&fecha="+dia+"-"+mes+"-"+anio;
                        con.setDoOutput(true);// Should be part of code only for .Net web-services else no need for PHP
                        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                        wr.writeBytes(urlParameters);
                        wr.flush();
                        wr.close();
                        int responseCode = con.getResponseCode();
                        BufferedReader in = new BufferedReader(
                                new InputStreamReader(con.getInputStream()));
                        String inputLine;
                        StringBuffer response = new StringBuffer();

                        while ((inputLine = in.readLine()) != null) {
                            response.append(inputLine);
                        }
                        in.close();
                        JSONObject test = new JSONObject(response.toString());
                        String success = test.getString("success");
                        if(success.equals("1"))
                        {
                            JSONArray arrayJson = test.getJSONArray("mensajes");
                            int i;
                            list.clear();
                            for(i=0;i<arrayJson.length();i++)
                            {
                                JSONObject mensaje = arrayJson.getJSONObject(i);
                                String tit =     Uri.decode( mensaje.getString("mensaje"));
                                if(tit.length()>25)
                                {
                                    tit=tit.substring(0,23)+"..";
                                }
                                String sub =     mensaje.getString("name");
                                HashMap<String,String> temp = new HashMap<String,String>();
                                temp.put("title",tit);
                                temp.put("todo",Uri.decode( mensaje.getString("mensaje")));

                                temp.put("subtitle",sub);
                                list.add(temp);

                            }
                            runOnUiThread(new Runnable() {
                                public void run() {
                                    progress.dismiss();
                                    SimpleAdapter adapter = new SimpleAdapter(
                                            reference,
                                            list,
                                            R.layout.mylistmensaje,
                                            new String[]{"title", "subtitle"},
                                            new int[]{R.id.Itemname, R.id.SubItemname}
                                    );

                                    listView.setAdapter(adapter);
                                    listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                                        public void onItemClick(AdapterView<?> av, View view, int i, long l) {
                                            HashMap<String, String> temp = list.get(i);

                                            String todo = temp.get("todo");
                                            Intent intent = new Intent(reference, TextoActivity.class);
                                            intent.putExtra("texto", todo);
                                            startActivity(intent);
                                            // / Toast.makeText(Activity.this, "myPos " + i, Toast.LENGTH_LONG).show();
                                        }
                                    });
                                }
                            });

                        }


                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            });

            background.start();
        }
        else
        {
            new AlertDialog.Builder(reference)
                    .setTitle( getString(R.string.internet_error))
                    .setMessage(getString(R.string.internet_error_message))
                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            // continue with delete
                        }
                    })
                    .setIcon(android.R.drawable.ic_dialog_alert)
                    .show();
        }


    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_comentarios);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        Intent intent = this.getIntent();
        setTitle(getString(R.string.mensajes));
        String nombreArchivo = intent.getStringExtra("name");
        int aux = nombreArchivo.lastIndexOf("y");

        String aver  = nombreArchivo.substring(aux+1, aux+5);
        String aver2 = nombreArchivo.substring(0, aux);
        aver2 = aver2.replaceAll("[^\\d.]", "");

        dia = Integer.parseInt(aver2);
        //String[] separated = aver2.split(":");

        anio = Integer.parseInt(aver);
        mes=0;
        if(nombreArchivo.lastIndexOf("enero")!=-1 || nombreArchivo.lastIndexOf("january")!=-1 || nombreArchivo.lastIndexOf("janvier")!=-1  )
        {
            mes=1;
        }
        if(nombreArchivo.lastIndexOf("febrero")!=-1 || nombreArchivo.lastIndexOf("february")!=-1 || nombreArchivo.lastIndexOf("fevrier")!=-1  )
        {
            mes=2;
        }
        if(nombreArchivo.lastIndexOf("marzo")!=-1 || nombreArchivo.lastIndexOf("march")!=-1 || nombreArchivo.lastIndexOf("mars")!=-1  )
        {
            mes=3;
        }
        if(nombreArchivo.lastIndexOf("abril")!=-1 || nombreArchivo.lastIndexOf("april")!=-1 || nombreArchivo.lastIndexOf("avril")!=-1  )
        {
            mes=4;
        }
        if(nombreArchivo.lastIndexOf("mayo")!=-1 || nombreArchivo.lastIndexOf("may")!=-1 || nombreArchivo.lastIndexOf("mai")!=-1  )
        {
            mes=5;
        }
        if(nombreArchivo.lastIndexOf("junio")!=-1 || nombreArchivo.lastIndexOf("june")!=-1 || nombreArchivo.lastIndexOf("juin")!=-1  )
        {
            mes=6;
        }
        if(nombreArchivo.lastIndexOf("julio")!=-1 || nombreArchivo.lastIndexOf("july")!=-1 || nombreArchivo.lastIndexOf("juillet")!=-1  )
        {
            mes=7;
        }
        if(nombreArchivo.lastIndexOf("agosto")!=-1 || nombreArchivo.lastIndexOf("august")!=-1 || nombreArchivo.lastIndexOf("aout")!=-1  )
        {
            mes=8;
        }
        if(nombreArchivo.lastIndexOf("septiembre")!=-1 || nombreArchivo.lastIndexOf("september")!=-1 || nombreArchivo.lastIndexOf("septembre")!=-1  )
        {
            mes=9;
        }
        if(nombreArchivo.lastIndexOf("octubre")!=-1 || nombreArchivo.lastIndexOf("october")!=-1 || nombreArchivo.lastIndexOf("octobre")!=-1  )
        {
            mes=10;
        }
        if(nombreArchivo.lastIndexOf("noviembre")!=-1 || nombreArchivo.lastIndexOf("november")!=-1 || nombreArchivo.lastIndexOf("novembre")!=-1  )
        {
            mes=11;
        }
        if(nombreArchivo.lastIndexOf("diciembre")!=-1 || nombreArchivo.lastIndexOf("december")!=-1 || nombreArchivo.lastIndexOf("decembre")!=-1  )
        {
            mes=12;
        }




        /*

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });*/
    }

}

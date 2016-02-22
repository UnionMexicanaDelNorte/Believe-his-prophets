package creed.sus.profetas;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
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
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.SimpleAdapter;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

public class EscribeComentarioActivity extends AppCompatActivity {
    public int dia, mes, anio;
    static EscribeComentarioActivity reference;
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_publicar, menu);
        return true;
    }
    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        //return activeNetworkInfo != null && activeNetworkInfo.isConnected();
        return activeNetworkInfo != null && activeNetworkInfo.isConnectedOrConnecting();
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_publicar) {
            if(isNetworkAvailable())
            {
                final ProgressDialog progress = new ProgressDialog(this);
                progress.setTitle(getString(R.string.loading));
                progress.setMessage(getString(R.string.espera));
                progress.show();
                Thread background = new Thread(new Runnable() {
                    public void run() {
                        try {
                            String texto = Uri.encode(text.getText().toString());
                            SharedPreferences prefs = getSharedPreferences("creedsusprofetas", MODE_PRIVATE);
                            String idF = prefs.getString("id", "").toString();

                            String url = "http://unionnorte.org/bhp/bhp.php";
                            URL obj = new URL(url);
                            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                            con.setRequestMethod("POST");
                            String urlParameters = "servicio=mensajes&accion=save&fecha="+dia+"-"+mes+"-"+anio+"&idF="+idF+"&mensaje="+texto;
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
                                runOnUiThread(new Runnable() {
                                    public void run() {
                                        progress.dismiss();
                                        finish();
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
            /*Intent intent = new Intent(this, EscribeComentarioActivity.class);
            intent.putExtra("dia", dia);
            intent.putExtra("mes", mes);
            intent.putExtra("anio", anio);
            startActivity(intent);*/
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    static  EditText text;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_escribe_comentario);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        reference=this;
        setTitle(getString(R.string.escribir));
        Intent intent = getIntent();
        dia = intent.getIntExtra("dia",0);
        mes = intent.getIntExtra("mes",0);
        anio = intent.getIntExtra("anio",0);
        text = (EditText)findViewById(R.id.textoMensaje);
        text.requestFocus();
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(text, InputMethodManager.SHOW_IMPLICIT);

      /*  FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });*/
    }

}

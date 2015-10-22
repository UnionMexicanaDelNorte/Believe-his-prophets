package creed.sus.profetas;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import java.io.UnsupportedEncodingException;
import android.support.design.widget.AppBarLayout;
import android.support.design.widget.CoordinatorLayout;

import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.util.Xml;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.DatePicker;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.gcm.GoogleCloudMessaging;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {
    GoogleCloudMessaging gcm;
    public String regid;
    public String PROJECT_NUMBER = "291300710119";


    public MainActivity reference;

    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        //return activeNetworkInfo != null && activeNetworkInfo.isConnected();
        return activeNetworkInfo != null && activeNetworkInfo.isConnectedOrConnecting();
    }

    private String loadAssetTextAsString(Context context, String name) {
        BufferedReader in = null;
        try {
            StringBuilder buf = new StringBuilder();
            InputStream is = context.getAssets().open(name);
            in = new BufferedReader(new InputStreamReader(is));

            String str;
            boolean isFirst = true;

            byte[] fileBytes=new byte[is.available()];
            is.read( fileBytes);
            String s = new String(fileBytes, "ISO-8859-1");
         return s;



        } catch (IOException e) {
            Log.e("error", "Error opening asset " + name);
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    Log.e("error", "Error closing asset " + name);
                }
            }
        }

        return null;
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        reference = this;

        SharedPreferences.Editor editor = getSharedPreferences("creedsusprofetas", MODE_PRIVATE).edit();
        editor.putInt("tamanoLetra", 17);
        editor.commit();

        final DatePicker datePicker = (DatePicker)findViewById(R.id.datePicker);

        ImageButton myButton = (ImageButton)findViewById(R.id.vesAlaLectura);
        myButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int m = datePicker.getMonth();
                int d = datePicker.getDayOfMonth();
                int y = datePicker.getYear();
                String mes = "";
                switch (m) {
                    case 0:
                        mes = "enero";
                        break;
                    case 1:
                        mes = "febrero";
                        break;
                    case 2:
                        mes = "marzo";
                        break;
                    case 3:
                        mes = "abril";
                        break;
                    case 4:
                        mes = "mayo";
                        break;
                    case 5:
                        mes = "junio";
                        break;
                    case 6:
                        mes = "julio";
                        break;
                    case 7:
                        mes = "agosto";
                        break;
                    case 8:
                        mes = "septiembre";
                        break;
                    case 9:
                        mes = "octubre";
                        break;
                    case 10:
                        mes = "noviembre";
                        break;
                    case 11:
                        mes = "diciembre";
                        break;
                    default:
                        break;
                }
                String nombreDelArchivo = mes + d + "y" + y + ".txt";
                String texto = loadAssetTextAsString(reference, nombreDelArchivo);
                if (texto != null && !texto.equals("")) {
                    try {
                        String encoded = new String(texto.toString().getBytes("ISO-8859-1"), "ISO-8859-1");

                        Intent intent = new Intent(MainActivity.this, TextoActivity.class);
                        intent.putExtra("texto", texto);
                        startActivity(intent);
                    } catch (UnsupportedEncodingException e) {
                        // mostrar el error al usuario o en un log
                    }

                } else {
                    //try read from internet
                    StringBuilder total = new StringBuilder();

                    try {
                        DefaultHttpClient httpclient = new DefaultHttpClient();
                        HttpGet httppost = new HttpGet("http://unionnorte.org/bhp/l/" + nombreDelArchivo);
                        HttpResponse response = httpclient.execute(httppost);
                        HttpEntity ht = response.getEntity();

                        BufferedHttpEntity buf = new BufferedHttpEntity(ht);

                        InputStream is = buf.getContent();


                        BufferedReader r = new BufferedReader(new InputStreamReader(is));

                        String line;
                        while ((line = r.readLine()) != null) {
                            total.append(line + "\n");
                        }

                    } catch (IOException e) {
                        // mostrar el error al usuario o en un log
                    }
                    try {
                        String encoded = new String(total.toString().getBytes("ISO-8859-1"), "ISO-8859-1");
                        Intent intent = new Intent(MainActivity.this, TextoActivity.class);
                        intent.putExtra("texto", encoded);
                        startActivity(intent);
                    } catch (UnsupportedEncodingException e) {
                        // mostrar el error al usuario o en un log
                    }

                }


            }
        });


        SharedPreferences prefs = getSharedPreferences("creedsusprofetas", MODE_PRIVATE);
        int primeraVez = prefs.getInt("primeraVez", 0);
        if(primeraVez==0)
        {
            getRegId();
        }





    }



    public void getRegId(){
        new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                String msg = "";
                try {
                    if (gcm == null) {
                        gcm = GoogleCloudMessaging.getInstance(getApplicationContext());
                    }
                    regid = gcm.register(PROJECT_NUMBER);

                    msg = "Device registered, registration ID=" + regid;
                    Log.i("GCM", msg);

                } catch (IOException ex) {
                    msg = "Error :" + ex.getMessage();

                }
                return msg;
            }

            @Override
            protected void onPostExecute(String msg) {
               // etRegId.setText(msg + "\n");
                if(isNetworkAvailable())
                {
                    try {
                        hazPost(regid);
                    }
                    catch (Exception e)
                    {

                    }

                } else {
                    new AlertDialog.Builder(reference)
                            .setTitle("Internet error")
                            .setMessage("No esta disponible una conexión a internet, por favor, conectese a internet para continuar.")
                            .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    // continue with delete
                                }
                            })
                            .setIcon(android.R.drawable.ic_dialog_alert)
                            .show();
                }

            }
        }.execute(null, null, null);
    }
    private void hazPost(final String argumento2)
    {
        Toast.makeText(getBaseContext(),
                "Please wait, connecting to server.",
                Toast.LENGTH_SHORT).show();


        // Create Inner Thread Class
        Thread background = new Thread(new Runnable() {


            // After call for background.start this run method call
            public void run() {
                try {

                    String  urlString = new String("http://sunplus.redirectme.net:90/?accion=6&argumento1="+argumento2+"&argumento2=2");
                    Log.i("GCM",urlString);
                    URL url = new URL(urlString);
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();

                    try {
                        InputStream in = new BufferedInputStream(urlConnection.getInputStream());
                        // Acciones a realizar con el flujo de datos
                        BufferedReader streamReader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                        StringBuilder responseStrBuilder = new StringBuilder();

                        String inputStr;
                        while ((inputStr = streamReader.readLine()) != null)
                            responseStrBuilder.append(inputStr);
                        JSONObject test = new JSONObject(responseStrBuilder.toString());

                        String success = test.getString("success");
                        if(success.equals("1"))
                        {
                            SharedPreferences.Editor editor = getSharedPreferences("creedsusprofetas", MODE_PRIVATE).edit();
                            editor.putInt("primeraVez",1);
                            editor.commit();
                        }

                     /*   reference.runOnUiThread(new Runnable() {
                            public void run() {

                            }
                        });
*/


                    }
                    catch (Exception e)
                    {
                        Log.i("Animation", e.toString());

                    }
                    finally {
                        urlConnection.disconnect();
                    }


                } catch (Throwable t) {
                    // just end the background thread
                    Log.i("Animation", "Thread  exception " + t);
                }
            }

            private void threadMsg(String msg) {

                if (!msg.equals(null) && !msg.equals("")) {
                    Message msgObj = handler.obtainMessage();
                    Bundle b = new Bundle();
                    b.putString("message", msg);
                    msgObj.setData(b);
                    handler.sendMessage(msgObj);
                }
            }

            // Define the Handler that receives messages from the thread and update the progress
            private final Handler handler = new Handler() {

                public void handleMessage(Message msg) {

                    String aResponse = msg.getData().getString("message");

                    if ((null != aResponse)) {

                        // ALERT MESSAGE
                        Toast.makeText(
                                getBaseContext(),
                                "Server Response: "+aResponse,
                                Toast.LENGTH_SHORT).show();
                    }
                    else
                    {

                        // ALERT MESSAGE
                        Toast.makeText(
                                getBaseContext(),
                                "Not Got Response From Server.",
                                Toast.LENGTH_SHORT).show();
                    }

                }
            };

        });
        // Start Thread
        background.start();
    }


}

package creed.sus.profetas;


import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SeekBar;
import android.widget.TextView;

import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.login.LoginResult;
import com.facebook.login.widget.LoginButton;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class TabFragment2 extends Fragment {

    public static CallbackManager callbackManager;

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        callbackManager.onActivityResult(requestCode, resultCode, data);
    }
    private void sendPost(String idaa, String nameaa) throws Exception {

        //Your server URL
        String url = "http://unionnorte.org/bhp/bhp.php";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        //add reuqest header
        con.setRequestMethod("POST");
        //con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

        //Request Parameters you want to send
        String urlParameters = "servicio=nombres&accion=save&idF="+idaa+"&name="+nameaa;

        // Send post request
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
        if(success.equals("1")) {
        }
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View V = inflater.inflate(R.layout.fragment_tab_fragment2, container, false);
        final TabFragment2 reference = this;

        final TextView conectadoComo = (TextView)V.findViewById(R.id.conectadoComo);

        callbackManager = CallbackManager.Factory.create();


        LoginButton loginButton = (LoginButton) V.findViewById(R.id.login_button);


        loginButton.setReadPermissions("public_profile");
        // If using in a fragment
        loginButton.setFragment(this);
        loginButton.registerCallback(callbackManager, new FacebookCallback<LoginResult>() {
            @Override
            public void onSuccess(LoginResult loginResult) {
                GraphRequest request = GraphRequest.newMeRequest(
                        loginResult.getAccessToken(),
                        new GraphRequest.GraphJSONObjectCallback() {
                            @Override
                            public void onCompleted(
                                    JSONObject object,
                                    GraphResponse response) {
                                // Application code
                                try{
                                    final String ida = object.get("id").toString();
                                    final String namea = object.get("name").toString();
                                    SharedPreferences.Editor editor = reference.getActivity().getSharedPreferences("creedsusprofetas", reference.getActivity().MODE_PRIVATE).edit();
                                    editor.putString("id",ida);
                                    conectadoComo.setText(getString(R.string.conectado) + namea);
                                    editor.putString("name", namea);
                                    editor.commit();

                                    Thread background = new Thread(new Runnable() {
                                        public void run() {
                                            try {
                                                sendPost(ida,namea);
                                                /*
                                                String  urlString = new String("http://unionnorte.org/bhp/bhp.php");
                                                URL url = new URL(urlString);

                                                JSONObject jsonObject = new JSONObject();
                                                jsonObject.put("servicio", "nombres");
                                                jsonObject.put("accion", "save");

                                                jsonObject.put("id", id);
                                                jsonObject.put("name", name);
                                                String message = jsonObject.toString();

                                                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();

                                                urlConnection.setReadTimeout(10000 );
                                                urlConnection.setConnectTimeout(15000 );

                                                urlConnection.setRequestMethod("POST");
                                                urlConnection.setDoInput(true);
                                                urlConnection.setDoOutput(true);
                                                urlConnection.setFixedLengthStreamingMode(message.getBytes().length);
                                                urlConnection.setRequestProperty("Connection", "Keep-Alive");
                                                urlConnection.setRequestProperty("Content-Type", "application/json;charset=utf-8");
                                               // urlConnection.setRequestProperty("X-Requested-With", "XMLHttpRequest");

                                                InputStream in=null;
                                                BufferedOutputStream os=null;
                                                try {


                                                    //setup send
                                                    os = new BufferedOutputStream(urlConnection.getOutputStream());
                                                    os.write(message.getBytes());
                                                    //clean up
                                                    os.flush();

                                                    //open
                                                    urlConnection.connect();

                                                    int aver5 = urlConnection.getResponseCode();


                                                    in = new BufferedInputStream(urlConnection.getInputStream());
                                                    BufferedReader streamReader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                                                    StringBuilder responseStrBuilder = new StringBuilder();
                                                    String inputStr;
                                                    while ((inputStr = streamReader.readLine()) != null)
                                                        responseStrBuilder.append(inputStr);
                                                    JSONObject test = new JSONObject(responseStrBuilder.toString());
                                                    String success = test.getString("success");
                                                    if(success.equals("1")) {


                                                    }
                                                }
                                                catch (Exception e)
                                                {
                                                    String aver = e.toString();
                                                    int gato = 5;
                                                }
                                                finally {
                                                    try {
                                                        os.close();
                                                        in.close();
                                                    } catch (IOException e) {
                                                        e.printStackTrace();
                                                    }
                                                    urlConnection.disconnect();
                                                }
                                                */
                                            } catch (Throwable t) {
                                              //  String aver2 = t.toString();
                                            //    int perro = 6;
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
                                        private final Handler handler = new Handler() {

                                            public void handleMessage(Message msg) {
                                                String aResponse = msg.getData().getString("message");
                                                if ((null != aResponse)) {
                                                }
                                                else
                                                {
                                                }
                                            }
                                        };
                                    });
                                    background.start();






                                }
                                catch (JSONException ex)
                                {

                                }
                                Log.v("LoginActivity", response.toString());
                            }
                        });
                Bundle parameters = new Bundle();
                parameters.putString("fields", "id,name");
                request.setParameters(parameters);
                request.executeAsync();
            }

            @Override
            public void onCancel() {
                // App code
          //      Log.v("LoginActivity", "cancel");

            }

            @Override
            public void onError(FacebookException exception) {
                // App code
        //        Log.v("LoginActivity", exception.getCause().toString());

            }
        });

        final TextView asiTexto = (TextView) V.findViewById(R.id.asiSeVera);

        final TextView cadaSegundosLabel = (TextView)V.findViewById(R.id.cadaSegundosLabel);

        final TextView cadaPalabras = (TextView)V.findViewById(R.id.cadaPalabras);

        final TextView cadaPalabrassLabel = (TextView)V.findViewById(R.id.cadaPalabrassLabel);

        SeekBar asiSeVera = (SeekBar) V.findViewById(R.id.asiSeVeraSeek);

        final SeekBar cadaSegundos = (SeekBar) V.findViewById(R.id.cadaSegundos);

        SeekBar cadaPalabrasSeek = (SeekBar) V.findViewById(R.id.cadaPalabrasSeek);

        SharedPreferences prefs = this.getActivity().getSharedPreferences("creedsusprofetas", this.getActivity().MODE_PRIVATE);
        int font = prefs.getInt("font", 0);
        String name = prefs.getString("name","").toString();
        if(name.equals(""))
        {
            conectadoComo.setText("");
        }
        else
        {
            conectadoComo.setText(getString(R.string.conectado)+name);
        }
        font=font-12;
        asiSeVera.setProgress(font);


        int segundos = prefs.getInt("segundos", 0);
        int palabras = prefs.getInt("palabras", 0);

        cadaPalabrasSeek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                if (i > 0) {

                    cadaPalabrassLabel.setText("" + i + " " + getString(R.string.palabras_cada) + " cada " + cadaSegundos.getProgress() + " " + getString(R.string.segundos));
                } else {
                    cadaPalabrassLabel.setText(getString(R.string.desactivado));
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                int palabras = seekBar.getProgress();
                SharedPreferences.Editor editor = reference.getActivity().getSharedPreferences("creedsusprofetas", reference.getActivity().MODE_PRIVATE).edit();
                editor.putInt("palabras", palabras);
                editor.commit();
            }
        });
        cadaSegundos.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                if(i>0)
                {
                    cadaSegundosLabel.setText(getString(R.string.cada)+" "+i+" "+getString(R.string.segundos));
                    cadaPalabras.setText(getString(R.string.cada_uno)+" "+cadaSegundos.getProgress()+" "+getString(R.string.cada_dos) );
                }
                else
                {
                    cadaSegundosLabel.setText(getString(R.string.desactivado));
                }

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                int segundos = seekBar.getProgress();
                SharedPreferences.Editor editor = reference.getActivity().getSharedPreferences("creedsusprofetas", reference.getActivity().MODE_PRIVATE).edit();
                editor.putInt("segundos", segundos);
                editor.commit();
            }
        });

        asiSeVera.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            int progress = 0;
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                int font = i+12;//min font 12
                asiTexto.setTextSize(font);



            }
            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                //textView.setText("Covered: " + progress + "/" + seekBar.getMax());
                int font = seekBar.getProgress()+12;//min font 12
                SharedPreferences.Editor editor = reference.getActivity().getSharedPreferences("creedsusprofetas", reference.getActivity().MODE_PRIVATE).edit();
                editor.putInt("font", font);
                editor.commit();
            }
        });
        cadaSegundos.setProgress(segundos);
        cadaPalabrasSeek.setProgress(palabras);






        return V;
    }
}
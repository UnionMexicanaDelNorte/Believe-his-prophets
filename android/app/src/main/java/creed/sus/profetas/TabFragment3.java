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
import android.os.Handler;
import android.os.Message;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

public class TabFragment3 extends Fragment {
    public DBHelper mydb;
    static ProgressDialog progress;
    static ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
    static TabFragment3 reference;

    private void deleteAll(final String idaa) throws Exception {

        //Your server URL
        String url = "http://unionnorte.org/bhp/bhp.php";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        String urlParameters = "servicio=post&accion=delete&idF="+idaa;
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
            list = mydb.getAllFavoritos();//se actualiza
            int i,cuantos = 0;
            for(i=0;i<list.size();i++)
            {
                HashMap<String,String> temp = list.get(i);
                String texto = Uri.encode(temp.get("todo"));
                String timestamp = temp.get("timestamp");
                String fecha = temp.get("title");
                //post
                String url2 = "http://unionnorte.org/bhp/bhp.php";
                URL obj2 = new URL(url2);
                HttpURLConnection con2 = (HttpURLConnection) obj2.openConnection();
                con2.setRequestMethod("POST");
                String urlParameters2 = "servicio=post&accion=save&idF="+idaa+"&texto="+texto+"&fecha="+fecha+"&timestamp="+timestamp;
                con2.setDoOutput(true);// Should be part of code only for .Net web-services else no need for PHP
                DataOutputStream wr2 = new DataOutputStream(con2.getOutputStream());
                wr2.writeBytes(urlParameters2);
                wr2.flush();
                wr2.close();
                int responseCode2 = con2.getResponseCode();
                BufferedReader in2 = new BufferedReader(
                        new InputStreamReader(con2.getInputStream()));
                String inputLine2;
                StringBuffer response2 = new StringBuffer();

                while ((inputLine2 = in2.readLine()) != null) {
                    response2.append(inputLine2);
                }
                in2.close();
                JSONObject test2 = new JSONObject(response2.toString());
                String success2 = test2.getString("success");
                if(success2.equals("1")) {
                    cuantos++;
                }
            }
            if(cuantos==list.size())
            {
                getActivity().runOnUiThread(new Runnable() {
                    public void run() {
                        progress.dismiss();
                        new AlertDialog.Builder(getContext())
                                .setTitle(getString(R.string.bookmark))
                                .setMessage(getString(R.string.puedes_abrir) + " http://unionnorte.org/bhp/view.php?idF=" + idaa)
                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        String url3 = "http://unionnorte.org/bhp/view.php?idF=" + idaa;
                                        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url3));
                                        startActivity(browserIntent);
                                    }
                                }).setNegativeButton(android.R.string.cancel, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                // continue with delete
                            }
                        }).setIcon(android.R.drawable.ic_dialog_alert)
                                .show();

                    }
                });

            }

            //db obtiene todos
            //ppara cada uno
        }
    }
    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) reference.getActivity().getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        //return activeNetworkInfo != null && activeNetworkInfo.isConnected();
        return activeNetworkInfo != null && activeNetworkInfo.isConnectedOrConnecting();
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View V = inflater.inflate(R.layout.fragment_tab_fragment3, container, false);
        reference = this;

        mydb = new DBHelper(getContext());
        list = mydb.getAllFavoritos();

        ListView listView = (ListView)V.findViewById(R.id.listViewFavoritos);
        SimpleAdapter adapter = new SimpleAdapter(
                getContext(),
                list,
                R.layout.mylist,
                new String[] {"title","subtitle"},
                new int[] {R.id.Itemname, R.id.SubItemname}
        );

        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> av, View view, int i, long l) {
                HashMap<String, String> temp = list.get(i);

                String todo = temp.get("todo");
                Intent intent = new Intent(getContext(), TextoActivity.class);
                intent.putExtra("texto", todo);
                startActivity(intent);
                // / Toast.makeText(Activity.this, "myPos " + i, Toast.LENGTH_LONG).show();
            }
        });
        FloatingActionButton fab = (FloatingActionButton) V.findViewById(R.id.sincro);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, getString(R.string.libreta_virtual), Snackbar.LENGTH_LONG).setAction(getString(R.string.generar), new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {

                        SharedPreferences prefs = getActivity().getSharedPreferences("creedsusprofetas", getActivity().MODE_PRIVATE);
                       final String id = prefs.getString("id", "").toString();
                        if (id.equals("")) {
                            new AlertDialog.Builder(getContext())
                                    .setTitle(getString(R.string.internet_error))
                                    .setMessage(getString(R.string.primero_conectate))
                                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            // continue with delete
                                        }
                                    })
                                    .setIcon(android.R.drawable.ic_dialog_alert)
                                    .show();
                        } else {

                            progress = new ProgressDialog(getContext());
                            progress.setTitle(getString(R.string.loading));
                            progress.setMessage(getString(R.string.espera));
                            progress.show();
                            // SharedPreferences prefs = getActivity().getSharedPreferences("creedsusprofetas", getActivity().MODE_PRIVATE);
                            Thread background = new Thread(new Runnable() {
                                public void run() {
                                    try {
                                        deleteAll(id);
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }
                                }
                                });

                            background.start();
                                }
                            }
                        }).show();
                    }
                });
        return V;
    }
}
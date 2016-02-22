package creed.sus.profetas;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

public class TabFragment1 extends Fragment {
    static final ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();

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
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View V = inflater.inflate(R.layout.fragment_tab_fragment1, container, false);

        Calendar c = Calendar.getInstance();
        int mesActual = c.get(Calendar.MONTH)+1;
        int anoActual = c.get(Calendar.YEAR);
        int diaActual = c.get(Calendar.DAY_OF_MONTH);

        int idioma =0;
        String idi = getString(R.string.idioma);
        if(idi.equals("Español"))
        {
            idioma=1;//español
        }
        else
        {
            if (idi.equals("English"))
            {
                idioma=2;//English
            }
            else
            {
                if (idi.equals("French"))
                {
                    idioma = 3;//Frances
                }
            }
        }
        final List<String> nombres = new ArrayList<String>();

        String mesS="", mesM="",nombreArchivo="";
        int anio,mes,dia;
        final List<String> titulos = new ArrayList<String>();
        List<String> subtitulos = new ArrayList<String>();

        for(anio=anoActual;anio>=2016;anio--)
        {
            for (mes=mesActual; mes>=1; mes--)
            {
                if(idioma==1)
                {
                    switch (mes) {
                        case 1:
                            mesS="enero";
                            mesM="Enero";
                            break;
                        case 2:
                            mesS="febrero";
                            mesM="Febrero";
                            break;
                        case 3:
                            mesS="marzo";
                            mesM="Marzo";
                            break;
                        case 4:
                            mesS="abril";
                            mesM="Abril";
                            break;
                        case 5:
                            mesS="mayo";
                            mesM="Mayo";
                            break;
                        case 6:
                            mesS="junio";
                            mesM="Junio";
                            break;
                        case 7:
                            mesS="julio";
                            mesM="Julio";
                            break;
                        case 8:
                            mesS="agosto";
                            mesM="Agosto";
                            break;
                        case 9:
                            mesS="septiembre";
                            mesM="Septiembre";
                            break;
                        case 10:
                            mesS="octubre";
                            mesM="Octubre";
                            break;
                        case 11:
                            mesS="noviembre";
                            mesM="Noviembre";
                            break;
                        case 12:
                            mesS="diciembre";
                            mesM="Diciembre";
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    if(idioma==2)
                    {
                        switch (mes) {
                            case 1:
                                mesS="january";
                                mesM="January";
                                break;
                            case 2:
                                mesS="february";
                                mesM="February";
                                break;
                            case 3:
                                mesS="march";
                                mesM="March";
                                break;
                            case 4:
                                mesS="april";
                                mesM="April";
                                break;
                            case 5:
                                mesS="may";
                                mesM="May";
                                break;
                            case 6:
                                mesS="june";
                                mesM="June";
                                break;
                            case 7:
                                mesS="july";
                                mesM="July";
                                break;
                            case 8:
                                mesS="august";
                                mesM="August";
                                break;
                            case 9:
                                mesS="september";
                                mesM="September";
                                break;
                            case 10:
                                mesS="october";
                                mesM="October";
                                break;
                            case 11:
                                mesS="november";
                                mesM="November";
                                break;
                            case 12:
                                mesS="december";
                                mesM="December";
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        if (idioma==3)
                        {
                            switch (mes) {
                                case 1:
                                    mesS="janvier";
                                    mesM="Janvier";
                                    break;
                                case 2:
                                    mesS="fevrier";
                                    mesM="Fevrier";
                                    break;
                                case 3:
                                    mesS="mars";
                                    mesM="Mars";
                                    break;
                                case 4:
                                    mesS="avril";
                                    mesM="Avril";
                                    break;
                                case 5:
                                    mesS="mai";
                                    mesM="Mai";
                                    break;
                                case 6:
                                    mesS="juin";
                                    mesM="Juin";
                                    break;
                                case 7:
                                    mesS="juillet";
                                    mesM="Juillet";
                                    break;
                                case 8:
                                    mesS="aout";
                                    mesM="Aout";
                                    break;
                                case 9:
                                    mesS="septembre";
                                    mesM="Septembre";
                                    break;
                                case 10:
                                    mesS="octobre";
                                    mesM="Octobre";
                                    break;
                                case 11:
                                    mesS="novembre";
                                    mesM="Novembre";
                                    break;
                                case 12:
                                    mesS="decembre";
                                    mesM="Decembre";
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }



                for(dia=diaActual;dia>=1;dia--)
                {
                    if(idioma==1)
                    {
                        nombreArchivo = mesS+dia+"y"+anio+".txt";
                    }
                    else
                    {
                        if(idioma==2)
                        {
                            nombreArchivo = mesS+dia+"y"+anio+"_en.txt";
                        }
                        else
                        {
                            if(idioma==3)
                            {
                                nombreArchivo = mesS+dia+"y"+anio+"_fr.txt";
                            }
                        }
                    }
                    nombres.add(nombreArchivo);

                    String texto = loadAssetTextAsString(getContext(), nombreArchivo);
                    if (texto != null && !texto.equals("")) {
                        try {
                            String encoded = new String(texto.toString().getBytes("ISO-8859-1"), "ISO-8859-1");
                            String[] separated = texto.split("\n");

                            String tit = separated[2].toLowerCase();
                            tit = tit.substring(0,1).toUpperCase()+tit.substring(1);
                            String sub = separated[4].toLowerCase();
                            sub = sub.substring(0,1).toUpperCase()+sub.substring(1);

                            titulos.add(tit);
                            subtitulos.add(sub);

                           // Intent intent = new Intent(MainActivity.this, TextoActivity.class);
                            //intent.putExtra("texto", texto);
                            //startActivity(intent);
                        } catch (UnsupportedEncodingException e) {
                            // mostrar el error al usuario o en un log
                        }

                    } else {
                        //try read from internet
                        StringBuilder total = new StringBuilder();

                        try {

                            URL url = new URL("http://unionnorte.org/bhp/l/" + nombreArchivo);
                            HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
                            int responseCode = httpConn.getResponseCode();
                            InputStream inputStream = httpConn.getInputStream();
                            BufferedReader r = new BufferedReader(new InputStreamReader(inputStream));

                            // always check HTTP response code first
                            if (responseCode == HttpURLConnection.HTTP_OK) {

                                String line;
                                while ((line = r.readLine()) != null) {
                                    total.append(line + "\n");
                                }

                                //int bytesRead = -1;
                                // byte[] buffer = new byte[BUFFER_SIZE];
                                // while ((bytesRead = inputStream.read(buffer)) != -1) {
                                //       outputStream.write(buffer, 0, bytesRead);
                                //}

                                // outputStream.close();
                            }
                            else {
                                new AlertDialog.Builder(getContext())
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

                            inputStream.close();


                        } catch (IOException e) {
                            // mostrar el error al usuario o en un log
                        }
                        try {
                            String encoded = new String(total.toString().getBytes("ISO-8859-1"), "ISO-8859-1");


                            String[] separated = encoded.split("\n");

                            String tit = separated[2].toLowerCase();
                            tit = tit.substring(0,1).toUpperCase()+tit.substring(1);
                            String sub = separated[4].toLowerCase();
                            sub = sub.substring(0,1).toUpperCase()+sub.substring(1);

                            titulos.add(tit);
                            subtitulos.add(sub);

                            // Intent intent = new Intent(MainActivity.this, TextoActivity.class);
                            //intent.putExtra("texto", encoded);
                            //startActivity(intent);
                        } catch (UnsupportedEncodingException e) {
                            // mostrar el error al usuario o en un log
                        }

                    }
                }
            }
        }
        int i=0;
        for (i=0;i<titulos.size();i++)
        {
            String tit =     titulos.get(i);
            String sub =     subtitulos.get(i);
            HashMap<String,String> temp = new HashMap<String,String>();
            temp.put("title",tit);
            temp.put("subtitle",sub);
            list.add(temp);
        }
        ListView listView = (ListView)V.findViewById(R.id.listViewLecturas);
        SimpleAdapter adapter = new SimpleAdapter(
                getContext(),
                list,
                R.layout.mylist,
                new String[] {"title","subtitle"},
                new int[] {R.id.Itemname, R.id.SubItemname}
        );

        listView.setAdapter(adapter);


        listView.setOnItemClickListener(   new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> av, View view, int i, long l) {
                String name = nombres.get(i);
                String tit = titulos.get(i);
                Intent intent = new Intent(getContext(), LecturaActivity.class);
                intent.putExtra("name", name);
                intent.putExtra("tit", tit);
                startActivity(intent);
               // / Toast.makeText(Activity.this, "myPos " + i, Toast.LENGTH_LONG).show();
            }
        });

        // Assign adapter to ListView

        return V;
    }
}
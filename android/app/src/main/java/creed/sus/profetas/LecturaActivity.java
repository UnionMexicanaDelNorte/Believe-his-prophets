package creed.sus.profetas;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.Layout;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.method.ScrollingMovementMethod;
import android.text.style.BackgroundColorSpan;
import android.text.style.StyleSpan;
import android.util.Log;
import android.view.ActionMode;
import android.view.View;
import android.widget.ScrollView;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

import android.view.Menu;
import android.view.MenuItem;
import android.view.MenuInflater;
import android.text.style.CharacterStyle;

public class LecturaActivity extends AppCompatActivity {
static ScrollView scroll;
    static long segundos, palabras;
    static int startPos;
    static Timer timer;
    public void rellena(String texto)
    {
        ArrayList<String> favs =  mydb.getAllFavoritosDeUnDia(dia, mes, anio);
        int i=0;
        Spannable spanText = Spannable.Factory.getInstance().newSpannable(texto);

        for(i=0;i<favs.size();i++)
        {
            String fav = favs.get(i);
            int selStart = texto.lastIndexOf(fav);
            int selEnd = fav.length();
            spanText.setSpan(new BackgroundColorSpan(0xFFFFFF00), selStart, selStart+selEnd, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        }

        SharedPreferences prefs = getSharedPreferences("creedsusprofetas", MODE_PRIVATE);
        int font = prefs.getInt("font", 0);
        textview.setTextSize(font);
        textview.setText(spanText);


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
    public int dia, mes, anio;
    public DBHelper mydb;
    public static LecturaActivity reference;
    public static final int DEFINITION = 2352323;
    public static TextView textview;
    @Override
    protected void onStop()
    {
        super.onStop();
        if(timer!=null)
        {
            timer.cancel();
        }

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lectura);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        reference=this;
        scroll = (ScrollView) findViewById(R.id.scrollViewLectura);
        mydb = new DBHelper(this);
        //final TextView
                textview = (TextView)findViewById(R.id.lectura);
        SharedPreferences prefs = getSharedPreferences("creedsusprofetas", MODE_PRIVATE);
        segundos = prefs.getInt("segundos", 0);
        palabras = prefs.getInt("palabras", 0);
        Intent intent = this.getIntent();
        startPos=0;
        setTitle(intent.getStringExtra("tit"));


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




        //textview.setCustomSelectionActionModeCallback(new StyleCallback(textview));
        String texto = loadAssetTextAsString(this, nombreArchivo);
        if (texto != null && !texto.equals("")) {


            rellena(texto);
           // textview.setText(texto);

        }
        else
        {
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

                inputStream.close();

                rellena(total.toString());
                //textview.setText(total.toString());

            } catch (IOException e) {
                // mostrar el error al usuario o en un log
            }
        }
        //textview.setMovementMethod(new ScrollingMovementMethod());
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, getString(R.string.mensajes), Snackbar.LENGTH_LONG).setAction(getString(R.string.escribir), new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {

                        Intent intent = new Intent(reference, EscribeComentarioActivity.class);
                        intent.putExtra("dia", dia);
                        intent.putExtra("mes", mes);
                        intent.putExtra("anio", anio);
                        startActivity(intent);


                    }
                }).show();
            }
        });


        textview.setCustomSelectionActionModeCallback(new ActionMode.Callback() {
            @Override
            public boolean onCreateActionMode(ActionMode actionMode, Menu menu) {
                //MenuInflater inflater = actionMode.getMenuInflater();
                //inflater.inflate(R.menu.menu_select, menu);

                menu.add(0, DEFINITION, 0, getString(R.string.favorito)).setIcon(R.drawable.ic_action_book);

                return true;
            }

            @Override
            public boolean onPrepareActionMode(ActionMode actionMode, Menu menu) {
                menu.removeItem(android.R.id.selectAll);
                menu.removeItem(android.R.id.cut);
                menu.removeItem(android.R.id.copy);

                return true;
            }

            @Override
            public boolean onActionItemClicked(ActionMode actionMode, MenuItem menuItem) {

                switch (menuItem.getItemId()) {
                    case DEFINITION:
                        int min = 0;
                        int max = textview.getText().length();
                        if (textview.isFocused()) {
                            final int selStart = textview.getSelectionStart();
                            final int selEnd = textview.getSelectionEnd();

                            min = Math.max(0, Math.min(selStart, selEnd));
                            max = Math.max(0, Math.max(selStart, selEnd));
                        }
                        // Perform your definition lookup with the selected text
                        final CharSequence selectedText = textview.getText().subSequence(min, max);
                        //graba en bd!!
                        Long tsLong = System.currentTimeMillis() / 1000;
                        String ts = tsLong.toString();
                        if (mydb.insertFavorito(selectedText.toString(), "" + dia + "-" + mes + "-" + anio, ts)) {
                            rellena(textview.getText().toString());
                        } else {
                            //handle error
                        }
                        //Spannable spanText = Spannable.Factory.getInstance().newSpannable(textview.getText());
                        //spanText.setSpan(new BackgroundColorSpan(0xFFFFFF00), min, max, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
                        //textview.setText(spanText);
                        actionMode.finish();
                        return true;
                    default:
                        break;
                }
                return false;
            }

            @Override
            public void onDestroyActionMode(ActionMode actionMode) {
            }
        });

        if(segundos>0 && palabras>0)
        {
            timer = new Timer();

            timer.scheduleAtFixedRate(new TimerTask()
            {
                public void run()
                {
                    Layout layout = textview.getLayout();

                    scroll.scrollTo(0, layout.getLineTop(layout.getLineForOffset(startPos)));
                    startPos=startPos+((int)palabras*6);
                    //displayData();  // display the data
                }
            }, segundos*1000, segundos*1000);
        }
    }
}
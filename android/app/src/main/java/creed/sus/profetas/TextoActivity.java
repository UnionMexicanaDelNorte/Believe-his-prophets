package creed.sus.profetas;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

public class TextoActivity extends AppCompatActivity {
public String textoGlobal;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_texto);
        textoGlobal= getIntent().getStringExtra("texto");
        TextView textoView = (TextView)findViewById(R.id.textoView);
        textoView.setText(textoGlobal);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
       getMenuInflater().inflate(R.menu.menu_texto, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.compartir) {
            Intent sharingIntent = new Intent(Intent.ACTION_SEND);
            sharingIntent.setType("text/html");
            sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT,textoGlobal.substring(0,100)+ "... https://play.google.com/store/apps/details?id=creed.sus.profetas");
            startActivity(Intent.createChooser(sharingIntent, "Compartir"));
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

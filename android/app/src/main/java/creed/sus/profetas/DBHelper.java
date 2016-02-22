package creed.sus.profetas;

/**
 * Created by alonsopf on 11/01/16.
 */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.DatabaseUtils;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteDatabase;

public class DBHelper extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "BHP.db";
    public static final String CONTACTS_TABLE_NAME = "favoritos";
    public static final String CONTACTS_COLUMN_FECHA = "fecha";
    public static final String CONTACTS_COLUMN_TEXTO = "texto";
    public static final String CONTACTS_COLUMN_TIMESTAMP = "timestamp";
    private HashMap hp;

    public DBHelper(Context context)
    {
        super(context, DATABASE_NAME , null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // TODO Auto-generated method stub
        db.execSQL(
                "CREATE TABLE favoritos " +
                        "(texto text,fecha text, timestamp text)"
        );
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // TODO Auto-generated method stub
       // db.execSQL("DROP TABLE IF EXISTS favoritos");
        //onCreate(db);
    }

    public boolean insertFavorito  (String texto, String fecha, String timestamp)
    {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("texto", texto);
        contentValues.put("fecha", fecha);
        contentValues.put("timestamp", timestamp);
        db.insert("favoritos", null, contentValues);
        return true;
    }

    public Cursor getData(String fecha){
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "SELECT * FROM favoritos where fecha='"+fecha+"'", null );
        return res;
    }

    public int numberOfRows(){
        SQLiteDatabase db = this.getReadableDatabase();
        int numRows = (int) DatabaseUtils.queryNumEntries(db, CONTACTS_TABLE_NAME);
        return numRows;
    }

   /* public boolean updateContact (Integer id, String name, String phone, String email, String street,String place)
    {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", name);
        contentValues.put("phone", phone);
        contentValues.put("email", email);
        contentValues.put("street", street);
        contentValues.put("place", place);
        db.update("contacts", contentValues, "id = ? ", new String[] { Integer.toString(id) } );
        return true;
    }*/

    public Integer deleteAllContact ()
    {
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete("contacts",
                "",new String[]{ Integer.toString(0) });
    }

    public ArrayList<HashMap<String,String>> getAllFavoritos()
    {
        //ArrayList<String> array_list = new ArrayList<String>();
        ArrayList<HashMap<String,String>> array_list = new ArrayList<HashMap<String,String>>();
        //hp = new HashMap();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "SELECT * FROM favoritos order by timestamp desc", null );
        res.moveToFirst();

        while(res.isAfterLast() == false){

            HashMap<String,String> temp = new HashMap<String,String>();
            if(res.getString(res.getColumnIndex(CONTACTS_COLUMN_TEXTO)).length()>25  )
            {
                temp.put("subtitle",res.getString(res.getColumnIndex(CONTACTS_COLUMN_TEXTO)).substring(0,23)+"..");
            }
            else
            {
                temp.put("subtitle",res.getString(res.getColumnIndex(CONTACTS_COLUMN_TEXTO)));
            }
            temp.put("todo",res.getString(res.getColumnIndex(CONTACTS_COLUMN_TEXTO)));
            temp.put("timestamp",res.getString(res.getColumnIndex(CONTACTS_COLUMN_TIMESTAMP)));

            temp.put("title", res.getString(res.getColumnIndex(CONTACTS_COLUMN_FECHA)));
            array_list.add(temp);
            res.moveToNext();
        }
        return array_list;
    }

    public ArrayList<String> getAllFavoritosDeUnDia(int dia, int mes, int anio)
    {
        ArrayList<String> array_list = new ArrayList<String>();

        //hp = new HashMap();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "SELECT * FROM favoritos WHERE fecha = '"+dia+"-"+mes+"-"+anio+"'", null );
        res.moveToFirst();

        while(res.isAfterLast() == false){
            array_list.add(res.getString(res.getColumnIndex(CONTACTS_COLUMN_TEXTO)));
            res.moveToNext();
        }
        return array_list;
    }
}
package com.kyberheimen.model.dbmodel;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class DatabaseDefinitions extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "gym.db";
    public static final int DATABASE_VERSION = 1;

    public static final String TABLE_NAME = "item";
    public static final String COL_ID = "_id";
    public static final String COL_TITLE = "title";
    public static final String COL_NOTE = "note";
    public static final String COL_STATUS = "status";
    public static final String COL_DATE = "date";
    public static final String COL_TYPE = "type";

    public static String[] ALL_COLUMNS = {COL_ID, COL_TITLE, COL_NOTE, COL_STATUS, COL_DATE, COL_TYPE};

    enum Type {PROGRAM, EXERCISE, SET};

    public DatabaseDefinitions(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String create = "create table " + TABLE_NAME + "(";
        create += DbUtils.col(COL_ID, "integer primary key autoincrement", true);
        create += DbUtils.col(COL_TITLE, "text", true);
        create += DbUtils.col(COL_NOTE, "text", true);
        create += DbUtils.col(COL_STATUS, "text", true);
        create += DbUtils.col(COL_DATE, "integer", true);
        create += DbUtils.col(COL_TYPE, "text", false);
        create += ");";
        Log.i("Gym", "Create database:" + create);
        sqLiteDatabase.execSQL(create);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE_NAME IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }


}

package com.kyberheimen.model.dbmodel;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import com.kyberheimen.model.GymInterface;
import com.kyberheimen.model.GymModel;

import java.util.ArrayList;
import java.util.List;

public class DbProgram {

    private DatabaseDefinitions dbHelper;
    private SQLiteDatabase database;

    public DbProgram(Context context) {
        dbHelper = new DatabaseDefinitions(context);
    }

    public void open() throws SQLException {
        database = dbHelper.getWritableDatabase();
    }

    public void close() {
        dbHelper.close();
    }

    protected long createProgram(GymInterface.Program program) {

        long insertId = database.insert(DatabaseDefinitions.TABLE_NAME, null, toContentValues(program));
        program.setId(insertId);
        return insertId;
    }

    public void saveProgram(GymInterface.Program program) {
        if (program.getId() > 0)
            updateProgram(program);
        else
            createProgram(program);
    }

    private ContentValues toContentValues(GymInterface.Program program) {
        ContentValues v = new ContentValues();

        v.put(DatabaseDefinitions.COL_TITLE, program.getTitle());
        v.put(DatabaseDefinitions.COL_DATE, program.getDate());
        v.put(DatabaseDefinitions.COL_STATUS, program.getStatus().toString());
        v.put(DatabaseDefinitions.COL_NOTE, program.getNote());
        v.put(DatabaseDefinitions.COL_TYPE, DatabaseDefinitions.Type.PROGRAM.toString());
        return v;
    }

    public List<GymInterface.Program> getAllPrograms() {
        List<GymInterface.Program> programs = new ArrayList<GymInterface.Program>();
        Cursor cursor = database.query(DatabaseDefinitions.TABLE_NAME, DatabaseDefinitions.ALL_COLUMNS,
                DbUtils.selection(DatabaseDefinitions.COL_TYPE, DatabaseDefinitions.Type.PROGRAM.toString()),
                null, null, null, null);
        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            GymInterface.Program program = cursorToProgram(cursor);
            programs.add(program);
            cursor.moveToNext();
        }
        cursor.close();
        return programs;
    }

    protected long updateProgram(GymInterface.Program program) {
        return database.update(DatabaseDefinitions.TABLE_NAME, toContentValues(program), DbUtils.selection(DatabaseDefinitions.COL_ID, program.getId()), null);
    }

    public void deleteProgram(GymInterface.Program program) {
        database.delete(DatabaseDefinitions.TABLE_NAME, DbUtils.selection(DatabaseDefinitions.COL_ID, program.getId()), null);
    }

    public void deleteAllPrograms() {
        for (GymInterface.Program program : getAllPrograms()) {
            deleteProgram(program);
        }
    }

    private GymInterface.Program cursorToProgram(Cursor cursor) {
        GymInterface.Program program = new GymModel.ProgramImpl(cursor.getString(cursor.getColumnIndex(DatabaseDefinitions.COL_TITLE)));
        program.setId(cursor.getInt(cursor.getColumnIndex(DatabaseDefinitions.COL_ID)));
        program.setDate(cursor.getInt(cursor.getColumnIndex(DatabaseDefinitions.COL_DATE)));
        program.setNote(cursor.getString(cursor.getColumnIndex(DatabaseDefinitions.COL_NOTE)));
        program.setStatus(GymInterface.Status.valueOf(cursor.getString(cursor.getColumnIndex(DatabaseDefinitions.COL_STATUS))));
        return program;
    }

}

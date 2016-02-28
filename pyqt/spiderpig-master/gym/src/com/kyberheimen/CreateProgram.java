package com.kyberheimen;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import com.kyberheimen.model.GymInterface;
import com.kyberheimen.model.GymModel;
import com.kyberheimen.model.dbmodel.DbProgram;

public class CreateProgram extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.createprogram);

    }

    public void save(View view) {
        String title = ((EditText) findViewById(R.id.input_title)).getEditableText().toString();
        Log.i(Constants.LOG_TAG, "Save program " + title);
        DbProgram db = new DbProgram(this);
        db.open();
        GymModel.ProgramImpl p = new GymModel.ProgramImpl(title);
        db.saveProgram(p);
        db.close();
    }
}


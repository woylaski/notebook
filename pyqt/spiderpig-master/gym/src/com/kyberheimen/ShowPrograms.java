package com.kyberheimen;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import com.kyberheimen.model.GymModel;
import com.kyberheimen.model.GymInterface;
import com.kyberheimen.model.dbmodel.DbProgram;

import java.util.List;


public class ShowPrograms extends Activity {

    private final static String LOGTAG = Constants.PARAM_PROGRAM_ID;
    private DbProgram db;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        db = new DbProgram(this);
        db.open();

        setContentView(R.layout.showprograms);
        updateProgramView();

        ((Button) findViewById(R.id.button_create_program)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.i(Constants.LOG_TAG, "Create program");
                Intent createProgram = new Intent(getApplicationContext(), CreateProgram.class);
                startActivity(createProgram);
            }
        });
    }

    private void updateProgramView() {
        ListView programList = (ListView) findViewById(R.id.programList);

        final List<GymInterface.Program> programs = db.getAllPrograms();

        String[] programTitles =  new String[programs.size()];
        for (int i=0; i<programs.size(); i++) {
            programTitles[i] = programs.get(i).getId() + ": " + programs.get(i).getTitle();
        }

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_list_item_1, android.R.id.text1, programTitles);

        programList.setAdapter(adapter);
        programList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                showProgram(position);
            }
        });

    }

    private void showProgram(int position) {
        GymModel.Program program = db.getAllPrograms().get(position);
        Log.i(LOGTAG, "Clicked " + program.getTitle());
        Intent showProgram = new Intent(this, ShowProgram.class);
        showProgram.putExtra(Constants.PARAM_PROGRAM_ID, program.getId());
        startActivity(showProgram);
    }


}

package com.kyberheimen;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

public class ShowProgram extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.showprogram);

        if (getIntent().getLongExtra(Constants.PARAM_PROGRAM_ID, 0) > 0) {
            long id = getIntent().getLongExtra(Constants.PARAM_PROGRAM_ID, 0);
            Log.i(Constants.LOG_TAG, "Show program " + id);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
    }
}

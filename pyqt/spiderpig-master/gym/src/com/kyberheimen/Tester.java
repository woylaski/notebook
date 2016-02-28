package com.kyberheimen;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import com.kyberheimen.model.GymInterface.*;
import com.kyberheimen.model.GymModel;
import com.kyberheimen.model.dbmodel.DbProgram;

public class Tester extends Activity {

    private DbProgram db = new DbProgram(this);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        db.open();

        setContentView(R.layout.showprograms);

        testPersistence();
    }


    void showDatabase() {
        Log.w(Constants.LOG_TAG, "Showing programs");
        for (Program program : db.getAllPrograms()) {
            Log.w(Constants.LOG_TAG, "Retrieved program " + program.getTitle() + " / " + program.getId());
        }
    }

    private void testPersistence() {
        showDatabase();
    }

    private void makePrograms() {
        db.deleteAllPrograms();
        Program p = new GymModel.ProgramImpl("Test 1");
        db.saveProgram(p);
        showDatabase();
        p.setTitle("Test 2");
        db.saveProgram(p);
        showDatabase();
    }

    private void makeMyPrograms() {
        GymModel gym = new GymModel();
        Program a = createProgramA();

        gym.addTemplate(createProgramA());
        gym.addTemplate(createProgramB());
        Log.i(Constants.LOG_TAG, gym.toString());
    }

    private Program createProgramA() {
        GymModel.ExerciseImpl e2 = new GymModel.ExerciseImpl("Knebøy");
        e2.addEqualSets(100, 5, 3);

        GymModel.ExerciseImpl e1 = new GymModel.ExerciseImpl("Markløft");
        e1.addEqualSets(70, 5, 2);

        GymModel.ExerciseImpl e3 = new GymModel.ExerciseImpl("Benkpress");
        e3.addEqualSets(72.5f, 5, 3);

        GymModel.ExerciseImpl e4 = new GymModel.ExerciseImpl("Pull-ups");
        e4.addEqualSets(75, 8, 3);

        GymModel.ExerciseImpl e6 = new GymModel.ExerciseImpl("Spenstkasse");
        e6.addEqualSets(12, 3, 5);
        e6.setNote("Kasse+step");

        GymModel.ExerciseImpl e7 = new GymModel.ExerciseImpl("Sidehev");
        e7.addEqualSets(12, 3, 12);

        GymModel.ExerciseImpl e5 = new GymModel.ExerciseImpl("Planke");
        GymModel.ExerciseSetImpl set = new GymModel.ExerciseSetImpl();
        set.setDuration(3*60);
        e5.addSet(set);

        GymModel.ProgramImpl program1 = new GymModel.ProgramImpl("DbProgram dag 1");
        program1.setId(1);
        program1.addExercise(e1);
        program1.addExercise(e2);
        program1.addExercise(e3);
        program1.addExercise(e4);
        program1.addExercise(e5);
        program1.addExercise(e6);
        program1.addExercise(e7);

        return program1;
    }

    private Program createProgramB() {
        GymModel.ExerciseImpl e2 = new GymModel.ExerciseImpl("Knebøy");
        e2.addEqualSets(100, 5, 3);

        GymModel.ExerciseImpl e1 = new GymModel.ExerciseImpl("Markløft");
        e1.addEqualSets(70, 5, 2);

        GymModel.ExerciseImpl e5 = new GymModel.ExerciseImpl("Militærpress");
        e5.addEqualSets(20, 12, 3);

        GymModel.ExerciseImpl e6 = new GymModel.ExerciseImpl("Maloffpress");
        e6.addEqualSets(20, 12, 3);

        GymModel.ExerciseImpl e3 = new GymModel.ExerciseImpl("Benkpress");
        e3.addEqualSets(72.5f, 5, 3);

        GymModel.ExerciseImpl e4 = new GymModel.ExerciseImpl("Pull-ups");
        e4.addEqualSets(75, 8, 3);

        GymModel.ProgramImpl program1 = new GymModel.ProgramImpl("DbProgram dag 2");
        program1.setId(2);
        program1.addExercise(e1);
        program1.addExercise(e5);
        program1.addExercise(e6);
        program1.addExercise(e2);
        program1.addExercise(e3);
        program1.addExercise(e4);

        return program1;
    }
}

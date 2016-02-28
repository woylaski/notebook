package com.kyberheimen.model;

import java.util.Date;
import java.util.List;

public interface GymInterface {

    public List<Program> getProgramTemplates();
    public List<Program> getProgramResults();
    public void addTemplate(Program template);
    public void removeTemplate(Program template);
    public void addResult(Program result);
    public void removeResult(Program result);

    public enum Status {NOT_STARTED, DONE, CANCELLED}

    interface Program {
        long getId();
        void setId(long id);
        String getTitle();
        void setTitle(String title);
        List<Exercise> getExercises();
        String getNote();
        void setNote(String note);
        Status getStatus();
        void setStatus(Status status);
        int getDate();
        void setDate(int date);
        void addExercise(Exercise exercise);
        void removeExercise(Exercise exercise);
        void setPosition(Exercise exercise, int position);
    }

    interface Exercise {
        String getTitle();
        void setTitle(String title);
        String getNote();
        void setNote(String note);
        Status getStatus();
        void setStatus(Status status);
        List<Set> getSets();
        void addSet(Set set);
        void removeSet(Set set);
        void setPosition(Set set, int position);
    }

    interface Set {
        int getRepetitions();
        void setRepetitions(int repetitions);
        float getWeight();
        void setWeight(float weight);
        void setDuration(float seconds);
        float getDuration();
        String getNote();
        void setNote(String note);
        Status getStatus();
        void setStatus(Status status);
    }

}

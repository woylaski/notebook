package com.kyberheimen.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GymModel implements GymInterface {

    List<Program> templates = new ArrayList<Program>();
    List<Program> results = new ArrayList<Program>();

    @Override
    public List<Program> getProgramTemplates() {
        return templates;
    }

    @Override
    public List<Program> getProgramResults() {
        return results;
    }

    @Override
    public void addTemplate(Program template) {
        templates.add(template);
    }

    @Override
    public void removeTemplate(Program template) {
        templates.remove(template);
    }

    @Override
    public void addResult(Program result) {
        results.add(result);
    }

    @Override
    public void removeResult(Program result) {
        results.remove(result);
    }

    @Override
    public String toString() {
        String s = " \nDbProgram templates\n";
        for (Program program : templates) {
            s += program.toString() + "\n";
        }
        return s;
    }

    public static class ProgramImpl extends GeneralItem implements GymInterface.Program {

        private List<Exercise> exercises = new ArrayList<Exercise>();
        private int date;
        private long id;

        public long getId() {
            return id;
        }

        public void setId(long id) {
            this.id = id;
        }

        public ProgramImpl(String title) {
            setTitle(title);
        }

        @Override
        public List<Exercise> getExercises() {
            return exercises;
        }

        @Override
        public int getDate() {
            return date;
        }

        @Override
        public void setDate(int date) {
            this.date = date;
        }

        @Override
        public void addExercise(Exercise exercise) {
            exercises.add(exercise);
        }

        @Override
        public void removeExercise(Exercise exercise) {
            exercises.remove(exercise);
        }

        @Override
        public void setPosition(Exercise exercise, int position) {
            ListUtil.repositionElement(exercises, exercise, position);
        }

        public String toString() {
            String s = getTitle() + "\n";
            for (Exercise e : exercises) {
                s += e.toString() + "\n";
            }
            return s;
        }
    }

    public static class ExerciseImpl extends GeneralItem implements Exercise {

        private List<Set> sets = new ArrayList<Set>();

        public ExerciseImpl(String title) {
            setTitle(title);
        }

        @Override
        public List<Set> getSets() {
            return sets;
        }

        @Override
        public void addSet(Set set) {
            sets.add(set);
        }

        @Override
        public void removeSet(Set set) {
            sets.remove(set);
        }

        public void addSet(float weight, int repetitions) {
            ExerciseSetImpl set = new ExerciseSetImpl();
            set.setTitle(getTitle());
            set.setWeight(weight);
            set.setRepetitions(repetitions);
            addSet(set);
        }

        public void addEqualSets(float weight, int repetitions, int sets) {
            for (int i=0; i<sets; i++) {
                addSet(weight, repetitions);
            }
        }

        @Override
        public void setPosition(Set set, int position) {
            ListUtil.repositionElement(sets, set, position);
        }

        @Override
        public String toString() {
            String s = getTitle() + "\n";
            for (Set set : sets) {
                s += set.toString() + "\n";
            }
            return s;
        }
    }

    public static class ExerciseSetImpl extends GeneralItem implements Set {

        private int repetitions;
        private float weight;
        private String unit = "kg";

        public float getDuration() {
            return duration;
        }

        public void setDuration(float duration) {
            this.duration = duration;
        }

        private float duration;

        public int getRepetitions() {
            return repetitions;
        }

        public void setRepetitions(int repetitions) {
            this.repetitions = repetitions;
        }

        public float getWeight() {
            return weight;
        }

        public void setWeight(float weight) {
            this.weight = weight;
        }

        @Override
        public String toString() {
            String s = "";
            if (getWeight() > 0 && getRepetitions() > 0)
                s += getWeight() + " " + unit + " x " + getRepetitions();
            else if (getWeight() > 0)
                s += getWeight() + " " + unit;
            else if (getRepetitions() > 0)
                s += getRepetitions();

            if (getDuration() > 0)
                s += " " + getDuration() + " sec";

            return s;
        }
    }

    public static class GeneralItem implements Cloneable {
        private String note = "";
        private String title = "";
        private Status status = Status.NOT_STARTED;

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public Status getStatus() {
            return status;
        }

        public void setStatus(Status status) {
            this.status = status;
        }

        public String getNote() {
            return note;
        }

        public void setNote(String note) {
            this.note = note;
        }

        public String toString() {
            return getTitle() + " " + super.hashCode();
        }

        @Override
        public GeneralItem clone() {
            try {
                return (GeneralItem) super.clone();
            } catch (CloneNotSupportedException e) {
                return null;
            }
        }

        public static class ListUtil {
            public static void repositionElement(List list, Object element, int newPosition) {
                if (!list.contains(element))
                    return;

                list.remove(element);
                list.set(newPosition, element);
            }
        }
    }
}

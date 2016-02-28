package com.kyberheimen.model.dbmodel;

public abstract class DbUtils {

    public static String selection(String field, String value) {
        return field + "=\"" + value + "\"";
    }

    public static String selection(String field, long value) {
        return field + "=" + value;
    }

    public static String col(String columnName, String extra, boolean delimit) {
        return columnName + " " + extra + (delimit ? ", " : "");
    }
}

.pragma library
.import QtQuick.LocalStorage 2.0 as Sql
.import "ManuCore.js" as ManuCore

var db=null;
/*
  init database
 */
function openDB() {
    if(db != null) return;
    print('openDB()')
    db = Sql.LocalStorage.openDatabaseSync("ManuKnow", "1.0", "manuknow database", 100000);
}

function showTables(){
    openDB()
    var tables=[]
    try {
        db.transaction(function(tx){
            var res  = tx.executeSql("SELECT name FROM sqlite_master WHERE type='table' order by name");
            //print(res.rows.length)
            //print(res.rows.item)

            for(var i=0; i<res.rows.length; i++){
                //print(res.rows.item(i).name)
                //print(res.rows.item(i))
                //ManuCore.listProperty(res.rows.item(i))
                tables.push(res.rows.item(i).name)
            }
            return tables
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
        //ManuCore.listProperty(db)
        return tables;
    };

    return tables
}

/*
  create table, createTable(tablename, fieldinfo)
  like createTable("colors", "(name TEXT, value TEXT, desc TEXT)")
 */
function createTable(table, fields){
    if(arguments.length < 2){
        print("create table need 2 arg, (tablename, fieldinfo)")
        return
    }

    openDB()

    var tableTemplate="CREATE TABLE IF NOT EXISTS {0}{1}"
    var tableSqlStr=ManuCore.stringFormat(tableTemplate, table, fields)

    try{
        db.transaction( function(tx) {
            print("create table sql string: ", tableSqlStr)
            tx.executeSql(tableSqlStr)
        });
    } catch (err) {
        console.log("Error select from table in database: " + err);
    };
}

/*
  read database
  like , readFromDB("colors", "name, value", "1=1")
 */
function readFromDB(table, selectField, selectCondition)
{
    openDB()
    if(!db) { return; }

    var ret=null
    var selectTemplate="SELECT {0} from {1} where {2}"
    var selectSqlStr=ManuCore.stringFormat(selectTemplate, selectField, table, selectCondition)

    try {
        db.transaction( function(tx) {
            print("select sql string: ", selectSqlStr)
            var res=tx.executeSql(selectSqlStr)
            //for(var i = 0; i < rs.rows.length; i++) {
            //    var dbItem = rs.rows.item(i);
            //}
            console.log("select  " + res.rows.length + " items");
            ret = res.rows
        });
    } catch (err) {
        console.log("Error select from table in database: " + err);
        ret=null
    };

    return ret
}

/**
  saveToDB('color', "(?,?,?)", ['white','white','white color'])
  **/
function insertToDB(table, fields, values)
{
    var ret="Error"
    openDB()
    if(!db) { return ret}

    var insertTemplate="INSERT OR REPLACE INTO {0} VALUES{1}"
    var insertSqlStr=ManuCore.stringFormat(insertTemplate, table, fields)

    try {
        db.transaction( function(tx) {
            print("select sql string: ", insertSqlStr)
            var res=tx.executeSql(insertSqlStr, values)
            if (res.rowsAffected > 0) {
                ret = "OK";
            } else {
                ret = "Error";
            }
        });
    } catch (err) {
        console.log("Error insert to table in database: " + err);
        ret = "Error";
    };
    return ret
}

/**
  updateRecord('color', "(value=?,desc=?)", "name='white'", ['#112233','rgb color'])
  **/
function updateRecord(table, fields, condition, values)
{
    var ret="Error"
    openDB()
    if(!db) { return; }

    var updateTemplate="UPDATE {0}  set {1} where {2} "
    var updateSqlStr=ManuCore.stringFormat(updateTemplate, table, fields, condition)

    try {
        db.transaction( function(tx) {
            print("update sql string: ", updateSqlStr)
            var res=tx.executeSql(updateSqlStr, values)
            if (res.rowsAffected > 0) {
               ret = "OK";
            } else {
               ret = "Error";
            }
        });
    } catch (err) {
        console.log("Error update to table in database: " + err);
        ret = "Error";
    };

    return ret
}

/**
  deleteRecord('color', "key='primaryColor'")
  **/
function deleteRecord(table, condition)
{
    var ret="Error"
    openDB()
    if(!db) { return; }

    var deleteTemplate="DELETE FROM {0}  where {1} "
    var deleteSqlStr=ManuCore.stringFormat(deleteTemplate, table, condition)

    try {
        db.transaction( function(tx) {
            print("delete sql string: ", deleteSqlStr)
            var res=tx.executeSql(deleteSqlStr)
            if (res.rowsAffected > 0) {
               ret = "OK";
            } else {
               ret = "Error";
            }
        });
    } catch (err) {
        console.log("Error update to table in database: " + err);
        ret = "Error";
    };

    return ret
}

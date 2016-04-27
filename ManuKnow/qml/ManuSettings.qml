import QtQuick 2.5
import "js/ManuCore.js" as ManuCore
import "js/ManuLocalDB.js" as ManuLocalDB

pragma Singleton

Item {
    id: colorRoot
    property var table: "settings"
    property var fileds: ["key", "value"]
    property var settingVars: {}

    function createTable(){
        ManuLocalDB.createTable(table,  "(key TEXT UNIQUE, value TEXT)")
    }

    function loadAllSettings(){
        settingVars.clear()
        var result=ManuLocalDB.readFromDB(table, fileds.join(","), "1=1")
        for(var i=0; i<result.lenght(); i++){
            var key=result.item(i).key
            var value=result.item(i).value
            settingVars[key]=value
        }
    }

    function getSetting(key){
        var res=ManuLocalDB.readFromDB(table, "value", "key="+key)
        if(res.length()==0) return ""
        return res.item(0).value
    }

    function storeSetting(key, value){
        ManuLocalDB.insertToDB(table, "(?,?)", [key, value])
    }

    function updateSetting(key, value){
        ManuLocalDB.updateRecord(table, "(value=?)", "key="+key, [value])
    }

    function deleteSetting(key){
        ManuLocalDB.deleteRecord(table, "key="+key)
    }

    Component.onCompleted: {
        createTable()
        loadAllSettings()
    }
}

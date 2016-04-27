import QtQuick 2.5
import "js/ManuLocalDB.js" as ManuLocalDB

pragma Singleton

Item {
    id: colorRoot
    property var table: "color"
    property var fileds: ["name", "value"]
    property var colorVars: {}

    function createTable(){
        ManuLocalDB.createTable(table,  "(name TEXT, value TEXT)")
    }

    function loadColors(){
        var res=ManuLocalDB.readFromDB(table, fileds.join(","), "1=1")
        for(var i=0; i<result.lenght(); i++){
            var name=result.item(i).name
            var value=result.item(i).value
            colorVars[name]=value
        }
    }

    function getColor(name){
        var res=ManuLocalDB.readFromDB(table, "value", "name="+name)
        if(res.length()==0) return ""
        return res.item(0).value
    }

    function storeColor(name, value){
        ManuLocalDB.insertToDB(table, "(?,?)", [name, value])
    }

    function updateColor(key, value){
        ManuLocalDB.updateRecord(table, "(value=?)", "name="+name, [value])
    }

    function deleteColor(name){
        ManuLocalDB.deleteRecord(table, "name="+name)
    }

    Component.onCompleted: {
        createTable()
        loadColors()
    }
}

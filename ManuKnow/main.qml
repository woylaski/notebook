import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import manu.plugin 1.0
import "qml/js/ManuLocalDB.js" as ManuLocalDB
import "qml/js/ManuCore.js" as ManuCore
import "qml"

//https://www.kullo.net/blog/advanced-filedialog-in-qml/
ManuAppWindow {
    id: root

    //ManuScreenInfo{}
    Component.onCompleted: {
        print("dp is ", Units.dp, Units.multiplier)
        print("gridunit is ", Device.gridUnit)
        print("device type ", Device.formFactor)
        var tables=ManuLocalDB.showTables()
        print(tables.length)
        print(tables)
    }
}


/*
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1

Window {
    id: root

    visible: true

    width: 500
    height: 500

    Timer {
        id: timer
        interval: 0
        onTriggered: {
            fileSystemModel.folder = fileSystemModel.odd ? "file:///D:/" : "file:///C:/";
            fileSystemModel.odd = !fileSystemModel.odd;
            timer.start();
        }
    }

    Component.onCompleted: {
        //timer.start();
    }

    FolderListModel {
        id: fileSystemModel
        folder: "file:///D:/"
        property bool odd: false
    }

    TreeView {
        anchors.fill: parent
        TableViewColumn {
            title: "Name"
            role: "fileName"
            width: 300
        }
        model: fileSystemModel
    }

}
*/


import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

ApplicationWindow {
    id : mainScreen
    width: Screen.width/2
    height: Screen.height/2
    visible: true
    //    minimumWidth : 240;
    //    minimumHeight : 240;
    //    maximumWidth: Screen.width
    //    maximumHeight: Screen.height
    //    contentOrientation: Qt.Pr
    title: qsTr("Hello World")

    property bool portrait : height > width;
    property bool mediaPlaying : false;
    property string screenSize : setScreenSize(Screen.pixelDensity)

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    onPortraitChanged:
    {
        if (!portrait)
        {
            width = Screen.width/2
            height = Screen.height/2
        }
        else
        {
            width = Screen.height/2
            height = Screen.width/2
        }
    }

    property real dpiMultiplier : 1;

    function setScreenSize(dpi)
    {
        dpi *= 25.4;
        console.log("DPI " + dpi);
        if (dpi >= 320)
        {
            dpiMultiplier = 1.75;
            return "xhdpi";
        }
        if (dpi >= 240)
        {
            dpiMultiplier = 1.5;
            return "hdpi";
        }
        if (dpi >= 160)
        {
            dpiMultiplier = 1.25;
            return "mdpi";
        }
        dpiMultiplier = 1;
        return "ldpi";
    }

    //FileBrowser {}
    FileBrowser2 {id: browser; folder:"file:///D:/"}
    //FileList{}
    //FileList2{}
    //FileDialogs{}
    Component.onCompleted: {
        browser.show()
    }
}



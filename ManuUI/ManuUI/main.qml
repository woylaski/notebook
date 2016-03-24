import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

//import com.manu.fileio 1.0
//import com.manu.treemodel 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/components/components" as Components

//Components.AppWindow {
ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item{
        id: viewarea
        width: parent.width
        height: parent.height-buttonarea.height
        anchors.top: parent.top
        Text{
            text: "hello world"
        }
        //Elements.Ink{
        //    id: aink
        //}
    }

    Item{
        id: buttonarea
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom

        Row{
            Button{
                text: "treemodel"
                onClicked: {
                }
            }

            Button{
                text: "dialog"
                onClicked: {}
            }
        }
    }

    Component.onCompleted: {
    }
}


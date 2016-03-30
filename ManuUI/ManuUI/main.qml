import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
//import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

import com.manu.fileio 1.0
import com.manu.treemodel 1.0
import CustomGeometry 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile

/*
import "base/"
*/
import "qrc:/base/base" as Base
import "qrc:/draw/draw" as Draw
import "qrc:/elements/elements" as Elements
import "qrc:/components/components" as Components

Components.AppWindow {
    id: demo

    clientSideDecorations: true

    theme {
        primaryColor: "blue"
        accentColor: "red"
        tabHighlightColor: "white"
    }


    initialPage: page0

    Elements.Page {
        id: page0
        title: "Page Title"

        Elements.Label {
            //property string offlineStoragePath
            anchors.centerIn: parent
            text: "Hello World!"+offlineStoragePath
        }

        BezierCurve {
               id: line
               anchors.fill: parent
               anchors.margins: 20
               property real t
               SequentialAnimation on t {
                   NumberAnimation { to: 1; duration: 2000; easing.type: Easing.InOutQuad }
                   NumberAnimation { to: 0; duration: 2000; easing.type: Easing.InOutQuad }
                   loops: Animation.Infinite
               }

               p2: Qt.point(t, 1 - t)
               p3: Qt.point(1 - t, t)
        }

        //Draw.Line{}
        //Draw.Rect{}
        //Draw.Arc{}
        //Draw.Bezier{}
    }

}


import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
//import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

import com.manu.fileio 1.0
import com.manu.treemodel 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile

/*
import "base/"
*/
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/components/components" as Components

Components.AppWindow {
//ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Base.AppTheme{
        id: apptheme
        primaryColor: "red"
        primaryDarkColor: "blue"
    }

    Elements.OverlayLayer {
        id: dialogOverlayLayer
        objectName: "dialogOverlayLayer"
    }

    Item{
        id: viewarea
        width: parent.width
        height: parent.height-buttonarea.height
        anchors.top: parent.top

        Column {
            anchors.centerIn: parent
            spacing: Base.Units.dp(20)

            Image {
                id: image
                anchors.horizontalCenter: parent.horizontalCenter

                //source: Qt.resolvedUrl("images/balloon.jpg")
                source: "qrc:/images/images/balloon.jpg"
                width: Base.Units.dp(400)
                height: Base.Units.dp(250)

                Elements.Ink {
                    anchors.fill: parent
                    onClicked: overlayView.open(image)
                }
            }

            Elements.Label {
                anchors.horizontalCenter: parent.horizontalCenter

                style: "subheading"
                color: Base.Theme.light.subTextColor
                text: "Tap to edit picture"
                font.italic: true
            }
        }

        Elements.OverlayView {
            id: overlayView

            width: Base.Units.dp(600)
            height: Base.Units.dp(300)

            Image {
                id: contentImage
                source: "qrc:/images/images/balloon.jpg"
                //source: Qt.resolvedUrl("images/balloon.jpg")
                anchors.fill: parent
            }

            Row {
                anchors {
                    top: parent.top
                    right: parent.right
                    rightMargin: Base.Units.dp(16)
                }
                height: Base.Units.dp(48)
                opacity: overlayView.transitionOpacity

                spacing: Base.Units.dp(24)

                Repeater {
                    model: ["content/add", "image/edit", "action/delete"]

                    delegate: Elements.IconButton {
                        id: iconAction

                        iconName: modelData

                        color: Base.Theme.dark.iconColor
                        size: iconName == "content/add" ? Base.Units.dp(27) : Base.Units.dp(24)
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

    }

    Elements.Divider{
        //anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: buttonarea.top
    }

    //Elements.ThinDivider{
    //    anchors.bottom: buttonarea.top
    //}

    Item{
        id: buttonarea
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom

        Row{
            spacing: Base.Units.dp(80)
            Elements.Button {
                //anchors.horizontalCenter: parent.horizontalCenter

                text: "button 1"
                elevation: 1
                onClicked: {
                    print("button1 clicked")
                }
            }

            Elements.Button {
                //anchors.horizontalCenter: parent.horizontalCenter

                text: "button 2"
                elevation: 1
                onClicked: {
                    print("button2 clicked")
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("app complete")
        print(Base.Theme.accentColor)
    }
}


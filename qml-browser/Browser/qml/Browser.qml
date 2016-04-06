import QtQuick 2.5
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "qrc:/js/qml/js/script.js" as Tab

Window {
    id: root
    height: 600; width: 960
    visible: true

    property string currentTab: ""
    property bool hasTabOpen: (tabModel.count !== 0) && (typeof(Tab.itemMap[currentTab]) !== "undefined")
    property bool readerMode: false

    FontLoader { id: fontAwesome; source: "qrc:/icons/qml/icons/fontawesome-webfont.ttf" }

    Component {
        id: tabView
        WebView {
            anchors { top: parent.top; left: parent.left; right: parent.right; }
            anchors.bottom: Tab.EnableVirtualKeyboard ? keyboard.top : parent.bottom
            z: 2 // for drawer open/close control
            anchors.topMargin: 40 // FIXME: should use navigator bar item

            MouseArea {
                id: contextOverlay;
                anchors.fill: parent;
                enabled: contextMenu.visible
                onClicked: contextMenu.visible = false
            }

            Rectangle{
                id: contextMenu
                visible: false
                width: 250; height: 230
                color: "gray"
                radius: 5
                Text {
                    id: contextUrl
                    color: "white"
                    wrapMode: Text.WrapAnywhere
                    anchors {
                        top: parent.top; left: parent.left; right: parent.right;
                        margins: 20; topMargin: 10
                    }
                }
                Column {
                    id: contextButtons
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8
                    ContextButton {
                        label: "Open";
                        onClicked: { Tab.itemMap[currentTab].url = contextUrl.text; contextMenu.visible = false }
                    }
                    ContextButton {
                        label: "Open in New Tab";
                        onClicked: { bounce.start(); openNewTab("page"+salt(), contextUrl.text); contextMenu.visible = false }
                    }
                    // FIXME: clipboard?
                    ContextButton { label: "Copy"; onClicked: { console.log('Copy: ' + contextUrl.text); contextMenu.visible = false } }
                }
            }
        }
    }

    Rectangle {
        id: drawer
        anchors.left: parent.left
        anchors.top: parent.top
        width: Tab.DrawerWidth
        height: parent.height
        color: "#33343E"

        ListModel { id: tabModel }
    }

    Rectangle {
        id: container
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        color: "#6B6C71"
        z: 1
    }
}


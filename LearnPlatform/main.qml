import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "./qml"

ApplicationWindow {
    id: application
    visible: true
    width: 800
    height: 600
    title: qsTr("Learn-Work-Create")

    SplitView {
        id: mainWindow
        anchors.fill: parent
        orientation: Qt.Vertical

        Rectangle{
            id: workWindow
            Layout.fillHeight: true
            SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal

                Rectangle{
                    id: leftMenu
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 400
                    border.color: "black"
                }

                Rectangle{
                    id: documentArea
                    Layout.minimumWidth: 50
                    Layout.fillWidth: true
                    color: "darkgray"
                    border.color: "black"
                }
            }
        }

        Rectangle{
            id: consoleWindow
            Layout.minimumHeight: 100
            Layout.maximumHeight: 400
            border.color: "black"
        }
    }

    statusBar: Rectangle{
            id: stateArea
            color: "darkgray"
            height: 20
            anchors.fill: parent
    }
}


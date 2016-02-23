import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id:root;
    width:640;
    height:480;
    visible: true
    color: "black"
    title: qsTr("ListView");

    Rectangle
    {
        width: 300
        height: 300
        color: "white"

        ListView {
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 100
            orientation: ListView.Horizontal
            delegate: numberDelegate
            spacing: 5
        }

        Component {
            id: numberDelegate
            Rectangle {
                width: 40
                height: 40
                color: "lightGreen"
                Text {
                    anchors.centerIn: parent
                    font.pixelSize: 10
                    text: index
                }
            }
        }
    }
}
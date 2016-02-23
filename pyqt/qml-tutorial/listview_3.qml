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
        x:200; y:100;
        width: 240
        height: 300
        color: "white"

        ListView {
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 100
            delegate: numberDelegate
            spacing: 5
            highlight: highlightComponent
            focus: true
        }

        Component {
            id: highlightComponent
            Rectangle {
                width: ListView.view.width
                color: "lightGreen"
            }
        }

        Component
        {
            id: numberDelegate
            Item {
            //Rectangle{
                width: 40
                height: 40
                //color: "red"
                Text {
                    anchors.centerIn: parent
                    font.pixelSize: 10
                    text: index
                }
            }
        }
    }
}
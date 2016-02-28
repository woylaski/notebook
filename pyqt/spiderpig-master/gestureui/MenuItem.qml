import QtQuick 1.0

Rectangle {

    property alias menuText : label.text

    width: 100
    height: 50
    border.width: 1
    color: "#ccc"

    Text {
        id: label
        anchors.centerIn: parent
        width: parent.width
        horizontalAlignment: Text.Center
        text: "Button"
    }

}

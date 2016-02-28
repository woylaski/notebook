import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle {
    width: 640
    height: 480
    color: "lightgrey"


    Rectangle {
        id: colorIndicator
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    Button {
        anchors.top: parent.top
        anchors.right: parent.right
        text: "Select color"
        onClicked: picker.open(parent.width/2, parent.height/2)
    }


    FancyColorPicker {
        id: picker
        onColorSelected: colorIndicator.color = color
    }
}

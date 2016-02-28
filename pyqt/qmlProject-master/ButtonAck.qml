/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: A simple button
*/
import QtQuick 1.1

Rectangle {
    id: buttonAck

    width: 300; height: 50
    radius: 4
    border.color: "lightgray"
    border.width: 2

    // Hover effect
    property color buttonColor: "#b4c8d7"
    property color onHoverColor: "black"
    property color borderColor: "lightgray"

    property alias label: txt.text
    signal buttonClick()

    Text {
        id: txt
        anchors.centerIn: parent
        text: "give me a name"
        font.family: "Courier New"
        font.bold: true
        font.pointSize: 18
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        onClicked: buttonClick()
        hoverEnabled: true
        onEntered: parent.border.color = onHoverColor
        onExited: parent.border.color = borderColor
    }

    // Pressed effect
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor

}

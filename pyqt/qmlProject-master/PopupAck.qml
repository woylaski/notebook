/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: A popupw with a close button
*/
import QtQuick 1.1

Item {
    id: popupAck
    anchors.fill: parent

    // Make the popup appear gradually
    PropertyAnimation {
        target: popupAck;
        property: "opacity";
        duration: 300
        from: 0;
        to: 1;
        easing.type: Easing.InOutQuad;
        running: true
    }

    // dim the mainScreen and disable click outside the popup
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.7

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    // The actual popup
    Rectangle {
        anchors.centerIn: parent
        width: 200
        height: 200
        color: "#000000"
        opacity: 0.9
        radius: 10

        // Close the popup
        ButtonAck {
            id: buttonClose
            anchors.centerIn: parent
            label: qsTr("Close")

            width: 150
            height: 50

            onButtonClick: {
                popupAck.destroy()
            }
        }
    }
}

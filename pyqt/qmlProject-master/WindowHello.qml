/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: Show hello world button in the middle of the screen
*/
import QtQuick 1.1

Item {
    id: windowHello
    width: 800
    height: 600

    Image {
        id: background
        anchors.fill: parent
        source: "img/bgWindowHello.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // Re-use cloud of the welcome screen
    Image {
        x: -1220; y: 150
        source: "img/cloud.png"

        NumberAnimation on x {
            to: 700
            duration: 50000
            loops: Animation.Infinite
        }
    }

    ButtonAck {
        id: buttonHelloElide
        anchors.centerIn: parent
        label: ""


        Text{
            id: helloElide
            anchors.centerIn: parent
            elide: Text.ElideRight
            width: 90
            text: "Hello World!"
            color: "blue"
            font.family: "Courier New"
            font.pointSize: 18
            font.bold: true
        }

        onButtonClick: {
            handlerLoader("WindowWelcome.qml");
        }
    }

}

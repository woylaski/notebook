/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: Show a menu in the center of the screen.
*/
import QtQuick 1.1

Rectangle {
    id: windowWelcome
    width: 800
    height: 600

    // Bg
    Image {
        id: background
        anchors.fill: parent
        source: "img/bgWindowWelcome.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // animated effect to the background
    Image {
        x: 650; y: -200
        source: "img/cloud.png"

        NumberAnimation on x {
            to: -1300
            duration: 50000
            loops: Animation.Infinite
        }
    }

    // Welcome text in the top left corner
    Text {
        anchors.right: parent.right
        anchors.top: parent.top
        font.family: "Courier New"
        font.pointSize: 56
        font.bold: true
        text: "> Welcome "
    }

    // Display the menu
    MenuAck {
        id: welcomeMenu
        width: parent.width / 3
        height: parent.height / 1.5
    }

}

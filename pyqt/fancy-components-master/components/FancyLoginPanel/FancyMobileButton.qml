/****************************************************************************
**
**  FancyMobileButton is a button component with animation that is played
**  when user presses the button.
**  This component is designed to be used on mobile platforms, initially on Android
**  but it will work on iOS without any problems too.
**
**  Author:   Mateusz Drzazga
**  Date:     31.08.2015
**  E-mail    matt.drzazga@gmail.com
**
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle {
    id: root

    /*  This property holds the text displayed in the center of the button.
    */
    property alias text: text.text

    width: 100
    height: text.implicitHeight
    border.width: focus? 1 : 0

    /*  This signal is emitted when the user clicks on the button.
    */
    signal clicked()

    /*  Key handling.
    */
    Keys.onPressed: {
        if (event.key === Qt.Key_Space || event.key === Qt.Key_Enter) {
            clicked()
        }
    }

    /*  This Rectangle is used to provide fancy animation when the button is pressed.
    */
    Rectangle {
        id: shinyPart
        width: mouseArea.containsPress? parent.width : 0
        height: parent.height
        radius: root.radius
        anchors.centerIn: parent
        opacity: 0.2
        visible: mouseArea.containsPress? true : false

        Behavior on width {
            PropertyAnimation {
                duration: 250
            }
        }
    }

    Item {
        id: container
        anchors.fill: parent

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: root.clicked()
        }

        Label {
            id: text
            anchors.centerIn: parent
            text: "FancyButton"
        }
    }
}


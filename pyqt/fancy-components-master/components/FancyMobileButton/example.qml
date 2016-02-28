/****************************************************************************
**
**  This is an example how to use FancyMobileButton component.
**  Example consists of 2 TextField and 2 FancyMobileButtons
**  TextFields are used as input for user's login and password, and buttons to both login user and register new account.
**
**  Author:   Mateusz Drzazga
**  Date:     31.08.2015
**  E-mail    matt.drzazga@gmail.com
**
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    id: root
    width: 640
    height: 480
    color: "#4c4c4c"


    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.topMargin: dpi(5)

        Column {
            id: column
            width: scrollView.width
            height: scrollView.height
            spacing: dpi(3)

            FancyMobileButton {
                width: scrollView.width * 0.8
                anchors.horizontalCenter: parent.horizontalCenter
                height: dpi(10)
                color: "#00bb11"
                text: "#00bb11"
                onClicked: console.log("Selected: " + text)
            }

            FancyMobileButton {
                width: scrollView.width * 0.8
                anchors.horizontalCenter: parent.horizontalCenter
                height: dpi(10)
                radius: dpi(5)
                color: "#2962ff"
                text: "#2962ff"
                onClicked: console.log("Selected: " + text)
            }

            FancyMobileButton {
                width: dpi(15)
                height: dpi(15)
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#00bcd4"
                text: ""
                onClicked: console.log("Selected: " + color)
                radius: dpi(15)/2

                Image {
                    width: parent.width * 0.9
                    height: parent.height * 0.9
                    source: "qrc:/icons/icons/ic_add_black_48dp.png"
                    anchors.centerIn: parent
                }
            }

            FancyMobileButton {
                width: dpi(15)
                height: dpi(15)
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#ff9800"
                text: ""
                onClicked: console.log("Selected: " + color)
                radius: dpi(15/2)

                Image {
                    width: parent.width * 0.9
                    height: parent.height * 0.9
                    source: "qrc:/icons/icons/ic_add_black_48dp.png"
                    anchors.centerIn: parent
                }
            }
        }
    }
}

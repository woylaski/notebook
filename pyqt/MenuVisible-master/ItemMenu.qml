import QtQuick 2.5

Rectangle {
    id: myButton
    width: 200
    height: containerMenu.height / 15
    property alias itemName: name.text
    color: "#383c4a"

    //Look
        border.color : "black"
        border.width: 1
        radius: 5

        Gradient {
                id: lightGradient
                GradientStop { position: 0.0; color: myButton.color }
                GradientStop { position: 1.0; color: Qt.darker(myButton.color,1.5) }
            }

        gradient: lightGradient

    Text {
        id: name
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("Item Menu")
    }
    MouseArea {
        id: clickableArea
        anchors.fill: parent
    }

}

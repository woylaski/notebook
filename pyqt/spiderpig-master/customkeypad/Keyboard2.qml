import QtQuick 1.1

Rectangle {
    id: keyboard

    property alias model: keyboardModel
    property int spacing: 5

    width: keyboardRows.width + spacing*2
    height: keyboardRows.height + spacing*2
    color: "#EEE"

    KeyboardModel {
        id: keyboardModel
    }

    Component {
        id: rowDelegate
            Row {
                spacing: keyboard.spacing
                move: Transition {
                    NumberAnimation {
                        properties: "x"
                        easing.type: Easing.InOutQuad
                    }
                }

                Repeater {
                    model: buttons
                    Button {
                        id: button
                        mainText: label
                        altText: altLabel

                        MouseArea {
                            anchors.fill: parent
                            onClicked: console.log("click " + index)
//                            drag.target: button
//                            drag.axis: Drag.XAxis
//                            drag.filterChildren: true
                        }
                    }
                }
            }

    }

    Column {
        id: keyboardRows
        anchors.centerIn: parent
        spacing: keyboard.spacing
        Repeater {
            model: keyboardModel
            delegate: rowDelegate
        }
    }
}

import QtQuick 2.0

Rectangle {
    id: rect
    width: 100; height: 100

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked:{
            console.log("mouse clicked")
        }
    }

    Connections {
        target: mouseArea
        onClicked: {
            rect.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
        }
    }
}
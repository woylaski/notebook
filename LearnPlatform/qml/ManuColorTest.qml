import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    visibility: "FullScreen"
    visible: true
    color: "black"

    Rectangle {
        id: r
        anchors.fill: parent
        color: "red"
        visible: false
    }

    Rectangle {
        id: g
        anchors.fill: parent
        color: "green"
        visible: false
    }

    Rectangle {
        id: b
        anchors.fill: parent
        color: "blue"
        visible: false
    }

    Image {
        id: i
        anchors.fill: parent
        source: "testimage-rgb.png"
        visible: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // cycle through the different colors
            var arr = [r, g, b, i];
            for(var active = 0; active < arr.length; active++) {
                if(arr[active].visible) {
                    break;
                }
            }
            arr[active % arr.length].visible = false
            arr[(active + 1) % arr.length].visible = true
        }
    }
}

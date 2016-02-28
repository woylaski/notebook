import QtQuick 2.0

Item {
    id: handler
    x: 100
    y: 200

    signal positionChanged
    property int frame: -1
    property bool valid: true
    property bool isActive: false
    property int size: 5

    //for debug
    property int idx: -1

    property real inTan: 0.5
    property real outTan: 0.5

    Rectangle {
        id: marker

        x: -size / 2
        y: -size / 2
        width: size
        height: size

        rotation: 45

        color: "transparent"
        border.width: 2
        border.color: handler.valid ? (handler.isActive ? "yellow" : "#BBBB77"): "red"
    }

    Item {
        id: inTanMarker

        x: - Math.cos(Math.atan(inTan)) * 30
        y: - Math.sin(Math.atan(inTan)) * 30

        visible: parent.isActive

        Rectangle {
            x: -size / 2
            y: -size / 2
            width: size
            height: size

            rotation: 45

            color: "transparent"
            border.width: 2
            border.color: handler.valid ? (handler.isActive ? "yellow" : "#BBBB77"): "red"
        }
    }

    Item {
        id: outTanMarker

        x: Math.cos(Math.atan(inTan)) * 30
        y: -Math.sin(Math.atan(inTan)) * 30

        visible: parent.isActive

        Rectangle {
            x: -size / 2
            y: -size / 2
            width: size
            height: size

            rotation: 45

            color: "transparent"
            border.width: 2
            border.color: handler.valid ? (handler.isActive ? "yellow" : "#BBBB77"): "red"
        }

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.threshold: 1
        }
    }

    Text {
        anchors.bottom: marker.top
        anchors.horizontalCenter: marekr.horizontalCenter

        text : handler.idx

        font.pointSize: 10
        color: marker.border.color

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.threshold: 1
        }
    }

}

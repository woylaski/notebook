import QtQuick 1.1

Item {
    id: toggleswitch
    width: background.width; height: background.height

    property bool on: false
    property int onPosition: 70
    property int offPosition: 0

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on"
    }


    Rectangle {
        id: background

        width: 80; height: 30
        border.width: 2

        MouseArea {
            anchors.fill: parent; onClicked: toggle()
        }
    }

    Rectangle {
        id: interblock

        anchors {
            left: background.left; right: knob.left;
            top: background.top; bottom: background.bottom
            margins: 2
        }
        color: "blue"
    }

    Rectangle {
        id: knob

        width: 20; height: 40;
        border.width: 2
        color: "black"
        anchors.verticalCenter: background.verticalCenter
        x: 0

        MouseArea {
            anchors.fill: parent
            //drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: offPosition; drag.maximumX: onPosition
            onClicked: toggle()
            //onReleased: toggle()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: onPosition }
            PropertyChanges { target: toggleswitch; on: true }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: offPosition }
            PropertyChanges { target: toggleswitch; on: false }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200}
    }
}


import QtQuick 1.1

Item {
    id: toggleswitch
    width: background.width; height: background.height

    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on"
    }


    Rectangle {
        id: background

        width: 60; height: 30
        border.width: 1; border.color: "#acb2c2"

        MouseArea {
            anchors.fill: parent; onClicked: toggle()
        }
    }

    Rectangle {
        id: knob

        width: 20;
        border.width: 0
        color: "grey"
        x: background.x+2
        anchors {
            top: background.top
            bottom: background.bottom
            //left: background.left
            margins: 2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: toggle()
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: background.x+background.width-knob.width-2; }
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: knob; color: "blue" }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: background.x+2;}
            PropertyChanges { target: toggleswitch; on: false }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200}
    }
}


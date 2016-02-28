import QtQuick 1.1

Flipable {
    id: flipable
    width: 240
    height: 240

    property bool flipped: false

    property list<Item> elementList: [Rectangle{}, Rectangle{}]

    Component.onCompleted: {
        if (elementList.length < 2)
            console.log("Flipable requires at least 2 elements in elementList");
        flipable.back = elementList[0];
        flipable.front = elementList[1];
    }

    transform: Rotation {
        id: rotation
        origin.x: flipable.width/2
        origin.y: flipable.height/2
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
    }

    states: State {
        name: "back"
        PropertyChanges { target: rotation; angle: 180 }
        when: flipable.flipped
    }

    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: 4000 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: flipable.flipped = !flipable.flipped
    }
}

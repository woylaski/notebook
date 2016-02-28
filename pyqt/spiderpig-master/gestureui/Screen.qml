import QtQuick 1.0

Rectangle {
    id: screen

    property variant phoneHandler
    property variant gestureProvider

    signal gestureOccured(string gestureName)

    width: 800
    height: 600
    color: "#DDD"

    Flickable {
        id: canvas
        anchors.centerIn: parent
        width: 700
        height: 500
        clip: true
        contentWidth: mainMenu.width
        contentHeight: mainMenu.height

        MainMenu {
            id: mainMenu
        }
    }

    GestureVisualizer {
        id: gestureVisualizer
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 30
        }
    }

    Component.onCompleted: {
        if (!phoneHandler)
            console.log("Phone handler not defined");
        if (!gestureProvider)
            console.log("Gesture handler not defined");

        gestureProvider.moveHorizontal.connect(onMoveHorizontal);
        gestureProvider.moveVertical.connect(onMoveVertical);
        gestureProvider.zoom.connect(onZoom);
        gestureProvider.pressed.connect(onPressed);
        gestureProvider.hold.connect(onHold);

        gestureOccured.connect(gestureVisualizer.gestureOccured);
    }

    function onPressed() {
        phoneHandler.call("tintin@belgia.be", "TinTin");
        gestureOccured("Pressed");
    }

    function onHold() {
        gestureOccured("Hold");
    }

    function onMoveHorizontal(direction, speed) {
        canvas.contentX -= direction*100;
        if (direction < 0)
            gestureOccured("moveLeft");
        else
            gestureOccured("moveRight");
    }

    function onMoveVertical(direction, speed) {
        canvas.contentY -= direction*100;
        if (direction < 0)
            gestureOccured("moveUp");
        else
            gestureOccured("moveDown");
    }

    function onZoom(direction, speed) {
        if (direction < 1) {
            mainMenu.scale = mainMenu.scale * 0.9;
            gestureOccured("zoomOut");
        }
        else {
            mainMenu.scale = mainMenu.scale * 1.1;
            gestureOccured("zoomIn");
        }
    }
}

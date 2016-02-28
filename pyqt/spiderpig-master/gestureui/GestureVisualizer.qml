import QtQuick 1.0

Rectangle {
    id: gestureVisualizer
    width: 200
    height: 40
    color: "#99AAAAAA"
    visible: false

    Timer {
        id: removeNotificationAfterTimeout
        interval: 2*1000
        running: false
        triggeredOnStart: false
        repeat: false
        onTriggered: gestureVisualizer.visible = false
    }

    function gestureOccured(gestureName) {
        textLabel.text = gestureName;
        gestureVisualizer.visible = true
        removeNotificationAfterTimeout.restart();
    }

    Text {
        id: textLabel
        anchors.centerIn: parent
        color: "white"
    }

}

import QtQuick 1.1

Rectangle {
    id: statusBar
    color: "#252525"
    height: 30

    property Theme theme : Theme {}
    property variant time: new Date()

    Timer {
        interval: 1*1000
        repeat: true
        running: true
        onTriggered: statusBar.time = new Date();
    }

    Text {
        id: time
        anchors.centerIn: statusBar
        color: "white"
        font.family: theme.fontFamily
        font.pixelSize: 12
        font.bold: true
        text: Qt.formatDateTime(statusBar.time, "hh:mm")

    }
    Text {
        anchors {verticalCenter: statusBar.verticalCenter; right: statusBar.right; rightMargin: 10}
        color: "white"
        font.family: time.font.family
        font.pixelSize: time.font.pixelSize
        font.bold: true
        text: Qt.formatDateTime(statusBar.time, "dd MMM yyyy")
        transformOrigin: Item.Right
    }
}

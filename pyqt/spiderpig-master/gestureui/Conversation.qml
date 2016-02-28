import QtQuick 1.0


Rectangle {

    width: 400
    height: 280
    border.width: 1

    Image {
        anchors.fill: parent
        source: "images/halle-berry.jpg"
    }

    MenuRow {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

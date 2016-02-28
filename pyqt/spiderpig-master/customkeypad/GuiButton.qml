import QtQuick 1.1

Rectangle {
    id: button

    signal clicked
    property alias text: label.text

    property color baseColor: "#EEE"

    color: baseColor
    border.width: 1
    border.color: "#CCC"
    height: 30
    width: 90

    Text {
        id: label;
        text: "Button";
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
        onPressed: button.color = Qt.darker(baseColor, 1.1)
        onReleased: button.color = baseColor
    }
}


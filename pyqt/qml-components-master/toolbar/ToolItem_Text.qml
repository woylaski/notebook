import QtQuick 1.1

Rectangle {
    id: container

    property string label

    signal clicked()

    width: 50; height: 30
    border.color: "#acb2c2"; border.width: 1

    Text {  text: label; font.bold: true; anchors.centerIn: parent }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        onClicked: container.clicked()
    }

    states: State {
        name: "press"
        when: mousearea.pressed
        PropertyChanges {target: container; color: "grey"}
    }
}

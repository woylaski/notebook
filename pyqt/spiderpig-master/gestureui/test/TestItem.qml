import QtQuick 1.0

Rectangle {
    id: testItem
    property alias text: text.text
    signal clicked(string text)

    border.width: 1
    color: "#DDD"
    width: 100
    height: 20

    Component.onDestruction: {
        console.log("Destroyed TestItem " + text);
    }

    Text {
        id: text
        anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            onReleased: {
                testItem.clicked(testItem.text);
            }
        }
    }

}

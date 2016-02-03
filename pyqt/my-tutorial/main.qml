import QtQuick 2.0
Rectangle {
    width: 320; height: 240
    color: "lightgray"
    Text {
        id: txt
        text: "Clicked me"
        font.pixelSize: 20
        anchors.centerIn: parent
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent  // 有效区域
        onClicked: {
           con.outputString("Hello, Python3")
        }
    }
}
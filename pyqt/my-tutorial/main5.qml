//import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Rectangle {
    id: root
    width: 320; height: 240
    color: "lightgray"

    signal sendClicked(string str1) // 定义信号

    Rectangle {
        id: rect
        width: 200; height: 100; border.width: 1
        anchors.centerIn: parent

        Text {
            id: txt
            text: "Clicked me"
            font.pixelSize: 20
            anchors.centerIn: rect
        }
    }

    MouseArea {
        id: mouse_area
        anchors.fill: rect  // 有效区域
        onClicked: {
           parent.sendClicked("Hello, Python3")    // 发射信号到Python
        }
    }
}
import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle{
    id: root
    width: 640
    height: 480

    signal mclicked;   // 定义信号

    Text {
        anchors.fill:parent;
        text: "Click Me"
    }

    MouseArea {
        anchors.fill:parent;
        onClicked: {
            mclicked();  // 触发信号
        }
    }
}
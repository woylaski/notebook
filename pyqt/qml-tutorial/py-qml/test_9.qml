import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle {
    id: test;
    visible: true
    width:300
    height: 200

    signal mclicked;   // 定义信号

    Text {
        id: testText
        anchors.fill:parent;
        text: "Click Me"
    }

    MouseArea {
        anchors.fill:parent;
        onClicked: {
            console.log("mouse click")
            mclicked();  // 触发信号
        }
    }

    function set_text(text){
        console.log("recv text: ", text)
        testText.text = text
    }
}
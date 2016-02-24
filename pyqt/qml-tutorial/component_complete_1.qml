import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle {
    id: test;

    signal mclicked;   // 定义信号

    Text {
        id: testText
        anchors.fill:parent;
        text: "Click Me"
    }

    MouseArea {
        anchors.fill:parent;
        onClicked: {
            mclicked();  // 触发信号
        }
    }

    function set_text(){
        testText.text = "Clicked"
    }

    Component.onCompleted : {
        mclicked.connect(set_text);  // 在加载完成后为mclicked信号绑定槽
    }
}
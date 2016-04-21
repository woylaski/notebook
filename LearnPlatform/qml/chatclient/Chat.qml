import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    id: root
    property string destinationIp: ""
    signal sendBroadcastMessage(string msg)
    signal sendP2PMessage(string ip, string msg)

    //显示接收到的消息到聊天窗口
    function showMessage(userName, chatContent, time) {
        var result = "[" + userName + "] " + time + "\n" + chatContent + "\n\n"
        textBrower.text += result
    }

//    color: Qt.rgba(0, 0, 0, 0.4)
    color: Qt.rgba(0, 0, 0, 0.2)

    //
    TextBrower {
        id: textBrower
        width: parent.width
        anchors {bottom: chatTools.top; top: parent.top; bottomMargin: 5}
        color: Qt.rgba(0, 0, 0, 0.2)
        textBrowserFont: textArea.font
    }

    //工具条
    ChatTools {
        id: chatTools
        width: parent.width
        anchors { left: parent.left; right: parent.right; bottom: textArea.top; topMargin: 5; bottomMargin: 5 }
        z: 50    //防止下拉框闪烁（一下透明一下不透明，因为下边的输入框组件是透明的）
    }

    //文字输入框
    TextArea {
        id: textArea
        width: parent.width
        height: 80
        anchors { left: parent.left; right: parent.right; bottom: btnSendMsg.top; leftMargin: -1; rightMargin: -1; topMargin: 5; bottomMargin: 5 }
        backgroundVisible: false
        textColor: chatTools.textColor
        font { pointSize: chatTools.fontSize; italic: chatTools.textItalic; bold: chatTools.textBold; underline: chatTools.textUnderline; family: chatTools.fontFamily; }
    }

    //发送按钮
    Button {
        id: btnSendMsg
        text: qsTr("发送")
        anchors { right: parent.right; bottom: parent.bottom; topMargin: 5; bottomMargin: 5; rightMargin: 5 }
        onClicked: {
            if (textArea.text == "") {
                console.log("消息不能为空")                       //不能发送空消息
            }
            else if (destinationIp == "") {
                sendBroadcastMessage(textArea.text)             //发送广播（群聊）
                textArea.remove(0, textArea.length)             //消息发出后，清空输入框文字
            }
            else {
                var sendText = textArea.getText(0, textArea.length)
                var date = new Date()
                var time = date.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm:ss")
                textBrower.text += "[我] " + time + "\n" + sendText + "\n\n"
                sendP2PMessage(destinationIp, sendText)         //发送端对端（私聊）
                textArea.remove(0, textArea.length)             //消息发出后，清空输入框文字
            }
        }
    }
}

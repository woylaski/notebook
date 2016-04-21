import QtQuick 2.0
import QtCPlusPlus.Network 1.0
//import "JavaScript/ManipulateMessage.js" as ManipulateMessage

Item {
    id: id_root

    property bool privateChatWindowExist: false         //私聊窗口是否已存在

    signal sendUdpMessage(int messageType, string chatContent, string destinationIp)
    signal sendBroadcastMessage(int type, string msgContent)
    signal sendP2PMessage(int type, string msgContent, string destinationIp)
    signal showMessageToScreen(string chatContent)

    anchors.fill: parent

    //处理接收的消息[类型 + ip + userName + chatContent]
    function processMessage(message) {
        //枚举消息类型
        var MessageType = {
            NewParticipant: "0",        //新用户上线
            NewMessage: "1",            //消息
            FileName: "2",              //传送文件名
            Refuse: "3",                //拒绝接收文件
            ParticipantLeft: "4"        //用户下线
        }

        //接收消息
        var type = message[0]
        var srcIp = message[1]
        var destinationIP = message[2]
        var userName = message[3]
        var chatContent = message[4]
        var time = message[5]

        //分类处理消息
        switch (type) {
        case MessageType.NewParticipant:                                    //新上线用户
            if (srcIp === destinationIP) {                                  //如果是自己给自己发的，就不再重复添加上线用户
                break
            }
            id_userList.addUserToOnlineList(userName, srcIp)                //将新上线用户添加到 ListView 列表
            if (destinationIP === "255.255.255.255") {                      //如果收到的是广播
//                if (srcIp !== myIp) {                                     //如果源IP不是自己的IP
                    sendUdpMessage(0, "5", srcIp)                           //给新用户一个回馈
//                }
            }
            break
        case MessageType.NewMessage:                                        //聊天消息
            if (destinationIP === "255.255.255.255") {                      //如果是群聊
                id_containerLeft.showMessage(userName, chatContent, time)   //显示在聊天室窗口
            }
            else if (privateChatWindowExist) {                              //如果是私聊（私聊窗口已经打开）
                                                                            //显示在私聊窗口
            }
            else {                                                          //如果是私聊（私聊窗口未打开）
                messageTwinkle(srcIp, userName)                             //消息闪烁
            }
            break
        case MessageType.FileName:                                          //传送文件

            break
        case MessageType.Refuse:                                            //拒绝接收

            break
        case MessageType.ParticipantLeft:                                   //下线
            id_userList.userLeft(srcIp, userName)
            break
        default:
            break
        }
    }

    //backgroundImage
    Image {
        source: "Img/Images/background2.png"
        anchors.fill: parent
    }

    //WindowTitle
    WindowTitle {
        id: id_windowTitle
        Text {
            id: windowState
            text: "聊天室"
            color: "white"
            anchors { verticalCenter: parent.verticalCenter }
            Component.onCompleted: {
                windowState.x = id_containerLeft.x + id_containerLeft.width
            }
        }
    }

    //WindowContent
    Item {
        id: id_chatCount
        anchors { left: parent.left; right: parent.right; top: id_windowTitle.bottom; bottom: parent.bottom }

        Chat {
            id: id_containerLeft
            width: parent.width - 220
            height: parent.height
            anchors {left: parent.left; top: parent.top; bottom: parent.bottom; leftMargin: 5; topMargin: 5; bottomMargin: 5; rightMargin: 15}
            onSendBroadcastMessage: {
                id_root.sendBroadcastMessage(2, msg)

            }
//            onSendP2PMessage: {
//                console.log("我已经发出去了端对端的消息呀")
//                id_root.sendP2PMessage(0, msg, ip)
//            }
        }

        UserList {
            id: id_userList
            anchors { left: id_containerLeft.right; top: parent.top; bottom: parent.bottom; right: parent.right; leftMargin: 15; topMargin: 5; bottomMargin: 5; rightMargin: 5 }
            onSendP2PMessage: {
                id_root.sendP2PMessage(2, chatContent, destinationIp)
            }
        }
    }
}

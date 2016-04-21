import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    id: userList
    property ListModel model: userList.model
    property int modelCount: userListModel.count
    signal clickUser(string userName, string ip)
    signal sendP2PMessage(string destinationIp, string chatContent)

    color: Qt.rgba(0, 0, 0, 0.4)
    border {width: 1; color: "lightblue"}

    //用户上线
    function addUserToOnlineList(userName, userIp) {
        userListModel.append({"name": userName, "ip": userIp})
    }

    //检测用户是否存在
    function userExist (userIp, userName) {
        var userMessage
        for (var index=0; index<userListModel.count; ++index) {
            userMessage = getUserListIp(index)
            if (userMessage.at(0) === userIp && userMessage.at(1) === userName) {
                return index
            }
        }
        return -1
    }

    //获取某在线用户 IP, userName
    function getUserListMessage(index) {
        if (userListModel.count<=0 || index<0 || index>userListModel.count) {
            return null
        }
        var userIpAndName = new Array()
        userIpAndName.push(userListModel.get(index).ip)
        userIpAndName.push(userListModel.get(index).name)
        return userIpAndName
    }

    //用户下线
    function userLeft(userIp, userName) {
        var index = userExist(userIp, userName)
        if (-1 !== index) {
            userListModel.remove(index)
        }
    }

    //
    Rectangle {
        id: userListTitle
        anchors {left: parent.left; top: parent.top;  margins: 5}
        height: text.height
        color: Qt.rgba(255, 255, 255, 0.3)
        Text {
            id: text
            text: qsTr("在线用户：（双击私聊）")
            font {pointSize: 11}
            color: "white"
        }
    }

    ListView {
        id: userNameList
        anchors {left: parent.left; right: parent.right; top: userListTitle.bottom; margins: 5}
        height: 400

        delegate: Rectangle {
            id: userItem
            width: parent.width
            height: userHead.height
            color: mouseArea.containsMouse ? (mouseArea.pressed ? "black" : "purple") : Qt.rgba(255, 255, 255, 0)
            Image {
                id: userHead
                width: 25
                height: 25
                anchors {left: parent.left}
                source: "Img/Images/manLogo4.png"
            }
            Text {
                anchors {left: userHead.right; verticalCenter: parent.verticalCenter; margins: 5}
                text: name
                color: "white"
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                //双击用户，进入私聊
                onDoubleClicked: {
                    var component = Qt.createComponent("P2PChat.qml").createObject(0)
                    component.destinationIp = model.ip          //userListModel.ip是得不到对应ip的
                    component.friendName = model.name
                    component.sendP2PMessage.connect(userList.sendP2PMessage)
                }
            }
        }

        model: ListModel { id: userListModel }
    }
}


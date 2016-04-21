import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    width: parent.width
    height: parent.height

    signal loginSuccess(string userName)

    //验证登录
    function checkLogin(userName, password){
        if (userName == "") {
            loginStatus.text = "用户名不能为空！"
        }
        else if (password == "") {
            loginStatus.text = "密码不能为空！"
        }
        else if (false) {
            loginStatus.text = "用户名不存在，请注册！"
        }
        else if (false) {
            loginStatus.text = "密码错误！"
        }
        else if (true){
                loginSuccess(userName)
        }


    }
/*
    //动态背景
    AnimatedImage {
        anchors.fill: parent
        source: "Img/Images/waterfall.gif"
    }
*/
    Image {
        anchors.fill: parent
        source: "Img/Images/background1.png"

    }

    //半透明底层
    Rectangle {
        anchors.fill: parent
//        color: Qt.rgba(0, 0, 0, 0.4)
        color: Qt.rgba(0, 0, 0, 0.2)

    }

    //
    WindowTitle {
        Text {
            anchors.centerIn: parent
            text: qsTr("登 录")
            color: "white"
            font {pointSize: 12}
        }
    }

    //
    Column {
        id: columnLayout

        property int rowSpacing: 20

        spacing: 30
        anchors { centerIn: parent }

        Row {
            spacing: columnLayout.rowSpacing
            Text {
                text: "用户名："
                color: "white"
            }
            TextField {
                id: user
                focus: true
                height: 20
                style: TextFieldStyle {
                    textColor: "white"
                    background: Rectangle{
                        border {width: 1; color: "white"}
                        color: Qt.rgba(0, 0, 0, 0)
                    }
                }
            }
        }
        Row {
            spacing: columnLayout.rowSpacing
            Text {
                text: "密  码："
                color: "white"
            }
            TextField {
                id: password
                height: 20
                style: user.style
                echoMode: TextInput.Password
            }
        }
        Row {
            spacing: columnLayout.rowSpacing
            Button {
                focus: true
                text: "登录"
                Keys.onReturnPressed: clicked()
                onClicked: {
                    checkLogin(user.text, password.text)
                }
            }
            Button {
                text: "注册"
            }
        }
    }

    Text {
        id: loginStatus
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 65
    }
}


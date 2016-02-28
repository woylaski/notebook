import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    width: 640
    height: 480
    visible: true

    function authenticateUser(login, password) {
        if (login === "admin" && password === "admin") {
            return true
        }
        else {
            return false
        }
    }

    Rectangle {
        anchors.fill: parent
        visible: !loginFrame.visible
        color: "lightsteelblue"

        Text {
            anchors.centerIn: parent
            font.pointSize: 24
            text: "YOUR APPLICATION"
        }
    }

    Timer {
        id: timer
        interval: 2000
        onTriggered: loginFrame.state = "HIDDEN"
    }

    Rectangle {
        id: loginFrame
        width: parent.width
        height: parent.height
        color: "red"

        FancyLoginPanel {
            id: fancyLoginPanel
            anchors.centerIn: parent

            onLoginClicked: {
                if (authenticateUser(login, password)) {
                    timer.start()
                }
                else {
                    invalidDataLabel.visible = true
                    busyIndicator.running = false
                }
            }

            onSignUpClicked: console.log("Sign Up clicked")
            onPasswordForgotClicked: Qt.openUrlExternally("https://www.example.org")
        }

        states: State {
            name: "HIDDEN"
            PropertyChanges {
                target: loginFrame
                y: -loginFrame.height
                visible: false
            }
        }

        transitions: Transition {
            SequentialAnimation {
                PropertyAnimation {properties: "y"; duration: 350 }
                PropertyAnimation { properties: "visible"; duration: 1 }
            }
        }
    }

}

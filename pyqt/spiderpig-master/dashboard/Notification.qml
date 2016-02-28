import QtQuick 1.0

Rectangle {
    id: notificationBar

    property Theme theme : Theme {}
    property string notification: "Calendar: Scrum retrospective at Hurricane 12:00"

    state: "HIDDEN"

    color: "#500000"
    height: 30

    // returns notification id
    function addNotification(text, timeout) {
        console.log("notifications not implemented")
    }
    function removeNotification(notificationId) {
        console.log("notifications not implemented")
    }

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges {
                target: notificationBar; height: 0
            }
        }
    ]
    Behavior on height {
        NumberAnimation {duration: 300}
    }

    Text {
        opacity: notificationBar.state == "HIDDEN" ? 0 : 1
        color: "white"
        anchors {left: parent.left; margins: 26; verticalCenter: parent.verticalCenter}
        font.family: theme.fontFamily
        font.bold: true
        text: notification
        Behavior on opacity {
            NumberAnimation {duration: 800}
        }
    }
}

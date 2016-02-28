import QtQuick 1.0


Rectangle {
    id: content
    width: 1600
    height: 1200
    color: "#EEE"

    Rectangle {
        width: 50; height:50
        anchors {
            top: parent.top
            left: parent.left
            margins: 200
        }
        color: "#AAA"
    }

    Rectangle {
        width: 50; height:50
        anchors {
            top: parent.top
            right: parent.right
            margins: 200
        }
        color: "#AAA"
    }

    Rectangle {
        width: 50; height:50
        anchors {
            bottom: parent.bottom
            left: parent.left
            margins: 200
        }
        color: "#AAA"
    }

    Rectangle {
        width: 50; height:50
        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 200
        }
        color: "#AAA"
    }

    Rectangle {
        width: 50; height:50
        anchors {
            centerIn: parent
        }
        color: "#AAA"
    }
}

import QtQuick 1.1

Rectangle {
    id: urlBar

    width: 800
    height: 50
    color: "#eeeeee"

    property int mainMargins: 10
    property color borderColor: "#bbbbbb"
    property color buttonColor: "#cccccc"
    property alias urlField : url

    signal loadUrl(string url)
    signal quit()
    signal updateKeyboard(bool showKeyboard)

    MouseArea {
        id: openKeyboardWhenBarClickedExceptButtons
        anchors.fill: parent
        onClicked: {
            urlBar.updateKeyboard(true);
            if (!url.activeFocus)
                url.focus = true;
        }
    }

    Rectangle {
        id: topBorder
        width: parent.width
        height: 1
        color: borderColor
    }

    Text {
        id: urlLabel
        text: "URL:"
        anchors.right: urlText.left
        anchors.margins: 10
        anchors.verticalCenter: urlText.verticalCenter
    }

    Rectangle {
        id: urlText

        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: mainMargins
        }
        color: "white"
        border {width: 1; color: borderColor}
        width: parent.width - buttonGo.width - 300

        TextInput {
            id: url
            text: ""
            color: "#999999"
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 5
            }

            onActiveFocusChanged: urlBar.updateKeyboard(url.activeFocus)
        }
    }

    Rectangle {
        id: buttonGo
        anchors {
            left: urlText.right
            margins: mainMargins
            top: parent.top
            bottom: parent.bottom
        }
        width: 60
        border {width: 1; color: borderColor}
        color: buttonColor

        Text {
            text: "Load"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: loadUrl(url.text)
        }
    }

    Rectangle {
        id: buttonQuit

        anchors {
            left: buttonGo.right
            margins: mainMargins
            top: parent.top
            bottom: parent.bottom
        }
        color: buttonColor
        width: 60
        border {width: 1; color: borderColor}

        Text {
            text: "Quit"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: quit()
        }
    }
}

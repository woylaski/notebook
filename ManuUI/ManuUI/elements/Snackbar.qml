import QtQuick 2.5
import QtQuick.Layouts 1.1
import "qrc:/base/base" as Base

View {
    id: snackbar

    property string buttonText
    property color buttonColor: Base.Theme.accentColor
    property string text
    property bool opened
    property int duration: 2000
    property bool fullWidth: Base.Device.type === Base.Device.phone || Base.Device.type === Base.Device.phablet

    signal clicked

    function open(text) {
        snackbar.text = text
        opened = true;
        timer.restart();
    }

    anchors {
        left: fullWidth ? parent.left : undefined
        right: fullWidth ? parent.right : undefined
        bottom: parent.bottom
        bottomMargin: opened ? 0 :  -snackbar.height
        horizontalCenter: fullWidth ? undefined : parent.horizontalCenter

        Behavior on bottomMargin {
            NumberAnimation { duration: 300 }
        }
    }
    radius: fullWidth ? 0 : Base.Units.dp(2)
    backgroundColor: "#323232"
    height: snackLayout.height
    width: fullWidth ? undefined : snackLayout.width
    opacity: opened ? 1 : 0

    Timer {
        id: timer

        interval: snackbar.duration

        onTriggered: {
            if (!running) {
                snackbar.opened = false;
            }
        }
    }

    RowLayout {
        id: snackLayout

        anchors {
            verticalCenter: parent.verticalCenter
            left: snackbar.fullWidth ? parent.left : undefined
            right: snackbar.fullWidth ? parent.right : undefined
        }

        spacing: 0

        Item {
            width: Base.Units.dp(24)
        }

        Label {
            id: snackText
            Layout.fillWidth: true
            Layout.minimumWidth: snackbar.fullWidth ? -1 : Base.Units.dp(216) - snackButton.width
            Layout.maximumWidth: snackbar.fullWidth ? -1 :
                Math.min(Base.Units.dp(496) - snackButton.width - middleSpacer.width - Base.Units.dp(48),
                         snackbar.parent.width - snackButton.width - middleSpacer.width - Base.Units.dp(48))

            Layout.preferredHeight: lineCount == 2 ? Base.Units.dp(80) : Base.Units.dp(48)
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 2
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            text: snackbar.text
            color: "white"
        }

        Item {
            id: middleSpacer
            width: snackbar.buttonText == "" ? 0 : snackbar.fullWidth ? Base.Units.dp(24) : Base.Units.dp(48)
        }

        Button {
            id: snackButton
            textColor: snackbar.buttonColor
            visible: snackbar.buttonText != ""
            text: snackbar.buttonText
            context: "snackbar"
            width: visible ? implicitWidth : 0
            onClicked: snackbar.clicked()
        }

        Item {
            width: Base.Units.dp(24)
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
}



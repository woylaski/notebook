import QtQuick 2.5
import "qrc:/base/base" as Base

Popover {
    id: dropdown

    property alias text: tooltipLabel.text

    property MouseArea mouseArea

    overlayLayer: "tooltipOverlayLayer"
    globalMouseAreaEnabled: false

    width: tooltipLabel.paintedWidth + Base.Units.dp(32)
    implicitHeight: Base.Device.isMobile ? Base.Units.dp(44) : Base.Units.dp(40)

    backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)

    Timer {
        id: timer

        interval: 1000
        onTriggered: open(mouseArea, 0, Base.Units.dp(4))
    }

    Connections {
        target: mouseArea

        onReleased: {
            if(showing)
                close()
        }

        onPressAndHold: {
            if(text !== "" && !showing)
                open(mouseArea, 0, Base.Units.dp(4))
        }

        onEntered: {
            if(text !== "" && !showing)
                timer.start()
        }

        onExited: {
            timer.stop()

            if(showing)
                close()
        }
    }

    Label {
        id: tooltipLabel
        style: "tooltip"
        color: Base.Theme.dark.textColor
        anchors.centerIn: parent
    }
}


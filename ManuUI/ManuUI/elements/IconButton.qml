import QtQuick 2.5
import "qrc:/base/base" as Base

Item {
    id: iconButton

    property Action action
    property string iconName
    property string iconSource: action ? action.iconSource : "icon://" + iconName
    property bool hoverAnimation: action ? action.hoverAnimation : false
    property alias color: icon.color
    property alias size: icon.size

    signal clicked

    width: icon.width
    height: icon.height
    enabled: action ? action.enabled : true
    opacity: enabled ? 1 : 0.6

    onClicked: {
        if (action) action.triggered(icon)
    }

    Ink {
        id: ink

        anchors.centerIn: parent
        enabled: iconButton.enabled
        centered: true
        circular: true

        width: parent.width + Base.Units.dp(20)
        height: parent.height + Base.Units.dp(20)

        z: 0

        onClicked: {
            iconButton.clicked()
        }
    }

    Icon {
        id: icon

        anchors.centerIn: parent

        source: iconButton.iconSource
        rotation: iconButton.hoverAnimation ? ink.containsMouse ? 90 : 0
                                            : 0

        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }

    Tooltip {
        text: action ? action.name : ""
        mouseArea: ink
    }
}


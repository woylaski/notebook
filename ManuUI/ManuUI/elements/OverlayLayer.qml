import QtQuick 2.5

Rectangle {
    id: overlayLayer
    objectName: "overlayLayer"

    anchors.fill: parent

    property Item currentOverlay
    color: "transparent"

    onEnabledChanged: {
        if (!enabled && overlayLayer.currentOverlay != null)
            overlayLayer.currentOverlay.close()
    }

    onWidthChanged: closeIfNecessary()
    onHeightChanged: closeIfNecessary()

    states: State {
        name: "ShowState"
        when: overlayLayer.currentOverlay != null

        PropertyChanges {
            target: overlayLayer
            color: currentOverlay.overlayColor
        }
    }

    transitions: Transition {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    function closeIfNecessary() {
        if (overlayLayer.currentOverlay != null && overlayLayer.currentOverlay.closeOnResize)
            overlayLayer.currentOverlay.close()
    }

    MouseArea {
        anchors.fill: parent
        enabled: overlayLayer.currentOverlay != null &&
                overlayLayer.currentOverlay.globalMouseAreaEnabled
        hoverEnabled: enabled

        onWheel: wheel.accepted = true

        onClicked: {
            if (overlayLayer.currentOverlay.dismissOnTap)
                overlayLayer.currentOverlay.close()
        }
    }
}



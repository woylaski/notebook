import QtQuick 2.5
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

Elements.PopupBase {
    id: navDrawer
    objectName: "navDrawer"

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    width: Math.min(parent.width - Base.Units.gu(1), Base.Units.gu(5))

    anchors {
        left: mode === "left" ? parent.left : undefined
        right: mode === "right" ? parent.right : undefined
        top: parent.top
        bottom: parent.bottom

        leftMargin: showing ? 0 : -width - Base.Units.dp(10)
        rightMargin: showing ? 0 : -width - Base.Units.dp(10)

        Behavior on leftMargin {
            NumberAnimation { duration: 200 }
        }
        Behavior on rightMargin {
            NumberAnimation { duration: 200 }
        }
    }

    property string mode: "left" // or "right"

    property alias enabled: action.visible

    readonly property Action action: action

    onEnabledChanged: {
        if (!enabled)
            close()
    }

    Elements.Action {
        id: action
        iconName: "navigation/menu"
        name: "Navigation Drawer"
        onTriggered: navDrawer.toggle()
    }

    Elements.View {
        anchors.fill: parent
        fullHeight: true
        elevation: 3
        backgroundColor: "white"
    }
}



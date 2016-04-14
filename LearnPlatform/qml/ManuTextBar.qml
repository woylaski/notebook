import QtQuick 2.5

Rectangle {
    id: cToolBar
    height: 22 * settings.pixelDensity
    z: 2
    color: palette.toolBarBackground

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.max(1, Math.round(0.8 * settings.pixelDensity))
        color: palette.toolBarStripe
        z: 2
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 1.8 * settings.pixelDensity
        gradient: Gradient {
            GradientStop { position: 0; color: palette.toolBarShadowBegin }
            GradientStop { position: 1; color: palette.toolBarShadowEnd }
        }
    }
}

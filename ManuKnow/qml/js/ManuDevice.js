.pragma library
.import QtQuick 2.5 as QtQuick

var dpScale=1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

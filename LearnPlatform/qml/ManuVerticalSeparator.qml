import QtQuick 2.5

Rectangle {
    id: cVerticalSeparator

    width: Math.max(1, Math.round(0.3 * settings.pixelDensity))
    implicitHeight: 18.5 * settings.pixelDensity

    color: palette.separator
}


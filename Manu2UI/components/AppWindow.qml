import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

import "qrc:/base/base" as Base

ApplicationWindow {
    id: __app
    //flags: Qt.FramelessWindowHint | Qt.WindowSystemMenuHint| Qt.WindowMinimizeButtonHint| Qt.Window

    property bool isPortrait: width<height

    Component.onCompleted: {
        //flags |= Qt.FramelessWindowHint

        Base.Device.initDeviceSize(Screen.width, Screen.height,Screen.pixelDensity)
        print(Base.Units.printUintsInfo())

        // Nasty hack because singletons cannot import the module they were declared in, so
        // the grid unit cannot be defined in either Device or Units, because it requires both.
        Base.Units.gridUnit = Qt.binding(function() {
            if (Base.Device.type === Base.Device.phone || Base.Device.type === Base.Device.phablet) {
                return isPortrait ? Base.Units.dp(56) : Base.Units.dp(48)
            } else if (Base.Device.type == Base.Device.tablet) {
                return Base.Units.dp(64)
            } else {
                return Base.Device.hasTouchScreen ? Base.Units.dp(64) : Base.Units.dp(48)
            }
        })

        print(Base.Units.printUintsInfo())
    }
}


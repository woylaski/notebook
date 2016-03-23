import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

import "."

pragma Singleton

/*!
   \qmltype Device
   \inqmlmodule Material

   \brief A singleton that provides information about the current device.
 */
Object{
    id: device
    objectName: "device"

    property real density
    property int width
    property int height
    //对角线长度
    property real diagonal

    //some kind of enum, by screen size
    property int type: desktop
    readonly property int phone: 0
    readonly property int phablet: 1
    readonly property int tablet: 2
    readonly property int desktop: 3
    readonly property int tv: 4
    readonly property int unknown: 5 //it's either bigger than tv or smaller than phone

    readonly property string name: {
        switch (type) {
            case 0:
                return "phone";
            case 1:
                return "phablet";
            case 2:
                return "tablet";
            case 3:
                return "computer";
            case 4:
                return "TV";
            case 5:
                return "device";
        }
    }

    readonly property string iconName: {
        switch (type) {
            case 0:
                return "hardware/smartphone";
            case 1:
                return "hardware/tablet";
            case 2:
                return "hardware/tablet";
            case 3:
                return "hardware/desktop_windows";
            case 4:
                return "hardware/tv";
            case 5:
                return "hardware/computer";
        }
    }

    readonly property bool isMobile: Settings.isMobile
    readonly property bool hasTouchScreen: Settings.hasTouchScreen
    readonly property bool hoverEnabled: Settings.hoverEnabled

    property string os: Qt.platform.os

    function checkDeviceType(diagonal){
        if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
            type = phone;
            Units.multiplier=1
        } else if (diagonal >= 5 && diagonal < 6.5) {
            type = phablet;
            Units.multiplier=1
        } else if (diagonal >= 6.5 && diagonal < 10.1) {
            type = tablet;
            Units.multiplier=1
        } else if (diagonal >= 10.1 && diagonal < 29) {
            type = desktop;
            Units.multiplier=1.8
        } else if (diagonal >= 29 && diagonal < 92) {
            type = tv;
            Units.multiplier=2
        } else {
            type = unknown;
            Units.multiplier=2
        }
    }

    function initDeviceSize(width, height, density){
        device.density = density
        Units.setDensity(density)
        device.width = width
        device.height = height
        device.diagonal =
                Math.sqrt(Math.pow((width/density), 2) + Math.pow((height/density), 2)) * 0.039370;
        print(device.diagonal)
        checkDeviceType(device.diagonal)
    }

    function printDeviceInfo(){
        print("device width: ", device.width)
        print("device height: ", device.height)
        print("device diagonal: ", device.diagonal)
        print("device density: ", device.density)
        print("device type: ", device.type)
        print("device name: ", device.name)
        print("device os: ", device.os)
    }
}



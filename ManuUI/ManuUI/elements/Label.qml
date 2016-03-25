import QtQuick 2.5
//import QtQuick.Controls 1.4
import "qrc:/base/base" as Base

Text {
    id: label
    property string style: "body1"

    property var fontStyles: {
        "display4": {
            "size": 112,
            "font": "light"
        },

        "display3": {
            "size": 56,
            "font": "regular"
        },

        "display2": {
            "size": 45,
            "font": "regular"
        },

        "display1": {
            "size": 34,
            "font": "regular"
        },

        "headline": {
            "size": 24,
            "font": "regular"
        },

        "title": {
            "size": 20,
            "font": "medium"
        },

        "dialog": {
            "size": 18,
            "size_desktop": 17,
            "font": "regular"
        },

        "subheading": {
            "size": 16,
            "size_desktop": 15,
            "font": "regular"
        },

        "body2": {
            "size": 14,
            "size_desktop": 13,
            "font": "medium"
        },

        "body1": {
            "size": 14,
            "size_desktop": 13,
            "font": "regular"
        },

        "caption": {
            "size": 12,
            "font": "regular"
        },

        "menu": {
            "size": 14,
            "size_desktop": 13,
            "font": "medium"
        },

        "button": {
            "size": 14,
            "font": "medium"
        },

        "tooltip": {
            "size_desktop": 13,
            "size": 14,
            "font": "medium"
        }
    }

    property var fontInfo: fontStyles[style]

    //font.pointSize
    font.pixelSize: Base.Units.dp(!Base.Device.isMobile && fontInfo.size_desktop
            ? fontInfo.size_desktop : fontInfo.size)
    font.family: "Roboto"

    //字体粗细设置 Font.DemiBold, Font.Normal, Font.Light
    font.weight: {
        var weight = fontInfo.font

        if (weight === "medium") {
            return Font.DemiBold
        } else if (weight === "regular") {
            return Font.Normal
        } else if (weight === "light") {
            return Font.Light
        }
    }

    //大小写
    font.capitalization: style == "button" ? Font.AllUppercase : Font.MixedCase

    color: Base.Theme.light.textColor
    //color: Base.Theme.dark.textColor
}


import QtQuick 2.5
import QtGraphicalEffects 1.0
import "qrc:/base/base" as Base

Item {
    id: item
    width: 100
    height: 62

    property int elevation: 0
    property real radius: 0

    property string style: "default"

    property color backgroundColor: elevation > 0 ? "white" : "transparent"
    property color tintColor: "transparent"

    property alias border: rect.border

    property bool fullWidth
    property bool fullHeight

    property alias clipContent: rect.clip

    default property alias data: rect.data

    property bool elevationInverted: false

    property var topShadow: [
        {
            "opacity": 0,
            "offset": Base.Units.dp(0),
            //涂污，弄脏; （使） 变模糊
            "blur": Base.Units.dp(0)
        },

        {
            "opacity": 0.12,
            "offset": Base.Units.dp(1),
            "blur": Base.Units.dp(1.5)
        },

        {
            "opacity": 0.16,
            "offset": Base.Units.dp(3),
            "blur": Base.Units.dp(3)
        },

        {
            "opacity": 0.19,
            "offset": Base.Units.dp(10),
            "blur": Base.Units.dp(10)
        },

        {
            "opacity": 0.25,
            "offset": Base.Units.dp(14),
            "blur": Base.Units.dp(14)
        },

        {
            "opacity": 0.30,
            "offset": Base.Units.dp(19),
            "blur": Base.Units.dp(19)
        }
    ]

    property var bottomShadow: [
        {
            "opacity": 0,
            "offset": Base.Units.dp(0),
            "blur": Base.Units.dp(0)
        },

        {
            "opacity": 0.24,
            "offset": Base.Units.dp(1),
            "blur": Base.Units.dp(1)
        },

        {
            "opacity": 0.23,
            "offset": Base.Units.dp(3),
            "blur": Base.Units.dp(3)
        },

        {
            "opacity": 0.23,
            "offset": Base.Units.dp(6),
            "blur": Base.Units.dp(3)
        },

        {
            "opacity": 0.22,
            "offset": Base.Units.dp(10),
            "blur": Base.Units.dp(5)
        },

        {
            "opacity": 0.22,
            "offset": Base.Units.dp(15),
            "blur": Base.Units.dp(6)
        }
    ]

    //RectangularGlow，生成一个模糊的、彩色的矩形，给人发光的印象
    RectangularGlow {
        property var elevationInfo: bottomShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? Base.Units.dp(10) : 0)
        height: parent.height + (fullHeight ? Base.Units.dp(20) : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
        //visible: parent.opacity == 1
    }

    RectangularGlow {
        property var elevationInfo: topShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? Base.Units.dp(10) : 0)
        height: parent.height + (fullHeight ? Base.Units.dp(20) : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
        //visible: parent.opacity == 1
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        //tint着色
        color: Qt.tint(backgroundColor, tintColor)
        radius: item.radius
        //消除混叠现象，消除走样，图形保真
        antialiasing: parent.rotation || radius > 0 ? true : false
        clip: true

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}


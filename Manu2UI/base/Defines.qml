pragma Singleton

import QtQuick 2.5

Object {
    id: defines
    objectName: "defines"

    //rect的圆角radius
    readonly property int radius : 6

    //UI的颜色color
    readonly property string colorTurquoise: "#1abc9c"
    readonly property string colorGreenSea: "#16a085"

    // 翠绿色
    readonly property string colorEmerald : "#2ecc71"
    readonly property string colorNephritis : "#27ae60"

    // 蓝色
    readonly property string colorPeterRiver : "#3498db"
    readonly property string colorBelizeHole : "#2980b9"

    // 紫色
    readonly property string colorAmethyst : "#9b59b6"
    readonly property string colorWisteria : "#8e44ad"

    // 沥青色
    readonly property string colorWetAsphalt : "#34495e"
    readonly property string colorMidnightBlue : "#2c3e50"

    // 橙色
    readonly property string colorSunFlower : "#f1c40f"
    readonly property string colorOrange : "#f39c12"

    // 胡萝卜色
    readonly property string colorCarrot : "#e67e22"
    readonly property string colorPumpkin : "#d35400"
    // 红色
    readonly property string colorAlizarin : "#e74c3c"
    readonly property string colorPomegranate : "#c0392b"
    // 白云色
    readonly property string colorClouds : "#ecf0f1"
    readonly property string colorSilver : "#bdc3c7"  // disable color
    // 水泥色
    readonly property string colorConcrete : "#95a5a6"
    readonly property string colorAsbestos : "#7f8c8d"
}


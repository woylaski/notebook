import QtQuick 2.5
import QtQuick.Window 2.2

Flipable
{
    id: flip

    width: 300
    height: 200

    //定义属性
    property bool flipped: false

    //正面图片
    front:Image
    {
        source: "images/girl.png"
        anchors.centerIn: parent
    }

    //背面图片
    back:Image
    {
        source: "images/monkey.jpg"
        anchors.centerIn: parent
    }

    //旋转设置,延Y轴旋转
    transform: Rotation
    {
        id: rotation
        origin.x:flip.width / 2
        origin.y:flip.height / 2
        axis.x: 0
        axis.y: 1
        axis.z: 0
        angle: 0
    }

    //状态改变
    states:State
    {
        name: "back"
        PropertyChanges
        {
            target: rotation;angle:180
        }
        when:flip.flipped
    }

    //转换方式
    transitions: Transition
    {
        NumberAnimation
        {
            target:rotation
            properties: "angle"
            duration:4000
        }
    }

    //鼠标区域
    MouseArea
    {
        anchors.fill: parent
        onClicked: flip.flipped = !flip.flipped
    }
}
import QtQuick 2.2

Item {
    id: container
    width: 360
    height: 360

    Rectangle {
        id: rect
        width: 100
        height: 100
        color: "blue"

        // rect水平右移
        NumberAnimation on x {
            id: right
            running: false // false
            to: 260
            easing.type: Easing.InOutBounce
            duration: 500
        }
        // rect水平左移
        NumberAnimation on x {
            id: left
            running: false // false
            to: 0
            easing.type: Easing.OutInBounce // 换个easing动画效果
            duration: 500
        }

        MouseArea {
            anchors.fill: parent
            // 判断移动方向
            onClicked: rect.x == 0 ? right.running = true : left.running = true
        }
    }
}
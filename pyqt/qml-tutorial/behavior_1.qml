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

        // 看这里
        Behavior on x {
            NumberAnimation {
                easing.type: Easing.InOutBounce
                duration: 500
            }
        }

        MouseArea {
            anchors.fill: parent
            // 改变rect的x坐标
            onClicked: rect.x = (rect.x == 0 ? 260 : 0)
        }
    }
}
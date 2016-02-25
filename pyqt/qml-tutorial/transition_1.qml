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

        MouseArea {
            anchors.fill: parent
            // state属性值为空字符串时（''）即默认状态
            onClicked: container.state == 'right' ? container.state = '' : container.state = 'right'
        }
    }

    states: State {
        name: "right"
        // rect水平移动
        PropertyChanges {
            target: rect
            x: 260
        }
    }

    transitions: Transition {
        // 数字（x坐标）动画，设置了easing的回弹效果和动画时间
        NumberAnimation {
            property: "x"
            easing.type: Easing.InOutBounce
            duration: 500
        }
    }
}
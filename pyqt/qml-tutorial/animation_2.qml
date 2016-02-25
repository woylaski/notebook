import QtQuick 2.2

Item {
    id: container
    width: 360
    height: 360

    Rectangle {
        id: up
        width: 100
        height: 100
        color: "blue"

        // 并行动画，水平移动和颜色变化同时进行
        ParallelAnimation {
            id: parallel
            running: false

            PropertyAnimation {
                target: up
                property: "x"
                to: 260
                duration: 500
            }
            PropertyAnimation {
                target: up
                property: "color"
                to: "red"
                duration: 500
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: parallel.running = true
        }
    }

    Rectangle {
        id: down
        width: 100
        height: 100
        color: "red"
        anchors.top: up.bottom

        // 串行动画，先进行水平移动，后进行颜色变化
        SequentialAnimation {
            id: sequential
            running: false

            PropertyAnimation {
                target: down
                property: "x"
                to: 260
                duration: 500
            }
            PropertyAnimation {
                target: down
                property: "color"
                to: "blue"
                duration: 500
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: sequential.running = true
        }
    }
}

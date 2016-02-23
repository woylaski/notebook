import QtQuick 2.5
import QtQuick.Window 2.2

/*
在QML中提供了三种path，PathLine直线，PathQuad二次贝塞尔曲线
PathCubic三次贝塞尔曲线

使用路径属性PathAttribute来设置不同路径上属性

在 Qt 中 Path 就是直译为路径，一个路径是由多个路径元素组成的，从起点开始，首尾衔接，抵达终点。

Path 的属性 startX 、 startY 描述路径起点。
pathElements 属性是个列表，是默认属性，它保存组成路径的多个路径元素，
常见的路径元素有 PathLine 、 PathQuad 、 PathCubic 、 PathArc 、 PathCurve 、 PathSvg 。
路径上最后一个路径元素的终点就是整个路径的终点，如果终点与起点重合，那么 Path 的 closed 属性就为 true 。

路径元素除 PathSvg 外，都有 x 、 y 属性，以绝对坐标的形式指定本段路径的终点；而起点呢，就是前一个路径段的终点；
第一个路径段的起点，就是 Path 的 startX 、 startY 所描述的整个路径的起点。
另外还有 relativeX 、 relativeY 两个属性，以相对于起点的相对坐标的形式来指定终点。
你还可以混合使用绝对坐标与相对坐标，比如使用 x 和 relativeY 来决定路径段的终点。
*/

Window {
    id:root;
    width:640;
    height:480;
    visible: true
    title:qsTr("PathView");

    Path {
        startX: 0;
        startY: 0;
        PathLine {
            x: root.width - 1;
            y: root.height - 1;
        }
    }

    PathView {
        anchors.fill: parent

        delegate: flipCardDelegate
        model: 100

        path: Path {
            startX: root.width/2
            startY: 0

            PathAttribute { name: "itemZ"; value: 0 }
            PathAttribute { name: "itemAngle"; value: -90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathLine { x: root.width/2; y: root.height*0.4; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width/2; y: root.height*0.5; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width/2; y: root.height*0.6; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width/2; y: root.height; }
            PathAttribute { name: "itemAngle"; value: 90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathAttribute { name: "itemZ"; value: 0 }
        }

        pathItemCount: 16

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Component {
        id: flipCardDelegate

        Rectangle {
            id: wrapper

            width: 64
            height: 64
            antialiasing: true

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#2ed5fa" }
                GradientStop { position: 1.0; color: "#2467ec" }
            }

            visible: PathView.onPath

            scale: PathView.itemScale
            z: PathView.itemZ

            property variant rotX: PathView.itemAngle
            transform: Rotation {
                axis { x: 1; y: 0; z: 0 }
                angle: wrapper.rotX;
                origin { x: 32; y: 32; }
            }
            //text: index
            Text {
                anchors.centerIn: parent
                font.pixelSize: 10
                text: index
            }
        }
    }
}


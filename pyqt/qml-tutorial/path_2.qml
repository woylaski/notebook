/*
PathCubic 定义一个三次方贝塞尔曲线，它有两个控制点。下面是一个简单的示例程序， pathCubic_canvas.qml ：
如你所见，这次我使用 PathAnimation 来演示 PathCubic 的用法，请查看改动画元素的 API 文档。
    我在 Canvas 的 onPaint() 方法中使用 bezierCurveTo() 绘制了一个三次方贝塞尔曲线，为的是能让你看见这个曲线到底什么模样。
    我定义了一个 Rectangle 对象，长宽各为 32 ，设置其 radius 为 16 ，实际上就是个圆形。然后定义了 PathAnimation 对象，
    设置其 Path 为三次方贝塞尔曲线，与 onPaint() 方法绘制曲线所用参数完全一致；另外设置了 anchorPoint 为 ball 的中心点。 
    MouseArea 对象在鼠标左键点击时启动动画。
    执行 "qmlscene pathCubic_canvas.qml" ，鼠标点击蓝色的圆圈，动画就开始咧
*/

import QtQuick 2.0
import QtQuick.Controls 1.1

Canvas {
    width: 320;
    height: 240;
    id: root;

    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.beginPath();
        ctx.moveTo(16, 16);
        ctx.bezierCurveTo(0, height - 1, width -1, height / 2, width - 16, height - 16);
        ctx.stroke();
    }
    
    Text {
        anchors.centerIn: parent;
        font.pixelSize: 20;
        text: "cubic Bezier curve";
    }
    
    Rectangle {
        width: 32;
        height: 32;
        radius: 16;
        color: "blue";
        id: ball;
       
        MouseArea {
            anchors.fill: parent;
            id: mouseArea;
            onClicked: pathAnim.start();
        }
   
        PathAnimation {
            id: pathAnim;
            target: ball;
            duration: 3000;
            anchorPoint: "16,16";
            easing.type: Easing.InCubic;
            path: Path {
                startX: 16;
                startY: 16;
                PathCubic {
                    x: root.width - 16;
                    y: root.height - 16;
                    control1X: 0;
                    control1Y: root.height - 1;
                    control2X: root.width - 1;
                    control2Y: root.height / 2;
                }
            }
        } 
    }
}
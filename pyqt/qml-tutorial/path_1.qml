
/*
PathLine
    PathLine 是最简单的路径元素，在 Path 的起点或者上一段路径的终点，与本元素定义的终点之间绘制一条直线。
*/
/*
    Path {
        startX: 0;
        startY: 0;
        PathLine {
            x: root.width - 1;
            y: root.height - 1;
        }
    }
*/
/*
 贝塞尔曲线( Bézier curve )，又称贝兹曲线或贝济埃曲线，是应用于二维图形应用程序的数学曲线。
    贝塞尔曲线于 1962 年，由法国工程师皮埃尔·贝塞尔（ Pierre Bézier ）所广泛发表，他运用贝塞尔曲线来为汽车的主体进行设计。
    贝塞尔曲线最初由 Paul de Casteljau 于 1959 年运用 de Casteljau 算法开发，以稳定数值的方法求出贝塞尔曲线。
    常见的贝塞尔曲线有线性贝塞尔曲线、二次方贝塞尔曲线、三次方贝塞尔曲线，当然也有四阶、五阶甚至更高阶的贝塞尔曲线。
    线性贝塞尔曲线其实只是两点之间的直线。二次方贝塞尔曲线，由两个端点和一个控制点以及一个函数来生成。三次方贝塞尔曲线，
    由两个端点和两个控制点以及一个函数来生成。
    在 Qt Quick 的 Path 主题中，提供了基于二次方贝塞尔曲线和三次方贝塞尔曲线的路径元素。
    在我们使用 Canvas 进行 2D 绘图时， Context2D 对象的 quadraticCurveTo(real cpx, real cpy, real x, real y) 方法可以在路径中添加一条二次方贝塞尔曲线， 
    bezierCurveTo(real cp1x, real cp1y, real cp2x, real cp2y, real x, real y) 方法用来在路径中添加一条三次方贝塞尔曲线。
    PathQuad 元素定义一条二次贝塞尔曲线作为路径段。它的起点为上一个路径元素的终点（或者路径的起点），
    终点由 x 、 y 或 relativeX 、 relativeY 定义，控制点由 controlX 、 controlY 或 relativeControlX 、 relativeControlY 来定义。
*/
/*
    Path {
        startX: 0;
        startY: 0;
        PathQuad {
            x: root.width - 1;
            y: root.height - 1;
            controlX: 0;
            controlY: root.height - 1;
        }
    }
*/
/*
    在 Qt Quick 中， Path 虽然描述了一条路径，但它是不可见的，不够形象化。
    这里我们通过使用 Canvas 来绘制同样的曲线，以求大家看了可以有个直观的印象。上面的路径定义，对应 qml 代码
 */
import QtQuick 2.0
import QtQuick.Controls 1.1

Canvas {
    width: 320;
    height: 240;

    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.quadraticCurveTo(0, height - 1, width - 1, height - 1);
        ctx.stroke();
    }
    
    Text {
        anchors.centerIn: parent;
        font.pixelSize: 20;
        text: "quadratic Bezier curve";
    }
}
import QtQuick 2.5

Canvas {
    id: arc
    anchors.fill: parent

    onPaint: {
        var ctx= getContext('2d')
        //绘制贝塞尔曲线（贝济埃、bezier） context.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)
        //cp1x:第一个控制点x坐标
        //cp1y:第一个控制点y坐标
        //cp2x:第二个控制点x坐标
        //cp2y:第二个控制点y坐标
        //x:终点x坐标
        //y:终点y坐标
        ctx.moveTo(50, 50);
        ctx.bezierCurveTo(50, 50,150, 50, 150, 150);
        ctx.stroke();

        //绘制二次样条曲线 context.quadraticCurveTo(qcpx,qcpy,qx,qy)
        //qcpx:二次样条曲线控制点x坐标
        //qcpy:二次样条曲线控制点y坐标
        //qx:二次样条曲线终点x坐标
        //qy:二次样条曲线终点y坐标
        ctx.quadraticCurveTo(150, 250, 250, 250);
        ctx.stroke();
    }
}


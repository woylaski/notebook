import QtQuick 2.5

Canvas {
    id: arc
    anchors.fill: parent

    onPaint: {
        var ctx= getContext('2d')
        //圆弧context.arc(x, y, radius, starAngle,endAngle, anticlockwise)
        //x:圆心的x坐标, y:圆心的y坐标
        //radius:半径,straAngle:开始角度, endAngle:结束角度
        //anticlockwise:是否逆时针（true）为逆时针，(false)为顺时针
        //Math.PI:180°
        ctx.beginPath();
        ctx.arc(100, 100, 50, 0, Math.PI * 2, true);
        ctx.closePath();

        context.fillStyle = Qt.rgba(0,255,0,0.25);
        context.fill();

        //1/4圆弧
        ctx.beginPath();
        ctx.arc(150, 100, 50, 0, Math.PI/2, false);
        ctx.closePath();
        context.fillStyle='red'
        context.fill();

        //1/4圆弧
        ctx.beginPath();
        ctx.arc(250, 100, 50, 0, Math.PI/2, true);
        ctx.closePath();
        context.strokeStyle='black'
        context.stroke();
    }
}


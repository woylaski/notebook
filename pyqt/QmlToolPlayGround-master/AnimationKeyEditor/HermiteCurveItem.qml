import QtQuick 2.0

Canvas {
    id: canvas
    anchors.fill: parent
    property real frameInterval: 10

    property vector2d control01: Qt.vector2d(200, 300)
    property vector2d control02: Qt.vector2d(300, 400)

    onPaint: {
        var ctx = canvas.getContext('2d');

        var ctLength = (control02.x - control01.x ) / 3;
        ctx.clearRect(0, 0, width, height);
        ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
        ctx.lineWidth = 1;
        ctx.beginPath();
        ctx.moveTo(control01.x, control01.y);//start point
        ctx.bezierCurveTo(control01.x + ctLength, control01.y, control02.x - ctLength, control02.y, control02.x, control02.y);
        ctx.stroke();


//        ctx.strokeStyle = Qt.rgba(0.3, 0.3, 0.3, 1);
//        ctx.lineWidth = 0.5;
//        ctx.beginPath();

//        for (var i = 0; i < width; i += frameInterval) {
//            ctx.moveTo(i, 0);//start point
//            ctx.lineTo(i, height);
//        }
//        ctx.stroke();
    }
}

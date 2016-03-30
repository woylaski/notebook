import QtQuick 2.5

Canvas{
    id: line
    anchors.fill: parent

    onPaint: {
        var context = getContext("2d");
        //实践表明在不设施fillStyle下的默认fillStyle=black
        context.fillRect(0, 0, 100, 100);
        //实践表明在不设施strokeStyle下的默认strokeStyle=black
        context.strokeRect(120, 0, 100, 100);

        //设置纯色
        context.fillStyle = "red";
        context.strokeStyle = "blue";
        context.fillRect(0, 120, 100, 100);
        context.strokeRect(120, 120, 100, 100);

        //设置透明度实践证明透明度值>0,<1值越低，越透明，值>=1时为纯色，值<=0时为完全透明
        context.fillStyle = "rgba(255,0,0,0.2)";
        context.strokeStyle = "rgba(255,0,0,0.2)";
        context.fillRect(240,0 , 100, 100);
        context.strokeRect(240, 120, 100, 100);

        //清除矩形区域 context.clearRect(x,y,width,height)
        context.clearRect(50, 50, 240, 120);
    }
}


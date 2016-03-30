
//canvas默认宽高是300、150
//填充与描边(Fill And Stroke)
//颜色填充可以通过fillStyle来实现，描边颜色可以通过strokeStyle来实现

//style:在进行图形绘制前，要设置好绘图的样式
//context.fillStyle//填充的样式
//context.strokeStyle//边框样式

//canvas元素绘制图像的时候有两种方法，分别是
//context.fill()//填充
//context.stroke()//绘制边框

//beginPath的作用用来开始一个新的路径层，如果不加就表示在原来路径层上绘制
//如果不需要路径闭合，closePath可以不用，如果使用了fill则路径则会自动闭合，不需要再使用closePath了

import QtQuick 2.5

Canvas {
    id: line
    anchors.fill: parent
    onPaint: {
        var ctx = getContext("2d");
        //context.lineWidth//图形边框宽度
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.font = " 42px sans-serif";

        var gradient = ctx.createLinearGradient(0,0, width , height);
        gradient.addColorStop( 0.0 , Qt.rgba(0 , 1 ,0 , 1));
        gradient.addColorStop(1.0 , Qt.rgba(0,0, 1 , 1));

        ctx.fillStyle = gradient;

        ctx.beginPath();
        ctx.text("Fill Text on Path" , 10 , 50);
        ctx.fill();  // 设置 ↑ 的text的风格为fill

        ctx.fillText("Fill Text" , 10 , 100);


        ctx.beginPath();
        ctx.text("Stroke Text on Path" , 10 , 150);
        ctx.stroke(); //设置 ↑ 的text风格为stroke


        ctx.strokeText("Stroke Text" , 10 , 200);

        ctx.beginPath();
        ctx.text("Stroke and Fill Text on Path" , 10 , 250 );
        ctx.stroke();
        ctx.fill();
/*
        var woodfill = ctx.createPattern(imageTexture,"repeat");
        ctx.strokeStyle = woodfill;
        ctx.strokeText('Hello World!', 20, 200);
        // fill rectangle
        ctx.fillStyle = woodfill;
        ctx.fillRect(60, 240, 260, 440);
*/
    }
}


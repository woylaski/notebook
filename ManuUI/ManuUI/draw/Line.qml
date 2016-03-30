
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

//1、系统默认在绘制第一个路径的开始点为beginPath
//*2、如果画完前面的路径没有重新指定beginPath，那么画第其他路径的时候会将前面最近指定的beginPath后的全部路径重新绘制
//3、每次调用context.fill（）的时候会自动把当次绘制的路径的开始点和结束点相连，接着填充封闭的部分

//绘制线段 context.moveTo(x,y)  context.lineTo(x,y)
//每次画线都从moveTo的点到lineTo的点
//如果没有moveTo那么第一次lineTo的效果和moveTo一样，
//每次lineTo后如果没有moveTo，那么下次lineTo的开始点为前一次lineTo的结束点


import QtQuick 2.5

Canvas {
    id: line
    anchors.fill: parent
    onPaint: {
        var ctx = getContext("2d");
        //context.lineWidth//图形边框宽度
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";

        print("draw a line")
        //ctx.beginPath();
        var i=0
        var num=height/50
        for(i=1;i<num;i++){
            ctx.moveTo(0, i*50);
            ctx.lineTo(width, i*50);
        }
        ctx.stroke()

        ctx.strokeStyle = "blue";
        num=width/50;
        for(i=1;i<num;i++){
            ctx.moveTo(i*50, 0);
            ctx.lineTo(i*50, height);
        }

        ctx.stroke()
    }
}


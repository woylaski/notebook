import QtQuick 2.0

Rectangle
{
    width: 480
    height: 320
    color: "blue"

    Flickable
    {
        id: flick

        width: 300
        height: 200
        //可拖拽内容大小
        contentWidth: image.width
        contentHeight: image.height
        //隐藏大于显示窗口的部分
        clip: true;

        Image
        {
            id: image
            source: "images/girl.png"
        }
    }

    //竖滚动条，不是用来控制的，是显示可见高度相对图片高度的位置比例的，相当于高度状态的状态条
    Rectangle
    {
        id: scrollbar_vertical
        anchors.right: flick.right
        //当前可视区域的位置.为百分比值,0-1之间
        y: flick.visibleArea.yPosition * flick.height
        width: 10
        //当前可视区域的高度比例,为百分比值,0-1之间
        height: flick.visibleArea.heightRatio * flick.height
        color: "black"
    }

    //横滚动条，同上，是水平方向的可见状态条
    Rectangle
    {
        id: scrollbar_horizontal
        anchors.bottom: flick.bottom
        //当前可视区域的位置.为百分比值,0-1之间
        x: flick.visibleArea.xPosition * flick.width
        height: 10
        //当前可视区域的宽度比例,为百分比值,0-1之间
        width: flick.visibleArea.widthRatio * flick.width
        color: "black"
    }
}
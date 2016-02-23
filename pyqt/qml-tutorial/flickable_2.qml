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
}
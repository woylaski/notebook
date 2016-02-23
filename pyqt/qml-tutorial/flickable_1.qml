import QtQuick 2.0

Flickable
{
    id: flick

    width: 300
    height: 200
    //可拖拽内容大小
    contentWidth: image.width
    contentHeight: image.height

    Image
    {
        id: image
        source: "images/girl.png"
    }
}
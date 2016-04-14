import QtQuick 2.5

//Flickable元素: 它可以将子元素设置在一个可以拖拽和弹动的界面上,使得子项目的视图可以滚动
Flickable {
    id: cFlickable
    pixelAligned: true
    flickableDirection: Flickable.VerticalFlick
}

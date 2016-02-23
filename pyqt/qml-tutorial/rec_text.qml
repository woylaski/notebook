import QtQuick 2.5
import QtQuick.Window 2.2

Item
{
    Rectangle
    {
        color: "blue"
        width: 50
        height: 50
        border.color: "green"
        border.width: 10
        radius: 20
    }

    Text
    {
        //文本
        text: "Hello JDH!"
        //字体
        font.family: "Helvetica"
        //字大小
        font.pointSize: 24
        //颜色
        color: "red"
    }
}
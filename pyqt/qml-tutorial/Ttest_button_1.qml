import QtQuick 2.5
import QtQuick.Window 2.2
/*
属性别名:
将组件中的一个属性设置为可定义
方法:
用关键字property alias将一个属性设置一个别名

1.作为组件的qml文件名首字母必须为大写
2.property alias是关键字,将变量text设置为txt.text的别名
3.变量text由外部调用导入
*/
Rectangle
{
    property alias text: txt.text

    width: 100
    height: 50

    Text
    {
        id:txt
    }
}
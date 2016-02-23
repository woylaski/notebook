/*
ListElement的每个属性都被Repeater绑定到实例化的显示项。
正如上面代码中显示的那样，这意味着每一个用于显示数据的Rectangle作用域内都可以访问到ListElement的name和surfaceColor属性。

像上面几段代码中，Repeater的每一个数据项都使用一个Rectangle渲染。
事实上，这是由于Repeater具有一个delegate的默认属性，由于Rectangle没有显式赋值给任何一个属性，
因此它直接成为默认属性delegate的值，所以才会使用Rectangle渲染。理解了这一点，我们就可以写出具有显式赋值的代码：
*/

import QtQuick 2.2
 
Column {
    spacing: 2
    Repeater {
        model: 10
        delegate: Rectangle {
            width: 100
            height: 20
            radius: 3
            color: "lightBlue"
            Text {
                anchors.centerIn: parent
                text: index
            }
        }
    }
}
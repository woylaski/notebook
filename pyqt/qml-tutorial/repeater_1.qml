/*
将数据从表现层分离的最基本方法是使用Repeater元素。
Repeater元素可以用于显示一个数组的数据，并且可以很方便地在用户界面进行定位。
Repeater的模型范围很广：从一个整型到网络数据，均可作为其数据模型。
*/

/*
Repeater最简单的用法是将一个整数作为其model属性的值。
这个整型代表Repeater所使用的模型中的数据个数。例如下面的代码中，model: 10代表Repeater的模型有 10 个数据项
*/
import QtQuick 2.5
import QtQuick.Window 2.2
 
Column {
    spacing: 2
    Repeater {
        model: 10
        Rectangle {
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
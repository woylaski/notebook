/*
由于能够使用 JavaScript 数组作为Repeater的模型，
而 JavaScript 数组能够以对象作为其元素类型，因而Repeater就可以处理复杂的数据项，比如带有属性的对象。
这种情况其实更为常见。相比普通的 JavaScript 对象，更常用的是ListElement类型。类似普通 JavaScript 对象，
每一个ListElement可以有任意属性。例如下面的代码示例中，每一个数据项都有一个名字和外观颜色
*/

import QtQuick 2.2
 
Column {
    spacing: 2
    Repeater {
        model: ListModel {
            ListElement { name: "Mercury"; surfaceColor: "gray" }
            ListElement { name: "Venus"; surfaceColor: "yellow" }
            ListElement { name: "Earth"; surfaceColor: "blue" }
            ListElement { name: "Mars"; surfaceColor: "orange" }
            ListElement { name: "Jupiter"; surfaceColor: "orange" }
            ListElement { name: "Saturn"; surfaceColor: "yellow" }
            ListElement { name: "Uranus"; surfaceColor: "lightBlue" }
            ListElement { name: "Neptune"; surfaceColor: "lightBlue" }
        }
 
        Rectangle {
            width: 100
            height: 20
            radius: 3
            color: "lightBlue"
            Text {
                anchors.centerIn: parent
                text: name
            }
 
            Rectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 2
 
                width: 16
                height: 16
                radius: 8
                border.color: "black"
                border.width: 1
 
                color: surfaceColor
            }
        }
    }
}
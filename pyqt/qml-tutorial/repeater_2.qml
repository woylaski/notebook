/*
虽然指定模型项的个数很简单，但实际用处不大。
Repeater还支持更复杂的方式，例如，把一个 JavaScript 数组作为模型。
JavaScript 数组元素可以是任意类型：字符串、数字或对象。
在下面的例子中，我们将一个字符串数组作为Repeater的模型。我们当然可以使用index获得当前索引，
同时，我们也可以使用modelData访问到数组中的每一个元素的值：
*/

import QtQuick 2.2
 
Column {
    spacing: 2
    Repeater {
        model: ["Enterprise", "Colombia", "Challenger", "Discovery", "Endeavour", "Atlantis"]
        Rectangle {
            width: 100
            height: 20
            radius: 3
            color: "lightBlue"
            Text {
                anchors.centerIn: parent
                text: index +": "+modelData
            }
        }
    }
}
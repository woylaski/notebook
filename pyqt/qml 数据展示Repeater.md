
## 模型-视图
在 QtQuick 中，数据和显示的分离同样也是利用这种“模型-视图”技术实现的。对于每一个视图，数据元素的可视化显示交给代理完成。与 Qt/C++ 类似，QtQuick 提供了一系列预定义的模型和视图。本章开始，我们着重介绍这部分内容。这部分内容主要来自http://qmlbook.org/ch06/index.html，在此表示感谢。

## 使用Repeater
将数据从表现层分离的最基本方法是使用Repeater元素。Repeater元素可以用于显示一个数组的数据，并且可以很方便地在用户界面进行定位。Repeater的模型范围很广：从一个整型到网络数据，均可作为其数据模型。

Repeater最简单的用法是将一个整数作为其model属性的值。这个整型代表Repeater所使用的模型中的数据个数。例如下面的代码中，model: 10代表Repeater的模型有 10 个数据项。
```
import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: root;
    visible: true

    Column
    {
        spacing: 2
        Repeater
        {
            model: 10
            Rectangle
            {
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
}

```
现在我们设置了 10 个数据项，然后定义一个Rectangle进行显示。每一个Rectangle的宽度和高度分别为 100px 和 20px，并且有圆角和浅蓝色背景。Rectangle中有一个Text元素为其子元素，Text文本值为当前项的索引。

虽然指定模型项的个数很简单，但实际用处不大。Repeater还支持更复杂的方式，例如，把一个 JavaScript 数组作为模型。JavaScript 数组元素可以是任意类型：字符串、数字或对象。在下面的例子中，我们将一个字符串数组作为Repeater的模型。我们当然可以使用index获得当前索引，同时，我们也可以使用modelData访问到数组中的每一个元素的值
```
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
```

**由于能够使用 JavaScript 数组作为Repeater的模型，而 JavaScript 数组能够以对象作为其元素类型，因而Repeater就可以处理复杂的数据项，比如带有属性的对象。这种情况其实更为常见。相比普通的 JavaScript 对象，更常用的是ListElement类型。类似普通 JavaScript 对象，每一个ListElement可以有任意属性。例如下面的代码示例中，每一个数据项都有一个名字和外观颜色。**

```
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
```

**ListElement的每个属性都被Repeater绑定到实例化的显示项。正如上面代码中显示的那样，这意味着每一个用于显示数据的Rectangle作用域内都可以访问到ListElement的name和surfaceColor属性。**

像上面几段代码中，Repeater的每一个数据项都使用一个Rectangle渲染。事实上，这是由于Repeater具有一个delegate的默认属性，由于Rectangle没有显式赋值给任何一个属性，因此它直接成为默认属性delegate的值，所以才会使用Rectangle渲染。理解了这一点，我们就可以写出具有显式赋值的代码：
```
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
```
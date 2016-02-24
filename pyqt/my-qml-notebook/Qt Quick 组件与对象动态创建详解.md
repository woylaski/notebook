
### 简介
Component 是由 Qt 框架或开发者封装好的、只暴露了必要接口的 QML 类型，可以重复利用。一个 QML 组件就像一个黑盒子，它通过属性、信号、函数和外部世界交互。

一个 Component 即可以定义在独立的 qml 文件中，也可以嵌入到其它的 qml 文档中来定义。通常我们可以根据这个原则来选择将一个 Component 定义在哪里：如果一个 Component 比较小且只在某个 qml 文档中使用或者一个 Component 从逻辑上看从属于某个 qml 文档，那就可以采用嵌入的方式来定义该 Component 。你也可以与 C++ 的嵌套类对比来理解。

### 嵌入式定义组件
使用到 Component 的示例 QML 代码如下
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "#C0C0C0";  
      
    Text {  
        id: coloredText;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 4;  
        text: "Hello World!";  
        font.pixelSize: 32;  
    }  
      
    Component {  
        id: colorComponent;  
        Rectangle {  
            id: colorPicker;  
            width: 50;  
            height: 30;  
            signal colorPicked(color clr);  
            MouseArea {  
                anchors.fill: parent  
                onPressed: colorPicker.colorPicked(colorPicker.color);  
            }  
        }  
    }  
      
    Loader{  
        id: redLoader;  
        anchors.left: parent.left;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        onLoaded:{  
            item.color = "red";  
        }  
    }  
      
    Loader{  
        id: blueLoader;  
        anchors.left: redLoader.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        onLoaded:{  
            item.color = "blue";  
        }  
    }  
      
    Connections {  
        target: redLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
      
    Connections {  
        target: blueLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
} 
```

其中，颜色选择组件的定义代码如下：
```
Component {  
    id: colorComponent;  
    Rectangle {  
        id: colorPicker;  
        width: 50;  
        height: 30;  
        signal colorPicked(color clr);  
        MouseArea {  
            anchors.fill: parent  
            onPressed: colorPicker.colorPicked(colorPicker.color);  
        }  
    }  
}  
```

**定义一个 Component 与定义一个 QML 文档类似， Component 只能包含一个顶层 item ，而且在这个 item 之外不能定义任何数据，除了 id 。**

比如上面的代码中，顶层 item 是 Rectangle 对象，在 Rectangle 之外我定义了 id 属性，其值为 colorComponent 。而顶层 item 之内，则可以包含更多的子元素来协同工作，最终形成一个具有特定功能的组件。

Component 通常用来给一个 view 提供图形化组件，比如 ListView::delegate 属性就需要一个 Component 来指定如何显示列表的每一个项，又比如 ButtonStyle::background 属性也需要一个 Component 来指定如何绘制 Button 的背景。

Component 不是 Item 的派生类，而是从 QQmlComponent 继承而来，虽然它通过自己的顶层 item 为其它的 view 提供可视化组件，但它本身是不可见元素。你可以这么理解：你定义的组件是一个新的类型，它必须被实例化以后才可能显示。而要实例化一个嵌入在 qml 文档中定义的组件，则可以通过 Loader 。后面我们详细讲述 Loader ，这里先按下不表，我们要来看如何在一个文件中定义组件了。

### 在单独文件中定义组件
很多时候我们把一个 Component 单独定义在一个 qml 文档中，比如 Qt Quick 提供的 BusyIndicator 控件，其实就是在 BusyIndicator.qml 中定义的一个组件。下面是 BusyIndicator.qml 文件的内容：
```
Control {  
    id: indicator  
  
    property bool running: true  
  
    Accessible.role: Accessible.Indicator  
    Accessible.name: "busy"  
  
    style: Qt.createComponent(Settings.style + "/BusyIndicatorStyle.qml", indicator)  
}  
```

不知你是否注意到了， BusyIndicator.qml 文件中的顶层 item 是 Control ，而我们使用时却是以 BusyIndicator 为组件名（类名）。

**这是我们定义 Component 时要遵守的一个约定：组件名字必须和 qml 文件名一致。好嘛，和 Java 一样啦，类名就是文件名。还有一点，组件名字的第一个字母必须是大写。**

对于在文件中定义一个组件，就这么简单了，再没有其它的特殊要求。 Qt Quick 提供的多数基本元素和特性，你都可以在定义组件时使用。

一旦你在文件中定义了一个组件，就可以像使用标准 Qt Quick 元素一样使用你的组件。比如我们给颜色选择组件起个名字叫 ColorPicker ，对应的 qml 文件为  ColorPicker.qml ，那么你就可以在其它 QML 文档中使用 ColorPicker {...} 来定义 ColorPicker 的实例。

```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    id: colorPicker;  
    width: 50;  
    height: 30;  
    signal colorPicked(color clr);  
      
    function configureBorder(){  
        colorPicker.border.width = colorPicker.focus ? 2 : 0;    
        colorPicker.border.color = colorPicker.focus ? "#90D750" : "#808080";   
    }  
      
    MouseArea {  
        anchors.fill: parent  
        onClicked: {  
            colorPicker.colorPicked(colorPicker.color);  
            mouse.accepted = true;  
            colorPicker.focus = true;  
        }  
    }  
    Keys.onReturnPressed: {  
        colorPicker.colorPicked(colorPicker.color);  
        event.accepted = true;  
    }  
    Keys.onSpacePressed: {  
        colorPicker.colorPicked(colorPicker.color);  
        event.accepted = true;  
    }  
      
    onFocusChanged: {  
        configureBorder();  
    }  
      
    Component.onCompleted: {  
        configureBorder();  
    }  
}  
```

请注意上面的代码，它和嵌入式定义有明显不同： Component 对象不见咧！对，就是酱紫滴：在单独文件内定义组件，不需要 Component 对象，只有在其它 QML 文档中嵌入式定义组件时才需要 Component 对象。另外，为了能够让多个 ColorPicker 组件可以正常的显示焦点框，我还使用了 onClicked 信号处理器，新增了 onFocusChanged 信号处理器，在它们的实现中调用 configureBorder() 函数来重新设置边框的宽度和颜色，新增 onReturnPressed 和 onSpacePressed 以便响应回车和空格两个按键

你可以使用 Item 或其派生类作为组件的根 item 。 ColorPicker 组件使用 Rectangle 作为根 Item 。现在让我们看看如实在其它文件中使用新定义的 ColorPicker 组件。我修改了上节的示例，新的 qml 文件被我命名为 component_file.qml ，内容如下：

```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "#EEEEEE";  
      
    Text {  
        id: coloredText;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 4;  
        text: "Hello World!";  
        font.pixelSize: 32;  
    }  
      
    function setTextColor(clr){  
        coloredText.color = clr;  
    }  
      
    ColorPicker {  
        id: redColor;  
        color: "red";  
        focus: true;  
        anchors.left: parent.left;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
  
        KeyNavigation.right: blueColor;  
        KeyNavigation.tab: blueColor;    
        onColorPicked:{  
            coloredText.color = clr;  
        }        
    }  
      
    ColorPicker {  
        id: blueColor;  
        color: "blue";  
        anchors.left: redColor.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
  
        KeyNavigation.left: redColor;  
        KeyNavigation.right: pinkColor;  
        KeyNavigation.tab: pinkColor;     
    }  
      
    ColorPicker {  
        id: pinkColor;  
        color: "pink";  
        anchors.left: blueColor.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
  
        KeyNavigation.left: blueColor;  
        KeyNavigation.tab: redColor;     
    }  
      
    Component.onCompleted:{  
        blueColor.colorPicked.connect(setTextColor);  
        pinkColor.colorPicked.connect(setTextColor);  
    }  
} 
```

可以看到， component_file.qml 使用 ColorPicker 组件的方式与使用 Rectangle 、 Button 、 Text 等标准 Qt Quick 组件完全一致：可以给组件指定唯一的 id ，可以使用锚布局，可以使用 KeyNavigation 附加属性……总之，自定义的组件和 Qt Quick 组件并无本质不同。不过需要注意的是，组件实例的 id 和组成组件的顶层 item 的 id 是各自独立的，以上面的例子来看， redColor 和 colorPicker 是两个不同的 id ，前者指代组件对象（虽然组件的定义没有使用 Component ），后者指代 ColorPicker 的 Rectangle 对象。

上面的代码还演示两种使用 qml 自定义信号的方式， redColor 使用信号处理器， greeColor 和 pinkColor 则使用了 signal 对象的 connect() 方法连接到 setTextColor() 方法上。

把 ColorPicker.qml 和 component_file.qml 放在同一个文件下面，否则可能会报错

##Loader
Loader 用来动态加载 QML 组件。

Loader 可以使用其 source 属性加载一个 qml 文档，也可以通过其 sourceComponent 属性加载一个 Component 对象。当你需要延迟一些对象直到真正需要才创建它们时， Loader 非常有用。 当 Loader 的 source 或 sourceComponent 属性发生变化时，它之前加载的 Component 会自动销毁，新对象会被加载。将 source 设置为一个空字符串或将 sourceComponent 设置为 undefined ，将会销毁当前加载的对象，相关的资源也会被释放，而 Loader 对象则变成一个空对象。

Loader 的 item 属性指向它加载的组件的顶层 item ，比如 Loader 加载了我们的颜色选择组件，其 item 属性就指向颜色选择组件的 Rectangle 对象。对于 Loader 加载的 item ，它暴露出来的接口，如属性、信号等，都可以通过 Loader 的 item 属性来访问。所以我们才可以这么使用：
```
Loader{  
    id: redLoader;  
    anchors.left: parent.left;  
    anchors.leftMargin: 4;  
    anchors.bottom: parent.bottom;  
    anchors.bottomMargin: 4;  
    sourceComponent: colorComponent;  
    onLoaded:{  
        item.color = "red";  
    }  
}  
```

上面的代码在 Loader 对象使用 sourceComponent 属性来加载 id 为 colorComponent 的组件对象，然后在 onLoaded 信号处理器中使用 item 属性来设置颜色选择组件的颜色。对于信号的访问，我们则可以使用 Connections 对象，如下面的 qml 代码所示：
```
Connections {  
    target: redLoader.item;  
    onColorPicked:{  
        coloredText.color = clr;  
    }  
} 
```

 我们创建的 Connections 对象，其 target 指向 redLoader.item ，即指向颜色选择组件的顶层 item —— Rectangle ，所以可以直接响应它的 colorPicked 信号。

 虽然 Loader 本身是 Item 的派生类，但没有加载 Component 的 Loader 对象是不可见的，没什么实际的意义。而一旦你加载了一个 Component ， Loader 的大小、位置等属性却可以影响它所加载的 Component 。如果你没有显式指定 Loader 的大小，那么 Loader 会将自己的尺寸调整为与它加载的可见 item 的尺寸一致；如果 Loader 的大小通过 width 、 height 或 锚布局显式设置了，那么它加载的可见 item 的尺寸会被调整以便适应 Loader 的大小。不管是哪种情况， Loader 和它所加载的 item 具有相同的尺寸，这确保你使用锚来布局 Loader 就等同于布局它加载的 item 。

 我们改变一下颜色选择器示例的代码，两个 Loader 对象，一个设置尺寸一个不设置，看看是什么效果。新的 qml 文档我们命名为 loader_test.qml ，内容如下：

```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "#C0C0C0";  
      
    Text {  
        id: coloredText;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 4;  
        text: "Hello World!";  
        font.pixelSize: 32;  
    }  
      
    Component {  
        id: colorComponent;  
        Rectangle {  
            id: colorPicker;  
            width: 50;  
            height: 30;  
            signal colorPicked(color clr);  
            MouseArea {  
                anchors.fill: parent  
                onPressed: colorPicker.colorPicked(colorPicker.color);  
            }  
        }  
    }  
      
    Loader{  
        id: redLoader;  
        width: 80; // [1]  
        height: 60;// [2]  
        anchors.left: parent.left;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        onLoaded:{  
            item.color = "red";  
        }  
    }  
      
    Loader{  
        id: blueLoader;  
        anchors.left: redLoader.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        onLoaded:{  
            item.color = "blue";  
        }  
    }  
      
    Connections {  
        target: redLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
      
    Connections {  
        target: blueLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
}  
```

如果 Loader 加载的 item 想处理按键事件，那么必须将 Loader 对象的 focus 属性置 true 。又因为 Loader 本身也是一个焦点敏感的对象，所以如果它加载的 item 处理了按键事件，应当将事件的 accepted 属性置 true ，以免已经被吃掉的事件再传递给 Loader 。我们来修改下 loader_test.qml ，加入对焦点的处理，当一个颜色组件拥有焦点时，绘制一个边框，此时如果你按下回车或空格键，会触发其 colorPicked 信号。同时我们也处理左右键，在不同的颜色选择组件之间切换焦点。将新代码命名为 loader_focus.qml ，内容如下：
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "#EEEEEE";  
      
    Text {  
        id: coloredText;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 4;  
        text: "Hello World!";  
        font.pixelSize: 32;  
    }  
      
    Component {  
        id: colorComponent;  
        Rectangle {  
            id: colorPicker;  
            width: 50;  
            height: 30;  
            signal colorPicked(color clr);  
            property Item loader;  
            border.width: focus ? 2 : 0;    
            border.color: focus ? "#90D750" : "#808080";   
            MouseArea {  
                anchors.fill: parent  
                onClicked: {  
                    colorPicker.colorPicked(colorPicker.color);  
                    loader.focus = true;  
                }  
            }  
            Keys.onReturnPressed: {  
                colorPicker.colorPicked(colorPicker.color);  
                event.accepted = true;  
            }  
            Keys.onSpacePressed: {  
                colorPicker.colorPicked(colorPicker.color);  
                event.accepted = true;  
            }  
        }  
    }  
      
    Loader{  
        id: redLoader;  
        width: 80;  
        height: 60;  
        focus: true;  
        anchors.left: parent.left;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        KeyNavigation.right: blueLoader;  
        KeyNavigation.tab: blueLoader;  
          
        onLoaded:{  
            item.color = "red";  
            item.focus = true;  
            item.loader = redLoader;  
        }  
        onFocusChanged:{  
            item.focus = focus;  
        }  
    }  
      
    Loader{  
        id: blueLoader;  
        anchors.left: redLoader.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        sourceComponent: colorComponent;  
        KeyNavigation.left: redLoader;  
        KeyNavigation.tab: redLoader;  
          
        onLoaded:{  
            item.color = "blue";  
            item.loader = blueLoader;  
        }  
        onFocusChanged:{  
            item.focus = focus;  
        }          
    }  
  
    Connections {  
        target: redLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
      
    Connections {  
        target: blueLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
        }  
    }  
}  
```

### 从文件加载组件
之前介绍 Loader 时，我们以嵌入式定义的 Component 为例子说明 Loader 的各种特性和用法，现在我们来看如何从文件加载组件。

对于定义在一个独立文件中的 Component ，同样可以使用 Loader 来加载，只要指定 Loader 的 source 属性即可。现在再来修改下我们的例子，使用 Loader 来加载 ColorPicker 组件。

新的 qml 文档我命名为 loader_component_file.qml ，内容如下：
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "#EEEEEE";  
      
    Text {  
        id: coloredText;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 4;  
        text: "Hello World!";  
        font.pixelSize: 32;  
    }  
      
    Loader{  
        id: redLoader;  
        width: 80;  
        height: 60;  
        focus: true;  
        anchors.left: parent.left;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        source: "ColorPicker.qml";  
        KeyNavigation.right: blueLoader;  
        KeyNavigation.tab: blueLoader;  
          
        onLoaded:{  
            item.color = "red";  
            item.focus = true;  
        }  
          
        onFocusChanged:{    
            item.focus = focus;  
        }  
    }  
      
    Loader{  
        id: blueLoader;  
        focus: true;  
        anchors.left: redLoader.right;  
        anchors.leftMargin: 4;  
        anchors.bottom: parent.bottom;  
        anchors.bottomMargin: 4;  
        source: "ColorPicker.qml";  
        KeyNavigation.left: redLoader;  
        KeyNavigation.tab: redLoader;  
          
        onLoaded:{  
            item.color = "blue";  
        }  
          
        onFocusChanged:{  
            item.focus = focus;  
        }    
    }  
  
    Connections {  
        target: redLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
            if(!redLoader.focus){  
                redLoader.focus = true;  
                blueLoader.focus = false;  
            }  
        }  
    }  
      
    Connections {  
        target: blueLoader.item;  
        onColorPicked:{  
            coloredText.color = clr;  
            if(!blueLoader.focus){  
                blueLoader.focus = true;  
                redLoader.focus = false;  
            }  
        }  
    }  
}  
```
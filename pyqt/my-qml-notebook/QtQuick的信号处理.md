
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "gray";  
      
    Button {  
        text: "Quit";  
        anchors.centerIn: parent;  
        onClicked: {  
            Qt.quit();  
        }  
    }  
}  
```

>onClicked:{}

对，就是这个 onClicked ，其实就包含了 QML  中使用信号与槽的一般形式：信号处理器。

### 信号处理器
信号处理器，其实等价于 Qt 中的槽。但是我们没有看到类似 C++ 中的明确定义的函数……没错，就是这样，你的的确确只看到了一对花括号！对啦，这是 JavaScript 中的代码块。其实呢，你可以理解为它是一个匿名函数。而 JavaScript 中的函数，其实具名的代码块。函数的好处是你可以在其它地方根据名字调用它，而代码块的好处是，除了定义它的地方，没人能调用它，一句话，它是私有的。代码块就是一系列语句的组合，它的作用就是使语句序列一起执行

让我们回头再看信号处理器，它的名字还有点儿特别，一般是 on{Signal} 这种形式。在上节的示例中， Button 元素有一个名为 clicked() 的信号，我们提供的信号处理器是酱紫的
```
onClicked: {  
    Qt.quit();  
}  
```

当信号是 clicked() 时，信号处理器就命名为 onClicked 。就这么简单，以 on 起始后跟信号名字（第一个字母大写）。如果你点击我们的 quit 按钮，应用就真的退出了

上面的示例，信号处理器放在拥有信号的元素内部，当元素信号发射时处理器被调用。还有一种情况，要处理的信号不是当前元素发出来的，而是来自其它类型（对象）比如处理按键的 Keys ，这就是附加信号处理器。

### 附加信号处理器
在 QML 语言的语法中，有一个附加属性（attached properties）和附加信号处理器（attached signal handlers）的概念，这是附加到一个对象上的额外的属性。从本质上讲，这些属性是由附加类型（attaching type）来实现和提供的，它们可能被附加到另一种类型的对象上。附加属性与普通属性的区别在于，对象的普通属性是由对象本身或其基类（或沿继承层级向上追溯的祖先们）提供的。
```
import QtQuick 2.0  
  
Item {  
    width: 100;   
    height: 100;  
  
    focus: true;  
    Keys.enabled: false;  
    Keys.onReturnPressed: console.log("Return key was pressed");  
}
```

你看， Item 对象可以访问和设置 Keys.enabled 和 Keys.onReturnPressed 的值。
enabled 是 Keys 对象的一个属性。 
onReturnPressed 其实是 Keys 对象的一个信号。

对于附加信号处理器，和前面讲到的普通信号处理器又有所不同。普通信号处理器，你先要知道信号名字，然后按照 on{Signal} 的语法来定义信号处理器的名字；而附加信号处理器，信号名字本身已经是 onXXX 的形式，你只要通过附加类型名字引用它，把代码块赋值给它即可

```
Rectangle {  
    width: 320;  
    height: 480;  
    color: "gray";  
      
    focus: true;  
    Keys.enabled: true;  
    Keys.onEscapePressed: {  
        Qt.quit();  
    }  
}  
```

Component 对象也有一些附加信号，如 Component.onCompleted() 、 Component.onDestruction() 。可以用来在 Component 创建完成或销毁时执行一些 JavaScript 代码来做与初始化或反初始化相关的工作。比如下面的代码：
```
Rectangle {  
    Component.onCompleted: console.log("Completed Running!");  
    Component.onDestruction: console.log("Destruction Beginning!");  
}  
```

信号处理器与附加信号处理器有一个共性：响应信号的代码都放在元素内部，通过 JavaScript 代码块就地实现。而其实呢， Qt Quick 中还有另外一种方式来处理信号与槽，那就是：专业的 Connections 。

### Connections
一个 Connections 对象创建一个到 QML 信号的连接。
前面两节在处理 QML 信号时，都是用 on{Signal} 这种就地代码块的方式。而在有些情况下，这样的处理并不方便。比如：

- 你需要将多个对象连接到同一个 QML 信号上
- 你需要在发出信号的对象的作用域之外来建立连接
- 发射信号的对象没有在 QML 中定义（可能是通过 C++ 导出的，这很常见）

 Connections 有一个属性名为 target ，它呢，指向发出信号的对象。
下面就看看 Connections 怎么使用。一般的用法：
```
Connections {  
    target: area;  
    on{Signal}: function or code block;  
} 
```
来看一个实际的示例，是酱紫的：界面上放置两个文本，一个按钮，每点按钮一次，两个文本对象都变颜色，而它们的颜色随机的。下面是示例代码：
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "gray";  
      
    Text {  
        id: text1;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: parent.top;  
        anchors.topMargin: 20;  
        text: "Text One";  
        color: "blue";  
        font.pixelSize: 28;  
    }  
      
    Text {  
        id: text2;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        anchors.top: text1.bottom;  
        anchors.topMargin: 8;  
        text: "Text Two";  
        color: "blue";  
        font.pixelSize: 28;  
    }  
      
    Button {  
        id: changeButton;  
        anchors.top: text2.bottom;  
        anchors.topMargin: 8;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        text: "Change";  
    }  
      
    Connections {  
        target: changeButton;  
        onClicked: {  
            text1.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);  
            text2.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);  
        }  
    }  
}  
```


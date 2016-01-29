1、qml 模块的导入、版本
在目录：Qt5.5.1\5.5\mingw492_32\qml\QtQuick\Controls 中
看到Button 、 Label 等文件。
想问一下平时写qml， import QtQuick 2.2 是不是这个目录下的内容。

在这个路径下Qt5.5.1\5.5\mingw492_32\qml\QtQuick\Controls ，有一个qmldir文件，打开你会发现里面第一行是module QtQuick.Controls，你平时写qml时，import QtQuick.Controls 1.2就应该是这个，1.2是版本号；这个路径下应该没有QtQuick 2.2 

2、qml是区分大小写的

3、qml中子元素的坐标x、y是相对于父元素的。

4、元素的颜色
 color ： "read";
 color ： "lightgreen";
 color: "#D8D8D8" // 颜色属性
 QML 中的颜色值可以使用颜色名字，也可以使用 # 十六进制的形式。这里的颜色名字同 SVG 颜色定义一致，具体可以参见
 http://www.w3.org/TR/css3-color/#svg-color

5、图片元素
```
    Image {
    	id: rocket
        x: (parent.width - width)/2; y: 40 // 使用 parent 引用父元素
        source: 'assets/rocket.png'
    }
```

6、文本元素
```
    // 根元素的另一个子元素
    Text {
        // 该元素未命名
        y: rocket.y + rocket.height + 20 // 使用 id 引用元素
        width: root.width // 使用 id 引用元素
        horizontalAlignment: Text.AlignHCenter
        text: 'Rocket'
    }
```

7、自定义属性
 系统提供的属性肯定是不够的。所以 QML 允许我们自定义属性。我们可以使用property关键字声明一个自定义属性，后面是属性类型和属性名，最后是属性值。声明自定义属性的语法是
 ```
 property <type> <name> : <value>
 ```
 如果没有默认值，那么将给出系统类型的默认值。

```
Text {
    // (1) 标识符
    id: thisLabel
    // (2) x、y 坐标
    x: 24; y: 16
    // (3) 绑定
    height: 2 * width
    // (4) 自定义属性
    property int times: 24
    // (5) 属性别名
    property alias anotherTimes: times
    // (6) 文本和值
    text: "Greetings " + times
    // (7) 字体属性组
    font.family: "Ubuntu"
    font.pixelSize: 24
    // (8) 附加属性 KeyNavigation
    KeyNavigation.tab: otherLabel
    // (9) 属性值改变的信号处理回调
    onHeightChanged: console.log('height:', height)
    // 接收键盘事件需要设置 focus
    focus: true
    // 根据 focus 值改变颜色
    color: focus?"red":"black"
}
```

8、属性和信号
 每一个属性都可以发出信号，因而都可以关联信号处理函数。这个处理函数将在属性值变化时调用。这种值变化的信号槽命名为
 ```
 on + 属性名 + Changed
 ```
 其中属性名要首字母大写。例如上面的例子中，height属性变化时对应的槽函数名字就是onHeightChanged

9、qml和javascript
 ```
Text {
    id: label
    x: 24; y: 24
    // 自定义属性，表示空格按下的次数
    property int spacePresses: 0
    text: "Space pressed: " + spacePresses + " times"
    // (1) 文本变化的响应函数
    onTextChanged: console.log("text changed to:", text)
    // 接收键盘事件，需要设置 focus 属性
    focus: true
    // (2) 调用 JavaScript 函数
    Keys.onSpacePressed: {
        increment()
    }
    // 按下 Esc 键清空文本
    Keys.onEscapePressed: {
        label.text = ''
    }
    // (3) 一个 JavaScript 函数
    function increment() {
        spacePresses = spacePresses + 1
    }
}
 ```

 Text 元素会发出textChanged信号。我们使用 on + 信号名，信号名首字母大写的属性表示一个槽函数。也就是说，当 Text 元素发出textChanged信号时，onTextChanged就会被调用。类似的，onSpacePressed属性会在空格键按下时被调用。此时，我们调用了一个 JavaScript 函数。

 QML 文档中可以定义 JavaScript 函数，语法同普通 JavaScript 函数一样。
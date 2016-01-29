## qml输入元素

MouseArea，用于接收鼠标的输入，键盘输入的两个元素：TextInput和TextEdit。

### TextInput
 TextInput是单行的文本输入框，支持验证器、输入掩码和显示模式等
 ```
import QtQuick 2.0
Rectangle {
    width: 200
    height: 80
    color: "linen"

    TextInput {
        id: input1
        x: 8; y: 8
        width: 96; height: 20
        focus: true
        text: "Text Input 1"
    }

    TextInput {
        id: input2
        x: 8; y: 36
        width: 96; height: 20
        text: "Text Input 2"
    }
}
 ```
**注意，我们这里放置了两个TextInput，用户可以通过点击输入框改变焦点。如果我们想支持键盘导航，可以添加KeyNavigation附加属性。**

```
import QtQuick 2.0

Rectangle {
    width: 200
    height: 80
    color: "linen"

    TextInput {
        id: input1
        x: 8; y: 8
        width: 96; height: 20
        focus: true
        text: "Text Input 1"
        KeyNavigation.tab: input2
    }

    TextInput {
        id: input2
        x: 8; y: 36
        width: 96; height: 20
        text: "Text Input 2"
        KeyNavigation.tab: input1
    }
}
```
按键盘tab键 就会定位到input1

封装一个LineEdit组件
```
import QtQuick 2.0

Rectangle {
    width: 200
    height: 80
    color: "linen"

    LineEdit {
        id: input1
        x: 8; y: 8
        width: 96; height: 20
        focus: true
        text: "Text Input 1"
        KeyNavigation.tab: input2
    }

    LineEdit {
        id: input2
        x: 8; y: 36
        width: 96; height: 20
        text: "Text Input 2"
        KeyNavigation.tab: input1
    }
}
```
现在再来试试键盘导航。这次无论怎么按键盘，焦点始终不会到input2。虽然我们在组件中添加了focus: true，可是不起作用。原因是，焦点被inputText的父组件Rectangle获得，然而，Rectangle不会将焦点转发给inputText。为了解决这一问题，QML提供了另外一个组件FocusScope。

当FocusScope接收到焦点时，会将焦点转发给最后一个设置了focus:true的子对象。所以，我们可以使用FocusScope重写LineEdit组件：

```
// LineEdit.qml

import QtQuick 2.0

FocusScope {
    width: 96;
    height: input.height + 8
    color: "lightsteelblue"
    border.color: "gray"

    property alias text: input.text
    property alias input: input

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 4
        focus: true
    }
}
```

### TextEdit
extEdit与TextInput非常类似，唯一区别是TextEdit是多行的文本编辑组件。与TextInput类似，TextEdit也没有一个可视化的显示，所以我们也需要自己绘制其显示区域。这些内容与前面代码几乎一样，这里不再赘述。

附加属性Keys类似于键盘事件，允许我们相应特定的按键按下事件。例如，我们可以利用方向键控制举行的位置，如下代码所示：

```
import QtQuick 2.0

DarkSquare {
    width: 400; height: 200

    GreenSquare {
        id: square
        x: 8; y: 8
    }
    focus: true
    Keys.onLeftPressed: square.x -= 8
    Keys.onRightPressed: square.x += 8
    Keys.onUpPressed: square.y -= 8
    Keys.onDownPressed: square.y += 8
    Keys.onPressed: {
        switch(event.key) {
            case Qt.Key_Plus:
                square.scale += 0.2
                break;
            case Qt.Key_Minus:
                square.scale -= 0.2
                break;
        }
    }
}
```
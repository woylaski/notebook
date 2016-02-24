Qt QML—QML signal与signal handler系统

### 简介
QML 的signal 和 signal handler机制的存在，是为了应用能够和UI组件之间相互交互。signal就是button clicked、mouse area pressed这些event， signal handler 则就是这些事件的响应。
当一个signal emitted，相应的signal handler就会被调用，在signal handler中执行一些scripts或是其他操作，已完成event的响应。

### signal和signal handler的定义
signal
```
signal <signalName>[([<type> <parameter name>[, ...]])]
```

signal handler
```
on<SignaleName>
```

### Property Change Signal Handler
当Property的值改变了，就会自动emitted一个signal，这种property changed signal，有property Signal handler与之对应。你只需要实现signal handler即可。
```
on<PropertyName>Changed
```

### 使用Connections Type
很多人都知道Qt一个很好的东西，就是 signal 和 slot 机制。你可以很方便的connect的signal和slot。QML中的Connections，它能够让你接收指定object的任意signal，从而能够在signal声明的那个Object之外接收到声明的signal，从而实现自己想要logic。

```
import QtQuick 2.0

Rectangle {
    id: rect
    width: 100; height: 100

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Connections {
        target: mouseArea
        onClicked: {
            rect.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
        }
    }
}
```
上面的代码中，Connections中的target绑定的是MouseArea，从而在rect中能够接收到mouseArea的signal，如clicked、pressed、released等等signal。

### 附带的signal handler
附带的signal handler是附带组件的signal与之对应的signal handler，并不是使用附带组件本身Object的signal的signal handler。

### signal与signal的连接，signal与method的连接
signal 都有一个connect()方法，可以连接method或者signal。

可以看下面两段代码
### signal connect signal
```
Rectangle {
    id: forwarder
    width: 100; height: 100

    signal send()
    onSend: console.log("Send clicked")

    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: console.log("MouseArea clicked")
    }

    Component.onCompleted: {
        mousearea.clicked.connect(send)
    }
}
```

注意: mousearea.clicked.connect(send)，这里send是signal但是却没有加或括号。emitted signal的时候则不论是否signal声明的时候有无括号，都须要加上括号。

### signal connect method
```
Rectangle {
    id: relay

    signal messageReceived(string person, string notice)

    Component.onCompleted: {
        relay.messageReceived.connect(sendToPost)
        relay.messageReceived.connect(sendToTelegraph)
        relay.messageReceived.connect(sendToEmail)
    }

    function sendToPost(person, notice) {
        console.log("Sending to post: " + person + ", " + notice)
    }
    function sendToTelegraph(person, notice) {
        console.log("Sending to telegraph: " + person + ", " + notice)
    }
    function sendToEmail(person, notice) {
        console.log("Sending to email: " + person + ", " + notice)
    }
}
```

注意： 这里使用connect连接是的method，同样没有加上括号。
既然能够connect，那有没有disconnect呢？当然有。

有时候，你不使用disconnect，你某些动态create的对象都无法distroy。

```
Rectangle {
    id: relay
    //...

    function removeTelegraphSignal() {
        relay.messageReceived.disconnect(sendToTelegraph)
    }
}
```
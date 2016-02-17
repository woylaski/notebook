QML ---- Keyboard Focus in QML --- 键盘交互

http://blog.sina.com.cn/s/blog_67c294ca01013vcv.html

当一个键被按或者释放的时候，一个Key事件就被创建并且传递给当前 QML中焦点Item。
 
1. 按键处理概述
当用户按或者释放一个按键的时候，如下将发生：
QT 接受到按键动作，并且产生一个按键事件
如果QT 包含有 QDeclarativeView Widget 有焦点， 那么key事件传递给他， 否则例行Key处理继续
如果没有一个Item有active focus, 那么key事件被忽略， 例行Key处理继续
如果一个active focus的item 接受了key 事件， 那么Key事件的“遗传”停止。否则， Key事件将冒泡一样递归的往父Item传递， 直到事件被接收或者到根Item
如果根Item到达，按键事件将被忽略， 例行按键处理继续
2. 获取focus以及focus scope
  一下代码为MyWidget.qml, 是一个长条，当按键A/B/C改变长条的TEXT。
Rectangle { color: "lightsteelblue"; width: 240; height: 25 Text { id: myText } Item { id: keyHandler focus: true Keys.onPressed: { if (event.key == Qt.Key_A) myText.text = 'Key A was pressed' else if (event.key == Qt.Key_B) myText.text = 'Key B was pressed' else if (event.key == Qt.Key_C) myText.text = 'Key C was pressed' } } }

将以上QML作为一个组件，用于别的QML， 如:
//Window code that imports MyWidget Rectangle { id: window color: "white"; width: 240; height: 150 Column { anchors.centerIn: parent; spacing: 15 MyWidget { focus: true //set this MyWidget to receive the focus color: "lightblue" } MyWidget { color: "palegreen" } } }

运行结果如下：
QML <wbr>---- <wbr>Keyboard <wbr>Focus <wbr>in <wbr>QML <wbr>--- <wbr>键盘交互

看看上面的代码，显然存在一个明显的问题：
有三个元素设置focus属性为true, 两个MyWidget分别设置focus为true, window组件也设置focus.事实上，仅仅只有一个元素可以获得键盘焦点， 系统不得不去决定哪个元素该获得焦点。
 
问题变得很清晰了。MyWidget组件将获得焦点，但是它不能控制当他重用或者导入的时候的focus, 同样，window组件也没有能力知道是否它里面导入的组件正请求focus.
 
为解决这个问题， QML推出了一个概念，叫focus scope, 一个focus scope就像focus的代理。一个focus scope用FocusScope来表示。
 
修改MyWidget组件如下：
FocusScope { //FocusScope needs to bind to visual properties of the Rectangle property alias color: rectangle.color x: rectangle.x; y: rectangle.y width: rectangle.width; height: rectangle.height Rectangle { id: rectangle anchors.centerIn: parent color: "lightsteelblue"; width: 175; height: 25; radius: 10; smooth: true Text { id: label; anchors.centerIn: parent } focus: true Keys.onPressed: { if (event.key == Qt.Key_A) label.text = 'Key A was pressed' else if (event.key == Qt.Key_B) label.text = 'Key B was pressed' else if (event.key == Qt.Key_C) label.text = 'Key C was pressed' } } }
在这里小小总结一下QML文件中如何加载QML文件与JavaScript文件。

1、QML文件中加载JavaScript文件
语法：
```
import <ModuleIdentifier> <Version.Number> [as <Qualiflier>]
```
ModuleIdentifier为URL；
Version.Number为版本号；
Qualifier为自定义命名；
示例代码如下：
Qml文件：
```
import QtQuick 2.0
import "../js/monitor.js" as Monitor

Canvas {
	id: canvas
	anchors.margins: 10

	onPaint: {
		Monitor.clear();
		Monitor.draw();
	}
}
```

js文件
```
function clear(){

}

function draw(){

}
```

==注：将js文件引入后可直接调用里面的函数，自定义命名首字母必须大写，不然后报如下错误：==
>Invalid import qualifier ID

2、QML文件中加载QML文件
语法：
```
import <moduleIdentifier> <Version.Number> [as <Qualifier>]
```
ModuleIdentifier为URL
Version.Number为版本号
Qualifier为自定义命名

示例代码如下：
```
import "qml/"
Rectangle{
	anchors.fill: parent
	Monitor{
		anchors.fill: parent
		anchors.centerIn: parent
	}

	Compass{
		anchors.left: parent.left
		anchors.bottom: parent.bottom
	}
}
```

Import“qml/”中，qml为文件夹，里面有Monitor.qml和Compass.qml两个文件qml/为文件夹的相对路径

3、js文件中加载js文件
方法一:

.import "common.js" as Common

用法如同QML文件中加载JavaScript文件

方法二

Qt.include("common.js")

用法如同QML文件中加载QML文件，加载后可直接调用被加载文件中的函数
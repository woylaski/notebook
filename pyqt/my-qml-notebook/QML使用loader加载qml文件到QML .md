QML的Loader元素经常备用来动态加载QML组件。可以使用source属性或者sourceComponent属性加载。这个元素最有用的地方是它能在qml组件需要的时候再创建，即延迟创建QML的时间。
 
1、
[css] view plaincopy
main.qml  
------------------------------------  
import QtQuick 1.0  
  
Item {  
    property bool isFirst : false;  
    width: 200  
    height: 200  
  
    Loader {  
        id: pageLoader  
    }  
  
    MouseArea {  
        anchors.fill: parent  
        onClicked: changePage();  
    }  
  
    function changePage() {  
        if(isFirst) {  
            pageLoader.source = "Page1.qml"  
        } else {  
            pageLoader.source = "Page2.qml"  
        }  
  
        isFirst = !isFirst;  
    }  
  
}  
  
  
Page1.qml  
-------------------------------------  
import QtQuick 1.0  
  
Rectangle {  
    width: 100  
    height: 62  
    Text {  
        anchors.centerIn: parent  
        text: "Page1 Test"  
    }  
}  
  
  
Page2.qml  
---------------------------------------  
import QtQuick 1.0  
  
Rectangle {  
    width: 100  
    height: 62  
    Text {  
        anchors.centerIn: parent  
        text: "Page1 Test"  
    }  
}  
 
2、上面的代码就能界面在Page1和Page2之间切换了，别忘了还能使用sourceComponent属性:
[css] view plaincopy
main.qml  
--------------------------------------  
import QtQuick 1.0  
  
Item {  
    property bool isFirst : false;  
    width: 200  
    height: 200  
  
    Loader {  
        id: pageLoader  
        sourceComponent: rect  
    }  
  
    MouseArea {  
        anchors.fill: parent  
        onClicked: changePage();  
    }  
  
    function changePage() {  
        if(isFirst) {  
            pageLoader.source = "Page1.qml"  
        } else {  
            pageLoader.source = "Page2.qml"  
        }  
  
        isFirst = !isFirst;  
    }  
  
    Component {  
        id: rect  
        Rectangle {  
            width: 200  
            height: 50  
            color: "red"  
            Text {  
                text: "Default Page"  
                anchors.fill: parent  
            }  
        }  
    }  
  
}  
上面的代码实现了默认加载组件功能.
 
 
3、接收来自加载的qml发出的信号
使用Connections元素可以接收到任何发送自加载组件的信号。
 
[css] view plaincopy
main.qml  
---------------------------------------  
import QtQuick 1.0  
  
Item {  
    property bool isFirst : false;  
    width: 200  
    height: 200  
  
    Loader {  
        id: pageLoader  
        source: "Page1.qml"  
    }  
  
  
    Connections {  
        target: pageLoader.item  
        onMessage: console.log(msg);  
    }  
  
}  
  
Page1.qml  
----------------------------------------------  
import QtQuick 1.0  
  
Rectangle {  
    id: myItem  
    signal message(string msg)  
    width: 100; height: 100  
  
    MouseArea {  
        anchors.fill: parent  
        onClicked: myItem.message("clicked!");  
    }  
}  
 
 
4、加载与被加载组件中都有相同的事件，那么需要设置Loader的属性focus为true，且设置被加载组件 focus: true才能让事件不被传播到被加载组件。
 
[css] view plaincopy
main.qml  
-------------------------------------  
import QtQuick 1.0  
  
Item {  
    property bool isFirst : false;  
    width: 200  
    height: 200  
  
    Loader {  
        id: pageLoader  
        source: "Page2.qml"  
        focus: true  
    }  
    
    Keys.onPressed: {  
        console.log("Captured: ", event.text);  
         event.accepted = true;  
    }  
  
}  
  
  
Page2.qml  
---------------------------------  
import QtQuick 1.0  
  
Rectangle {  
    width: 100  
    height: 62  
    Text {  
        anchors.centerIn: parent  
        text: "Page2 Test"  
    }  
    focus: true  
    Keys.onPressed: {  
        console.log("Loaded item captured: ", event.text);  
        event.accepted = true;  
    }  
}  
 如果在Page2.qml中去掉event.accepted = true;那么main.qml和Page2.qml都会接收到按键事件，也就是说按键事件会传播到main.qml中
 
5、Loader的 onStatusChanged和onLoaded事件
 
[css] view plaincopy
main.qml  
-------------------------------------  
import QtQuick 1.0  
  
Item {  
    property bool isFirst : false;  
    width: 200  
    height: 200  
  
    Loader {  
        id: pageLoader  
        source: "Page2.qml"  
        focus: true  
        onStatusChanged:  console.log(pageLoader.status == Loader.Ready)  
        onLoaded: console.log("Loaded")  
    }  
  
    MouseArea {  
        anchors.fill: parent  
        onClicked: changePage();  
    }  
  
    function changePage() {  
        if(isFirst) {  
            pageLoader.source = "Page1.qml"  
        } else {  
            pageLoader.source = "Page2.qml"  
        }  
  
        isFirst = !isFirst;  
    }  
  
    Component {  
        id: rect  
        Rectangle {  
            width: 200  
            height: 50  
            color: "red"  
            Text {  
                text: "Default Page"  
                anchors.fill: parent  
            }  
        }  
    }  
  
    Keys.onPressed: {  
        console.log("Captured: ", event.text);  
         event.accepted = true;  
    }  
  
}  
###如何寻找感兴趣的信号
怎样找到你感兴趣的信号呢？

###Qt 帮助
首先是查阅 Qt 帮助，你可以使用 Qt 帮助的索引模式，以你关心的对象名字为关键字检索，比如 Button ，检索结果如图 7 所示
![qt-help-1](http://img.blog.csdn.net/20140611112943531?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZm9ydW9r/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

图7 使用 Qt 帮助索引模式检索 Button 对象
有时你会在查找结果中看到多个连接，点进去看看是否是 QML 类型即可。

还有另外一种方式，使用 Qt 帮助的目录模式。如图 8 所示：
![qt-help-2](http://img.blog.csdn.net/20140611113305390?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZm9ydW9r/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
 图 8 使用 Qt 帮助目录模式

一旦你找到一个对象的文档，你可以找到它的部分信号说明。还是以 Button 为例，看图 9：

![qt-help-3](http://img.blog.csdn.net/20140611113523468?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZm9ydW9r/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

 图 9 Button 的信号 clicked()

Qt Quick  相关类型的文档中，你可以看到对象的属性和信号。列为属性的，可以在 QML 中访问；列为信号的，可以连接它，通过信号处理器来响应用于操作。

至于具体某个属性或信号是何含义，点击它们，跟过去看看吧。

话说，Qt 的文档是否列出了 Qt Quick 类型的所有信号了呢？想必我这么说你用脚趾头也可以想到答案：没有！个人认为这是 Qt 5.2 文档关于 Qt Quick 和 QML 类型手册的一个缺失。前面提到 QML 中的信号，一类是输入事件触发的，一类是属性变化触发的。文档中缺失的，正是属性变化触发的那些信号。不过呢，不过我们有办法找到它。

###从 Qt Quick 头文件查看属性相关的信号
要说呢， Qt Quick 中你看到的很多对象，都是 Qt C++ 中实现，然后导入到 QML 环境中的。所以呢，如果你关心那些被文档隐藏了的信号，可以这么做：

- 找到 QML 类型对应的 C++ 类型
- 找到 C++ 类型的头文件，查看属性声明来确认是否有信号与属性关联

怎么找 QML 类型对应的 C++ 类型呢？很简单，只需要使用 Component.onCompleted 附加信号，在附加信号处理器中输出类型信息即可。示例代码：
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "gray";  
      
    Text {  
        id: text1;  
        anchors.centerIn: parent;  
        text: "Hello World!";  
        color: "blue";  
        font.pixelSize: 32;  
    }  
      
    Button {  
        id: button1;  
        text: "A Button";  
        anchors.top: text1.bottom;  
        anchors.topMargin: 4;  
    }  
      
    Image {  
        id: image1;  
    }  
      
    Component.onCompleted: {  
        console.log("QML Text\'s C++ type - ", text1);  
        console.log("QML Button\'s C++ type - ", button1);  
        console.log("QML Image\'s C++ type - ", image1);  
    }  
}  
```
如代码所示，我们使用 console 对象来输出 QML 对象，它会打印出 QML 对象的实际类型

别看界面效果哦，注意看命令行窗口的输出。对，QML Text 对应的 C++ 类型是 QQuickText ， QML Image 对应的 C++ 类型是 QQuickImage ，而 Button ，其实是 QML 中定义的对象（含有 QMLTYPE 字样）。我这里使用的 Qt 5.2.0 ，如果是其他的 Qt 版本，比如 Qt 4.7 / Qt 4.8 ，能不能看到我就不知道了。

下面我们就以 QQuickText 为例，找到它的头文件，路径是 C:\Qt\Qt5.2.0\5.2.0\mingw48_32\include\QtQuick\5.2.0\QtQuick\private\qquicktext_p.h 。你的环境中根据 Qt SDK 安装目录，路径可能有所不同。

    看看 QQuickText 类的声明吧（我截取了属性部分的几行代码）：
```
// qquicktext_p.h  
//  
class Q_QUICK_PRIVATE_EXPORT QQuickText : public QQuickImplicitSizeItem  
{  
    Q_OBJECT  
    Q_ENUMS(HAlignment)  
    Q_ENUMS(VAlignment)  
    Q_ENUMS(TextStyle)  
    Q_ENUMS(TextFormat)  
    Q_ENUMS(TextElideMode)  
    Q_ENUMS(WrapMode)  
    Q_ENUMS(LineHeightMode)  
    Q_ENUMS(FontSizeMode)  
    Q_ENUMS(RenderType)  
  
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)  
    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY fontChanged)  
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)  
    Q_PROPERTY(QColor linkColor READ linkColor WRITE setLinkColor NOTIFY linkColorChanged)  
    Q_PROPERTY(TextStyle style READ style WRITE setStyle NOTIFY styleChanged)  
    ...  
}  
```

亲爱的，看到了吗，那么多的 Q_PROPERTY 宏啊。  Q_PROPERTY 宏就是用来定义 QML 中可访问属性的，当你看到 NOTIFY 字样，它后面的字段就是与属性绑定的信号的名字。 Qt 实现了动态属性绑定，当你为 QML Text 的属性 color 赋值时，实际上会调用到 QQuickText 的 setColor() 函数，也会触发 colorChanged() 信号。

再来看看 text 和 color 对应的信号原型：
```
class Q_QUICK_PRIVATE_EXPORT QQuickText : public QQuickImplicitSizeItem  
{  
    Q_OBJECT  
    ...  
Q_SIGNALS:  
    void textChanged(const QString &text);  
    void colorChanged();     
}  
```

看到了吧， textChanged 信号有个 text 参数。我们来看看 textChanged 信号怎样在 QML 中使用。示例代码（property_signal.qml）：
```
import QtQuick 2.0  
import QtQuick.Controls 1.1  
  
Rectangle {  
    width: 320;  
    height: 240;  
    color: "gray";  
      
    Text {  
        id: hello;  
        anchors.centerIn: parent;  
        text: "Hello World!";  
        color: "blue";  
        font.pixelSize: 32;  
        onTextChanged: {  
            console.log(text);  
        }  
    }  
      
    Button {  
        anchors.top: hello.bottom;  
        anchors.topMargin: 8;  
        anchors.horizontalCenter: parent.horizontalCenter;  
        text: "Change";  
        onClicked: {  
            hello.text = "Hello Qt Quick";  
        }  
    }  
}  
```

行文至此，如何在 QML 中使用已知类型的信号，已经介绍差不多了。
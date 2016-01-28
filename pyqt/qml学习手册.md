## qt quick、qml学习手册

### 基础学习
1、qt quick简介
 Qt Quick是一个UI技术组，Qt Quick本身主要包含了QML、JavaScript、 Qt C++三种技术。其中的主角就是QML（Qt Declarative Module）也是我打算在这个系列里面描述的主要对象。QML的主要作用我理解就是将界面设计与程序逻辑解耦，通常来说前端需求的变动远超过后台逻辑，因此界面与逻辑分离不仅有利于开发人员之间的分工，也提供了更快速的迭代速度的可能性，也会大大降低程序的后期维护成本

2、qml简介
 QML是一种简单的脚本语言，语法和CSS比较接近，因此学起来相当简单。QML最早出现是在Qt4.7版本中，从4.x过度到5.x算起来一共经过了十年的时间。最新的QML相对于4.x时代的QML有了很大的改进（下面列举都是Qt Quick 2.0的特性）：
 ```
（1）基于OpenGL(ES)的场景实现，提高图形绘制的效率。
（2）QML和JavaScript主导UI的创建，后台图形绘制采用C++。高效，灵活，可扩展性强。
（3）跨平台：这里不能说是完整意义上的跨平台，这里的跨平台是指编译的跨平台“一次编写，到处编译”
 ```
 QML将界面分成一些更小的元素，这些元素可以组成一个组件，QML语言描述了UI的形状和行为，并且可以使用JavaScript修饰。总的来说QML的结构有点像HTML，其语法和CSS比较近似。

1.QML层次结构

要使用QML进行界面的布局，首先需要理解QML元素的层次结构。QML的层次结构很简单，是一个树形结构，最外层必须有一个根元素，根元素里面可以嵌套一个或多个子元素，子元素里面还可以包含子元素。

2、qml 坐标系
 QML的坐标系采用的屏幕坐标系，原点在屏幕左上角，x轴从左向右增大，y轴从商到下增大，z轴从屏幕向外增大。子元素从父元素上继承了坐标系统，它的x,y总是相对于它的父元素坐标系。这一点一定要记住，非常重要

3、初见qml
 使用qt creator创建一个 qt quick application
 创建完成后可以看到一个简单的qml文件，QML 文件的后缀是 qml ，其实就是个文本文件。
 ```
import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    visible: true

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            Qt.quit();
        }
    }
}
 ```

```
import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
/* 这是一个多行注释，和c语言的一样 */
// 当然这是一个单行注释
Window {

    id:root;        // Window元素的id，应该保证在这个qml文件中名字唯一
    visible: true;
    width: 460;     // 直接指定窗口的宽度
    height: 288;    // 直接指定窗口的高度

    Image {
        id: bg;
        width: parent.width;            // 图片的宽度依赖父窗口的宽度
        height: parent.height;          // 图片的高度依赖父窗口的高度
        source: "qrc:///images/sky.jpg" // 引用一张图片
    }

    Image {
        id: rocket;
        x: (parent.width - width) / 2;  // 图片位置水平居中
        y: 40;                          // 图片位置距离父窗口40
        source: "qrc:///images/rocket.png";
    }

    Text {
        // 没有指定id，即这是一个匿名元素
        y:rocket.y + rocket.height + 20;                    // 文本顶部距离rocket图片底部20
        anchors.horizontalCenter: parent.horizontalCenter   // 设置文字水平居中
        text: qsTr("火箭发射！");                          // 设置文本显示的文字
        color: "#ff2332";                                   // 设置文本颜色
        font.family: "楷体";                                // 设置字体为楷体
        font.pixelSize: 30;                                 // 设置文字大小
    }
}
 ```

代码说明：
（1）第1~3行的import是引入了一个指定版本的模块。一般都会引入QtQuick2.x这个模块，Window模块代表一个窗体，Control模块有很多的控制组件。这种import语法类似于C语言中的#include，和Java语言中的imort效果基本上一致。

（2）第5、6两行分别是多行注释和单行注释，和C语言中的规则是一样的。

（3）每一个QML文件都需要一个根元素，这里的根元素是Window元素，元素的形式是：元素类型 {}

（4）元素拥有属性，他们按照name:value的格式进行组织；

（5）语句后面的分号";"是可选的，但是建议加上；

（6）第7行指定了window的id，在一个qml文件这种id硬保证唯一，否则后出现的id会覆盖前面的id造成不必要的bug。建议根元素的名字直接叫“root”，方便查找和理解，当然也可以取名任何你喜欢的名字。任何QML文档中的元素都可以使用他们的id进行访问；

（7）第11行设置窗口可见，默认是false;

（8）第12、13行指定了窗口的宽高为460x288;

（9）第15行使用了一个Image元素，这个元素是用来展示图片的；

（10）第17、18行指定图片的高度和宽度为父元素（即WIndow）的宽高，因此图片的宽高会随着父元素变化，使用parent可以访问父元素

（11）19行指定了一个图片资源的路径，这里使用了“qrc://”资源，这个资源的路径在image进行配置；qml还支持直接的本地文件路径和网络路径。

（12）第24、25行指定了第二张图片的位置，在窗口水平居中，距离窗口顶部40像素；

（13）第29行创建了一个Text元素，这个元素是用来呈现文字的。

（14）第31行指定文本元素的y坐标为距离火箭图片（rock）底部20个像素；

（15）第32行使用锚点的方式设置了文字的水平居中；

（16）第33行设置了文本内容；

（17）第34行设置文字的颜色，文字的颜色可以使用RGB方式也可以使用W3C规范的SVG方式；

（18）第35、36行设置了字体和文字的大小。

###qmlscene 工具

qt提供了一个查看qml效果的工具qmlscene ，这个工具在$QTDIR/qmlscene.exe，设置好环境变量后就可以直接在cmd矿口里面使用qmlscene 查看qml文件效果。
在控制台下输入qmlscene后就会弹出一个文件选择窗口，选择需要预览的qml，当然这里我们图片设置的是qrc路径，qmlscene预览效果并不好
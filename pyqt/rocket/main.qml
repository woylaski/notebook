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

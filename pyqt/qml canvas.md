http://www.devbean.net/2015/09/qt-study-road-2-qml-canvas/
http://www.devbean.net/2015/11/qt-study-road-2-qml-canvas-2/

在 QML 刚刚被引入到 Qt 4 的那段时间，人们往往在讨论 Qt Quick 是不是需要一个椭圆组件。由此，人们又联想到，是不是还需要其它的形状？这种没玩没了的联想导致了一个最直接的结果：除了圆角矩形，Qt Quick 什么都没有提供，包括椭圆。如果你需要一个椭圆，那就找个图片，或者干脆自己用 C++ 写一个吧（反正 Qt Quick 是可以扩展的，不是么）！

为了使用脚本化的绘图机制，Qt 5 引入的Canvas元素。Canvas元素提供了一种与分辨率无关的位图绘制机制。通过Canvas，你可以使用 JavaScript 代码进行绘制。如果熟悉 HTML5 的话，Qt Quick 的Canvas元素与 HTML5 中的Canvas元素如出一辙。


Canvas元素的基本思想是，使用一个 2D 上下文对象渲染路径。这个 2D 上下文对象包含所必须的绘制函数，从而使Canvas元素看起来就像一个画板。这个对象支持画笔、填充、渐变、文本以及其它一系列路径创建函数。

下面我们看一个简单的路径绘制的例子：

```
import QtQuick 2.0

Canvas {
    id: root
    // 画板大小
    width: 200; height: 200
    // 重写绘制函数
    onPaint: {
        // 获得 2D 上下文对象
        var ctx = getContext("2d")
        // 设置画笔
        ctx.lineWidth = 4
        ctx.strokeStyle = "blue"
        // 设置填充
        ctx.fillStyle = "steelblue"
        // 开始绘制路径
        ctx.beginPath()
        // 移动到左上点作为起始点
        ctx.moveTo(50,50)
        // 上边线
        ctx.lineTo(150,50)
        // 右边线
        ctx.lineTo(150,150)
        // 底边线
        ctx.lineTo(50,150)
        // 左边线，并结束路径
        ctx.closePath()
        // 使用填充填充路径
        ctx.fill()
        // 使用画笔绘制边线
        ctx.stroke()
    }
}
```

上面的代码将在左上角为 (50, 50) 处，绘制一个长和宽均为 100 像素的矩形。这个矩形使用钢铁蓝填充，并且具有蓝色边框。程序运行结果如下所示：

让我们来仔细分析下这段代码。首先，画笔的宽度设置为 4 像素；使用strokeStyle属性，将画笔的颜色设置为蓝色。fillStyle属性则是设置填充色为 steelblue。只有当调用了stroke()或fill()函数时，真实的绘制才会执行。当然，我们也完全可以独立使用这两个函数，而不是一起。调用stroke()或fill()函数意味着将当前路径绘制出来。需要注意的是，路径是不能够被复用的，只有当前绘制状态才能够被复用。所谓“当前绘制状态”，指的是当前的画笔颜色、宽度、填充色等属性。

Canvas本身提供一个典型的二维坐标系，原点在左上角，X 轴正方向向右，Y 轴正方向向下。使用Canvas进行绘制的典型过程是：

设置画笔和填充样式
创建路径
应用画笔和填充
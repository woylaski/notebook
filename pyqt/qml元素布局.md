
### 锚点简介
除了定位器，QML 还提供了另外一种用于布局的机制。我们将这种机制成为锚点（anchor）。锚点允许我们灵活地设置两个元素的相对位置。它使两个元素之间形成一种类似于锚的关系，也就是两个元素之间形成一个固定点。锚点的行为类似于一种链接，它要比单纯地计算坐标改变更强。由于锚点描述的是相对位置，所以在使用锚点时，我们必须指定两个元素，声明其中一个元素相对于另外一个元素。锚点是Item元素的基本属性之一，因而适用于所有 QML 可视元素。

一个元素有 6 个主要的锚点的定位线，如下图所示：
![anchor](http://files.devbean.net/images/2014/02/qml-anchors.png)

这 6 个定位线分别是：top、bottom、left、right、horizontalCenter和verticalCenter。对于Text元素，还有一个baseline锚点。每一个锚点定位线都可以结合一个偏移的数值。其中，top、bottom、left和right称为外边框；horizontalCenter、verticalCenter和baseline称为偏移量。

http://www.devbean.net/2014/02/qt-study-road-2-qml-layout/
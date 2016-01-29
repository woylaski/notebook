PathView是 QtQuick 中最强大的视图，同时也是最复杂的。PathView允许创建一种更灵活的视图。在这种视图中，数据项并不是方方正正，而是可以沿着任意路径布局。沿着同一布局路径，数据项的属性可以被更详细的设置，例如缩放、透明度等。

使用PathView首先需要定义一个代理和一个路径。除此之外，PathView还可以设置很多其它属性，其中最普遍的是pathItemCount，用于设置可视数据项的数目；preferredHighlightBegin、preferredHighlightEnd和highlightRangeMode可以设置高亮的范围，也就是沿着路径上面的当前可以被显示的数据项。

在深入了解高亮范围之前，我们必须首先了解path属性。path接受一个Path元素，用于定义PathView中的代理所需要的路径。该路径使用startX和startY属性，结合PathLine、PathQuad、PathCubic等路径元素进行定义。这些元素可以结合起来形成一个二维路径。

一旦路径定义完成，我们可以使用PathPercent和PathAttribute元素进行调整。这些元素用于两个路径元素之间，更好的控制路径和路径上面的代理。PathPercent控制两个元素之间的路径部分有多大。它控制了路径上面代理的分布，这些代理按照其定义的百分比进行分布。

PathAttribute元素同PathPercent同样放置在元素之间。该元素允许沿路径插入一些属性值。这些属性值附加到代理上面，可用于任何能够使用的属性。

下面的例子演示了如何利用PathView实现卡片的弹入。这里使用了一些技巧来达到这一目的。它的路径包含三个PathLine元素。通过PathPercent元素，中间的元素可以正好位于中央位置，并且能够留有充足的空间，以避免被别的元素遮挡。元素的旋转、大小缩放和 Z 轴都是由PathAttribute进行控制。除了定义路径，我们还设置了PathView的pathItemCount属性。该属性用于指定路径所期望的元素个数。最后，代理中的PathView.onPath使用preferredHighlightBegin和preferredHighlightEnd属性控制代理的可见性。
```
    PathView {
        anchors.fill: parent

        delegate: flipCardDelegate
        model: 100

        path: Path {
            startX: root.width/2
            startY: 0

            PathAttribute { name: "itemZ"; value: 0 }
            PathAttribute { name: "itemAngle"; value: -90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathLine { x: root.width/2; y: root.height*0.4; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width/2; y: root.height*0.5; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width/2; y: root.height*0.6; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width/2; y: root.height; }
            PathAttribute { name: "itemAngle"; value: 90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathAttribute { name: "itemZ"; value: 0 }
        }

        pathItemCount: 16

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }
```
代理直接使用了通过PathAttribute元素附加的itemZ、itemAngle和itemScale属性。需要注意的是，被附加到代理的属性只能在wrapper中使用。因此，我们又定义了一个rotX属性，以便在内部的Rotation元素中使用。另一点需要注意的是附件属性PathView.onPath的使用。通常我们会将这个属性绑定到可视化属性，这样允许PathView保留非可见元素，以便进行缓存。如果不这样设置，不可见元素可能会由于界面裁剪等原因被销毁，因为PathView比ListView和GridView要灵活得多，所以为提高性能，一般会使用这种绑定实现缓存。
```
    Component {
        id: flipCardDelegate

        BlueBox {
            id: wrapper

            width: 64
            height: 64
            antialiasing: true

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#2ed5fa" }
                GradientStop { position: 1.0; color: "#2467ec" }
            }

            visible: PathView.onPath

            scale: PathView.itemScale
            z: PathView.itemZ

            property variant rotX: PathView.itemAngle
            transform: Rotation {
                axis { x: 1; y: 0; z: 0 }
                angle: wrapper.rotX;
                origin { x: 32; y: 32; }
            }
            text: index
        }
    }
```

## 从 XML 加载模型
XML 是一种非常常见的数据格式，QML 提供了XmlListModel元素支持将 XML 数据转换为模型。XmlListModel可以加载本地或远程的 XML 文档，使用 XPath 表达式处理数据。

下面的例子给出了如何从 RSS 获取图片。source属性指向了一个远程地址，其数据会被自动下载下来。

```
import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Background {
    width: 300
    height: 480

    Component {
        id: imageDelegate

        Box {
            width: listView.width
            height: 220
            color: '#333'

            Column {
                Text {
                    text: title
                    color: '#e0e0e0'
                }
                Image {
                    width: listView.width
                    height: 200
                    fillMode: Image.PreserveAspectCrop
                    source: imageSource
                }
            }
        }
    }

    XmlListModel {
        id: imageModel

        source: "http://www.padmag.cn/feed"
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "imageSource"; query: "substring-before(substring-after(description/string(), 'img src=\"'), '\"')" }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: imageModel
        delegate: imageDelegate
    }
}
```

当数据被下载下来，这个 XML 就被处理成模型的数据项和角色。query属性是 XPath 表达式语言，用于创建模型数据项。在这个例子中，该属性值为/rss/channel/item，因此，rss 标签下的每一个 channel 标签中的每一个 item 标签，都会被生成一个数据项。每一个数据项都可以定义一系列角色，这些角色使用XmlRole表示。每一个角色都有一个名字，代理可以使用附件属性访问到其值。角色的值是使用 XPath 表达式获取的。例如，title属性的值由title/string()表达式决定，返回的是<title>和</title>标签之间的文本。imageSource属性值则更有趣。它并不是直接由 XML 获取的字符串，而是一系列函数的运算结果。在返回的 XML 中，有些 item 中包含图片，使用<img src=标签表示。使用substring-after和substring-beforeXPath 函数，可以找到每张图片的地址并返回。因此，imageSource属性可以直接作为Image元素的source属性值。

## 分组列表
有时，列表中的数据可以分成几个部分，例如，按照列表数据的首字母分组。利用ListView可以将一个扁平的列表分为几个组，如下图所示：

为了使用分组，需要设置section.property和section.criteria两个属性。section.property定义了使用哪个属性进行分组。这里，需要确保模型已经排好序了，以便每一部分能够包含连续的元素，否则，同一属性的名字可能出现在多个位置。section.criteria的可选值为ViewSection.FullString或ViewSection.FirstCharacter。前者为默认值，适用于具有明显分组的模型，例如，音乐集等；后者按照属性首字母分组，并且意味着所有属性都适用于此，常见例子是电话本的通讯录名单。

一旦分组定义完毕，在每一个数据项就可以使用附加属性ListView.section、ListView.previousSection和ListView.nextSection访问到这个分组。使用这个属性，我们就可以找到一个分组的第一个和最后一个元素，从而实现某些特殊功能。

我们也可以给ListView的section.delegate属性赋值，以便自定义分组显示的代理。这会在一个组的数据项之前插入一个用于显示分组的代理。这个代理可以使用附加属性访问当前分组的名字。

下面的例子按照国别对一组人进行分组。国别被设置为section.property属性的值。section.delegate组件，也就是sectionDelegate，用于显示每组的名字，也就是国家名。每组中的人名则使用spaceManDelegate显示。

```
import QtQuick 2.0

Background {
    width: 300
    height: 290

    ListView {
        anchors.fill: parent
        anchors.margins: 20

        clip: true

        model: spaceMen

        delegate: spaceManDelegate

        section.property: "nation"
        section.delegate: sectionDelegate
    }

    Component {
        id: spaceManDelegate

        Item {
            width: ListView.view.width
            height: 20
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                font.pixelSize: 12
                text: name
                color: '#1f1f1f'
            }
        }
    }

    Component {
        id: sectionDelegate

        BlueBox {
            width: ListView.view.width
            height: 20
            text: section
            fontColor: '#e0e0e0'
        }
    }


    ListModel {
        id: spaceMen

        ListElement { name: "Abdul Ahad Mohmand"; nation: "Afganistan"; }
        ListElement { name: "Marcos Pontes"; nation: "Brazil"; }
        ListElement { name: "Alexandar Panayotov Alexandrov"; nation: "Bulgaria"; }
        ListElement { name: "Georgi Ivanov"; nation: "Bulgaria"; }
        ListElement { name: "Roberta Bondar"; nation: "Canada"; }
        ListElement { name: "Marc Garneau"; nation: "Canada"; }
        ListElement { name: "Chris Hadfield"; nation: "Canada"; }
        ListElement { name: "Guy Laliberte"; nation: "Canada"; }
        ListElement { name: "Steven MacLean"; nation: "Canada"; }
        ListElement { name: "Julie Payette"; nation: "Canada"; }
        ListElement { name: "Robert Thirsk"; nation: "Canada"; }
        ListElement { name: "Bjarni Tryggvason"; nation: "Canada"; }
        ListElement { name: "Dafydd Williams"; nation: "Canada"; }
    }
}
```

##关于性能
模型视图的性能很大程度上取决于创建新的代理所造成的消耗。例如，如果clip属性设置为false，当向下滚动ListView时，系统会在列表末尾创建新的代理，并且将列表上部已经不可显示的代理移除。显然，当初始化代理需要消耗大量时间时，用户在快速拖动滚动条时，这种现象就会造成一定程度的影响。

为了避免这种情况，你可以调整被滚动视图的外边框的值。通过修改cacheBuffer属性即可达到这一目的。在上面所述的有关竖直滚动的例子中，这个属性会影响到列表上方和下方会有多少像素。这些像素则影响到是否能够容纳这些代理。例如，将异步加载图片与此结合，就可以实现在图片真正加载完毕之后才显示出来。

更多的代理意味着更多的内存消耗，从而影响到用户的操作流畅度，同时也有关代理初始化的时间。对于复杂的代理，上面的方法并不能从根本上解决问题。代理初始化一次，其内容就会被重新计算。这会消耗时间，如果这个时间很长，很显然，这会降低用户体验。代理中子元素的个数同样也有影响。原因很简单，移动更多的元素当然要更多的时间。为了解决前面所说的两个问题，我们推荐使用Loader元素。Loader元素允许延时加载额外的元素。例如，一个可展开的代理，只有当用户点击时，才会显示这一项的详细信息，包含一个很大的图片。那么，利用Loader元素，我们可以做到，只有其被显示时才进行加载，否则不加载。基于同样的原因，应该使每个代理中包含的 JavaScript 代码尽可能少。最好能做到在代理之外调用复杂的 JavaScript 代码。这将减少代理创建时编译 JavaScript 所消耗的时间。
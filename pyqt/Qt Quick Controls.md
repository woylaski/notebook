自 QML 第一次发布已经过去一年多的时间，但在企业应用领域，QML 一直没有能够占据一定地位。很大一部分原因是，QML 缺少一些在企业应用中亟需的组件，比如按钮、菜单等。虽然移动领域，这些组件已经变得可有可无，但在桌面系统中依然不可或缺。为了解决这一问题，Qt 5.1 发布了 Qt Quick 的一个全新模块：Qt Quick Controls。顾名思义，这个模块提供了大量类似 Qt Widgets 模块那样可重用的组件。本章我们将介绍 Qt Quick Controls，你会发现这个模块与 Qt 组件非常类似。

为了开发基于 Qt Quick Controls 的程序，我们需要创建一个 Qt Quick Application 类型的应用程序，选择组件集的时候注意选择 Qt Quick Controls 即可：

注意，Qt Creator 给出的是 Qt Quick Controls 1.0，而最新版本的 Qt 5.2 搭载的 Qt Quick Controls 是 1.1。1.1 比 1.0 新增加了一些组件，比如BusyIndicator等。所以，如果你发现某个组件找不到，记得更新下 Qt Quick Controls 的版本。

Qt Quick Controls 1.1 提供了多种组件：
```
应用程序窗口
用于描述应用程序的基本窗口属性的组件
ApplicationWindow	对应QMainWindow，提供顶层应用程序窗口
MenuBar	对应QMenuBar，提供窗口顶部横向的菜单栏
StatusBar	对应QStatusBar，提供状态栏
ToolBar	对应QToolBar，提供工具栏，可以添加ToolButton和其它组件
Action	对应QAction，提供能够绑定到导航和视图的抽象的用户界面动作  

导航和视图
方便用户在一个布局中管理和显示其它组件
ScrollView	对应QScrollView，提供滚动视图
SplitView	对应QSplitter，提供可拖动的分割视图布局
StackView	对应QStackedWidget，提供基于栈的层叠布局
TabView	对应QTabWidget，提供带有标签的基于栈的层叠布局
TableView	对应QTableWidget，提供带有滚动条、样式和表头的表格
控件

控件用于表现或接受用户输入
BusyIndicator	提供忙等示意组件
Button	对应QPushButton，提供按钮组件
CheckBox	对应QCheckBox，提供复选框
ComboBox	对应QComboBox，提供下拉框
GroupBox	对应QGroupBox，提供带有标题、边框的容器
Label	对应QLabel，提供标签组件
ProgressBar	对应QProgressBar，提供进度条组件
RadioButton	对应QRadioButton，提供单选按钮
Slider	对应QSlider，提供滑动组件
SpinBox	对应QSpinBox，提供微调组件
Switch	提供类似单选按钮的开关组件
TextArea	对应QTextEdit，提供能够显示多行文本的富文本编辑框
TextField	对应QTextLine，提供显示单行文本的纯文本编辑框
ToolButton	对应QToolButton，提供在工具栏上显示的工具按钮
ExclusiveGroup	提供互斥

菜单
用于构建菜单的组件
Menu	对应QMenu，提供菜单、子菜单、弹出菜单等
MenuSeparator	提供菜单分隔符
MenuItem	提供添加到菜单栏或菜单的菜单项
StatusBar	对应QStatusBar，提供状态栏
ToolBar	对应QToolBar，提供工具栏，可以添加ToolButton和其它组件
```

我们尝试实现一个编辑器。这是一个简单的文本编辑器，具有新建、剪切、复制和粘贴等操作。程序运行出来效果如下：

![editor](http://files.devbean.net/images/2014/05/simpleeditor.png)

### 添加import
>import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

### 设置根元素为ApplicationWindow
注意我们修改了 IDE 生成的默认语句。整个 QML 文档的根元素是ApplicationWindow：
```
ApplicationWindow {
    id: root;
    title: qsTr("Simple Editor");
    width: 640;
    height: 480;
    visible: true;

}
```
ApplicationWindow是应用程序的主窗口，类似QMainWindow，提供了很多预定义的功能，比如菜单、工具栏等。代码里面的qsTr()函数类似tr()函数，用于以后的国际化。所有面向用户的文本都应该使用这个函数。

###下面向ApplicationWindow中添加控件
```
menuBar: MenuBar {
    Menu {
        title: qsTr("&File")
        MenuItem { action: newAction }
        MenuItem { action: exitAction }
    }
    Menu {
        title: qsTr("&Edit")
        MenuItem { action: cutAction }
        MenuItem { action: copyAction }
        MenuItem { action: pasteAction }
        MenuSeparator {}
        MenuItem { action: selectAllAction }
    }
}

toolBar: ToolBar {
    Row {
        anchors.fill: parent
        ToolButton { action: newAction }
        ToolButton { action: cutAction }
        ToolButton { action: copyAction }
        ToolButton { action: pasteAction }
    }
}

TextArea {
    id: textArea
    anchors.fill: parent
}
```

首先看最后面的TextArea，这是整个窗口的主要控件，类似于setCentralWidget()函数调用。

menuBar和toolBar两个属性都是ApplicationWindow提供的属性。

menuBar是MenuBar类型的，所以我们创建一个新的MenuBar控件。MenuBar具有层次结构，这是通过Menu的嵌套实现的。每一个菜单项都是用MenuItem实现的；菜单项之间的分隔符则使用MenuSeparator控件。这点与 QtWidgets 有所不同。

toolBar是Item类型的，不过通常都会使用ToolBar控件。ToolBar默认没有提供布局，因此我们必须给它设置一个布局。这里我们直接添加了一个Row，作为横向工具栏的布局。这个工具栏要横向充满父窗口，因此设置锚点为anchors.fill: parent。虽然我们设置的是充满整个父窗口，但是工具栏的行为是，如果其中只有一个子元素（比如这里的Row），那么工具栏的高度将被设置为这个子元素的implicitHeight属性。这对结合布局使用非常有用。事实上，这也是工具栏最常用的方法。工具栏中添加了四个按钮，都是ToolButton类型。

**每一个MenuItem和ToolButton都添加了一个action属性。下面是这部分代码**
```
Action {
    id: exitAction
    text: qsTr("E&xit")
    onTriggered: Qt.quit()
}
Action {
    id: newAction
    text: qsTr("New")
    iconSource: "images/new.png"
    onTriggered: {
        textArea.text = "";
    }
}
Action {
    id: cutAction
    text: qsTr("Cut")
    iconSource: "images/cut.png"
    onTriggered: textArea.cut()
}
Action {
    id: copyAction
    text: qsTr("Copy")
    iconSource: "images/copy.png"
    onTriggered: textArea.copy()
}
Action {
    id: pasteAction
    text: qsTr("Paste")
    iconSource: "images/paste.png"
    onTriggered: textArea.paste()
}
Action {
    id: selectAllAction
    text: qsTr("Select All")
    onTriggered: textArea.selectAll()
}
```

Action类似QAction。这里我们还是使用qsTr()函数设置其显示的文本。

使用iconSource属性可以指定图标。注意这里的图标只能是位于文件系统中的，不能加载资源文件中的图标（当然，这并不是绝对的。如果我们将整个 QML 文档放在资源文件中，那么就可以直接加载资源文件中的图标。我们会在后面的章节详细介绍这种技术。）。当我们直接类似“images/new.png”这种路径时，注意 QML 是运行时解释的，因此这个路径是相对与 QML 文件的路径。所以这里的图标需要放在与 main.qml 文件同目录下的 images 目录中。

onTriggered属性是一种信号处理函数，后面可以添加 JavaScript 语句。如果是多条语句，可以使用大括号，例如newAction的onTriggered。QML 组件可以发出信号。与 C++ 不同的是，QML 组件的信号并不需要特别的连接语句，而是使用”on信号名字”的形式。比如，Action有一个名为triggered的信号，则其信号处理函数即为onTriggered。事实上，这是最简单的一种信号槽的实现。不过，这种实现的困难在于，同一个信号只能有一个固定名字的信号处理函数。不过，我们也可以使用 connect 连接语句。后面的章节中将详细介绍这一点。

至此，我们的编辑器便实现了。由于全部使用了TextArea提供的功能，所以代码很简单。不过，复杂的程序都是这些简单的元素堆积而成，所以，我们现在只是简单介绍，具体的控件使用还要根据文档仔细研究。
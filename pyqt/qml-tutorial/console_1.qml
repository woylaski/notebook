在调试应用程序时，输出一些log是常用的一种方法。QML提供了log输出的多个api，常用的是console.log()，直接输出参数内容。
console.log()：
与console.log()类似的还有console.debug()/info()/warn()/error()，用法如下
    function console_log() {
        console.log("this is console.log()")
        console.debug("this is console.debug()")
        console.info("this is console.info()")
        console.warn("this is console.warn()")
        console.error("this is console.error()")
    }

console.assert()：
与C++的Assert类似，成功时无声无息而过，失败时会输出assert内容和相关的文件路径、行号、函数名称等信息，用法如下：
    function console_assert() {
        console.assert(1 == 1, "assert 1 == 1") // success
        console.assert(1 == 2, "assert 1 == 2") // failure
        console.assert(1 < 2, "assert 1 < 2") // success
        console.log("assert ends")
    }

console.time()：
console.time()与console.timeEnd()一起使用，输出这两个函数之间的程序执行的时间，单位是毫秒，函数的参数比较特殊（要前后对应），用法如下：
    function console_time() {
        console.time("wholeFunction") // 函数参数wholeFunction
        console.time("firstPart") // 函数参数firstPart
        for (index = 0; index < 10000; index++) { // do something
        }
        console.timeEnd("firstPart") // 函数参数firstPart
        console.time("secondPart") // 函数参数secondPart
        for (index = 0; index < 10000; index++) { // do something
        }
        console.timeEnd("secondPart") // 函数参数secondPart
        for (index = 0; index < 10000; index++) { // do something
        }
        console.timeEnd("wholeFunction") // 函数参数wholeFunction
    }

console.trace()：
输出代码执行的行号、函数名称、文件路径等堆栈信息，最多10条，例如main.qml代码如下：
import QtQuick 2.2

Item {
    width: 360
    height: 360

    function console_trace() {
        console.trace() // 调用console.trace()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: console_trace()
    }
}
点击鼠标时，输出如下log：
console_trace (qrc:///main.qml:8)
onClicked (qrc:///main.qml:13)

console.count()：
输出某个代码块执行的次数，例如main.qml代码如下：
import QtQuick 2.2

Item {
    width: 360
    height: 360

    function console_count() {
        console.count("console_count() called") // 调用console.count()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console_count()
            console_count()
        }
    }
}
点击鼠标时，输出如下log：
console_count() called: 1
console_count() called: 2

console.profile()：
QML和JavaScript代码性能分析，console.profile()与console.profileEnd()一起使用，用法如下：
function f() {
    console.profile()
    // Call some function that needs to be profiled.
    // Ensure that a client is attached before ending the profiling session.
    console.profileEnd()
}
另，通过QtCreator中的“Analyze->QML Profiler”可以进行QML性能分析。

console.exception()：
输出异常信息，包括行号、函数名称、文件路径等，用法如下：
    function console_exception() {
        console.exception("this is an exception")
    }
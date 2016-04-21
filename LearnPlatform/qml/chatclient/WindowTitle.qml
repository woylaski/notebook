import QtQuick 2.0

Rectangle {
    anchors {left: parent.left; top: parent.top; right: parent.right}
    height: 25;

    signal closeWindow
    signal miniWindow
    signal setWindow

    onCloseWindow:  close()
    onMiniWindow: root.showMinimized()

    color: Qt.rgba(0, 0, 0, 0.5)

    //Logo
    Image {
        source: "/Img/Images/logo.png"
        width: 20
        height: 20
        anchors {left: parent.left; top: parent.top; leftMargin: 5; topMargin: 2}
    }

    WindowFramTool {
        id: id_closeWindow
        toolName: "closeWindow"
        anchors {top: parent.top; right: parent.right; margins: 5}
        onButtonClicked: closeWindow();
    }

    WindowFramTool {
        id: id_miniWindow
        toolName: "miniWindow"
        anchors {top: parent.top; right: id_closeWindow.left; margins: 5}
        onButtonClicked: miniWindow()
    }

    WindowFramTool {
        id: id_setWindow
        toolName: "setWindow"
        anchors {top: parent.top; right: id_miniWindow.left; margins: 5}
        onButtonClicked: setWindow()
    }
}

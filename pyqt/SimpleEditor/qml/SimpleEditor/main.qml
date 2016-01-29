import QtQuick 2.1
import QtQuick.Controls 1.1

ApplicationWindow {
    title: qsTr("Simple Editor")
    width: 640
    height: 480

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
}

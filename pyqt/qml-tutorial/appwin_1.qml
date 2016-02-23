import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root;
    title: qsTr("Simple Editor");
    width: 640;
    height: 480;
    visible: true;

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem { action: newAction }
            MenuItem { action: exitAction }
        }

        Menu {
            title: qsTr("&Edit")
            MenuItem { text: "cut" }
            MenuItem { text: "copy" }
            MenuItem { text: "paste" }
            MenuSeparator {}
            MenuItem { text: "select" }
        }
    }

    toolBar: ToolBar {
        Row {
            anchors.fill: parent
            ToolButton { text: "new" }
            ToolButton { text: "cut" }
            ToolButton { text: "copy" }
            ToolButton { text: "paste" }
        }
    }

    TextArea {
        id: textArea
        anchors.fill: parent
    }

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
}


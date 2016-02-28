import QtQuick 1.1

Rectangle {
    width: 400
    height: 400
    ToolBar {
        anchors.bottom: parent.bottom
        ToolItem_Text { label: "back"; onClicked: console.log(label) }
        ToolItem_Image { source: "QML64.png"; mode: Image.PreserveAspectFit; onClicked: console.log("qml64") }
    }
}

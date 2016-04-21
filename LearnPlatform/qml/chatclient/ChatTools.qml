import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: root

    property string fontFamily: id_fontFamily.currentText
    property int fontSize: id_fontSize.currentIndex + 7
    property bool textBold: id_textBold.checked
    property bool textItalic: id_textItalic.checked
    property bool textUnderline: id_textUnderline.checked
    property string textColor: id_colorDialog.color
    property int toolsHeight: id_fontFamily.height

    color: Qt.rgba(0, 0, 0, 0.7)
    height: id_fontFamily.height + 8

    Row {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter

        //字体
        ComboBox {
            id: id_fontFamily
            currentIndex: 1
            model: ListModel{
                ListElement { text: "宋体" }
                ListElement { text: "楷体" }
                ListElement { text: "黑体" }
            }
        }

        //字号
        ComboBox {
            id: id_fontSize
            width: 47
            anchors { margins: 2 }
            currentIndex: 7
            model: ListModel{
                ListElement { text: "7" }
                ListElement { text: "8" }
                ListElement { text: "9" }
                ListElement { text: "10" }
                ListElement { text: "11" }
                ListElement { text: "12" }
                ListElement { text: "13" }
                ListElement { text: "14" }
                ListElement { text: "15" }
                ListElement { text: "16" }
                ListElement { text: "17" }
                ListElement { text: "18" }
            }
        }

        //加租
        ToolButton {
            id: id_textBold
            anchors { margins: 2 }
            height: toolsHeight
            width: height
            checkable: true
            Text{
                anchors.centerIn: parent
                text: qsTr("B")
                color: "white"
                font {bold: true; pointSize: 10}
            }          
        }

        //斜体
        ToolButton {
            id: id_textItalic
            anchors { margins: 2 }
            height: toolsHeight
            width: height
            checkable: true
            Text{
                anchors.centerIn: parent

                text: qsTr("I")
                 color: "white"
                font {italic: true; bold: true; pointSize: 10}
            }
        }

        //下划线
        ToolButton {
            id: id_textUnderline
            anchors { margins: 2 }
            height: toolsHeight
            width: height
            checkable: true
            Text{
                anchors.centerIn: parent
                text: qsTr("U")
                 color: "white"
                font {bold: true; pointSize: 10; underline: true}
            }
        }

        //颜色
        ToolButton {
            id: id_textColor
            anchors { margins: 2 }
            height: toolsHeight
            width: height
            Image {
                anchors.centerIn: parent
                source: "Img/Images/colorDialog.png"
            }
            onClicked: {
                id_colorDialog.open()
            }
            ColorDialog {
                id: id_colorDialog
//                color: "#000040"
                color: "#00ff00"
            }
        }

        //文件
        Button {
            anchors { margins: 2 }
            id: id_openFile
            height: toolsHeight
            width: 60
            Text {
                anchors.centerIn: parent
                text: qsTr("浏览...")
            }
            onClicked: {
                fileDialog.open()
            }
            FileDialog {
                id: fileDialog
            }
        }


    }
}

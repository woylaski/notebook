import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

//about窗口
Window {
    //Item {
    width:800
    height:480
    modality: Qt.WindowModal
    flags: Qt.FramelessWindowHint
    id: aboutRoot

    //anchors.centerIn: parent
    Action {
        id: windowClose
        onTriggered: {
            aboutRoot.close()
        }
    }

    //about窗口背景
    Image {
        id: bg
        source: "about_images/bg.png"
        x: 0
        y: 0
        opacity: 1
    }

    //about文本
    Text {
        id: product_name
        font.pixelSize: 18
        font.family: "Ubuntu"
        color: "#ffffff"
        smooth: true
        //anchors.centerIn: parent
        x: 380
        y: 226.5
        opacity: 1
    }

    //公司介绍
    Rectangle {
        id: linkRect
        x: 344
        y: 363.5
        width: 110
        height: 20
        color: "#222021"
        Text {
            id: linkText
            text: "<a href=\"http://e-consystems.com/\">e-consystems</a>"
            font.pixelSize: 18
            font.family: "Ubuntu"
            color: "#ffffff"
            smooth: true
            opacity: 1
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor)
            onClicked: Qt.openUrlExternally("http://e-consystems.com")
        }
    }

    //version
    Text {
        id: version
        text: "version 1.0"
        font.pixelSize: 18
        font.family: "Ubuntu"
        color: "#ffffff"
        smooth: true
        x: 382
        y: 256.5
        opacity: 1
    }

    //copyright
    Text {
        id: copyrights
        text: "Copyright © 2015  e-con Systems India Pvt. Limited"
        font.pixelSize: 15
        font.family: "Ubuntu Light"
        color: "#ffffff"
        smooth: true
        x: 238
        y: 399.25
        opacity: 1
    }

    //关闭按钮
    Button {
        id: close_selected
        x: 670
        y: 418
        opacity: 1
        focus: true
        action: windowClose
        style: ButtonStyle {
            background: Rectangle {
                border.width: control.activeFocus ? 3 :0
                color: "#222021"
                border.color: control.activeFocus ? "#ffffff" : "#222021"
                radius: 5
            }
            label: Image {
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                fillMode: Image.PreserveAspectFit
                source: "about_images/close_selected.png"
            }
        }
        Keys.onReturnPressed: {
            aboutRoot.close()
        }
    }

    //滚动条
    ScrollView {
        id: scrollId
        x: 94
        y: 290
        width: parent.width - 100
        height: 70
        style: ScrollViewStyle {
            scrollToClickedPosition: true
            handle: Image {
                id: scrollhandle
                source: "images/scroller.png"
            }
            scrollBarBackground: Image {
                id: scrollStyle
                source: "images/Scroller_bg.png"
            }
            incrementControl: Image {
                id: increment
                source: "images/down_arrow.png"
            }
            decrementControl: Image {
                id: decrement
                source: "images/up_arrow.png"
            }
        }

        Text {
            id: content
            font.pixelSize: 15
            font.family: "Ubuntu Light"
            color: "#ffffff"
            smooth: true
            opacity: 1
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }

    Image {
        id: logo
        fillMode: Image.PreserveAspectFit
        source: "about_images/logo.png"
        x: -50
        y: -180
        opacity: 1
    }

    Component.onCompleted:  {
        product_name.text = "网络安全开发平台"
        version.text = "1.0"
        content.text = "风山科技 2015-2016"
    }
}
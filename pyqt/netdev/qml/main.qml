import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle {
	id: root;
	//title: qsTr("网络安全开发平台");
    width:Screen.width/2;
    height:Screen.height/2;
    visible: true;
    focus: true;
    //color:  "white";
    radius: 8

    //自定义变量
    property string statusText:"hello world-" + Screen.width/2 + "-" + Screen.height/2;

    Action {
        id: aboutAction
        onTriggered: {
            aboutWindow.show();
        }
    }

    Action {
        id: exitAction
        onTriggered: {
            exitDialog.visible = true
        }
    }

    Image {
        id: layer_0
        source: "images/layer_0.png"
        x: sideBarItems.visible ? 268 : 0
        y: 0
        //x:0 ; y:0;
        opacity: 1
        //width: parent.width
        //height: parent.height
        width: sideBarItems.visible ? parent.width - 268 : parent.width
        height: parent.height - statusbar.height
        visible: true;
    }

/*
    ScrollView {
        id: previewer
        anchors.centerIn: layer_0
        width: vidstreamproperty.width < (sideBarItems.visible ? parent.width - 268 : parent.width) ? vidstreamproperty.width + 20 : sideBarItems.visible ? parent.width - 268 : parent.width
        height: vidstreamproperty.height < layer_0.height ? (vidstreamproperty.height) : (parent.height - statusbar.height)
        style: ScrollViewStyle {
            scrollToClickedPosition: true
            scrollBarBackground: Image {
                source: styleData.horizontal? "images/Horizontal_Scroll_base.png" : "images/Vertical_Scroll_base.png"
            }
            incrementControl: Image {
                source: styleData.horizontal? "images/Horizontal_right_arrow.png" : "images/Vertical_down_arrow.png"
            }
            decrementControl: Image {
                source: styleData.horizontal? "images/Horizontal_left_arrow.png" : "images/Vertical_top_arrow.png"
            }
        }
    }
*/
    Image {
        id: open_sideBar
        visible: true
        source: "images/open_tab.png"
        anchors.bottom: layer_0.bottom
        anchors.bottomMargin: 50
        anchors.left: layer_0.left
        y: layer_0.height/2 + 20
        opacity: 1
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                open_sideBar.opacity = 1
            }
            onExited: {
                open_sideBar.opacity = 1
            }

            onReleased: {
                sideBarItems.visible = true
                open_sideBar.visible = false
            }
        }
    }

    Item {
        id: sideBarItems
        Image {
            id: side_bar_bg
            source: "images/side_bar_bg.png"
            x: -3
            y: -3
            height: root.height+5
            opacity: 1
        }

        Image {
            id: selection_bg
            source: "images/selection_bg.png"
            visible: false
            y: 197
            opacity: 1
        }

        Image {
            id: toggle_border
            source: "images/toggle_border.png"
            x: 5
            y: 153
            opacity: 1
        }

        Image {
            id: camera_box
            source: "images/camera_box.png"
            x: 18
            y: 18
            opacity: 1
        }

        Button {
            id: about
            x: 20
            y: statusbar.y - 30
            opacity: 1
            action: aboutAction
            activeFocusOnPress : true
            style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 1 :0
                    color: "#222021"
                    border.color: control.activeFocus ? "#ffffff" : "#222021"
                }
                label: Image {
                    source: "images/about.png"
                }
            }
            Keys.onReturnPressed:  {
                aboutWindow.show();
            }
        }

        Button {
            id: exit
            x: 192
            y: statusbar.y - 30
            opacity: 1
            action: exitAction
            activeFocusOnPress : true
            style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 1 :0
                    color: "#222021"
                    border.color: control.activeFocus ? "#ffffff" : "#222021"
                }
                label: Image {
                    source: "images/exit.png"
                }
            }
            Keys.onReturnPressed: {
                exitDialog.visible = true
            }
        }

    }

    StatusBar {
        id: statusbar
        anchors.bottom: parent.bottom
        Row {
            Label {
                id: statusbartext
                color: "#ffffff"
                text: statusText;
            }
        }
        style: StatusBarStyle {
            background: Rectangle {
                implicitHeight: 16
                implicitWidth: 200
                color: "#222021"
                border.width: 1
            }
        }
    }

    Keys.onRightPressed: {
        sideBarItems.visible = true
        open_sideBar.visible = false
   }
}
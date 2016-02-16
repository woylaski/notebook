import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle{
	id: root;

	//x: 0; y:0;
    width:Screen.width/2;
    height:Screen.height/2;
    radius: 10;

    color: "paleturquoise";
    border.color: "lightsteelblue"
    border.width: 4
    //接收键盘事件
    focus: true;
    visible: true;

    //自定义变量
    property string statusText : "Status Bar";

    //背景图片
    Image {
        id: layer_0
        source: "images/layer_0.png"
        x: sideBarItems.visible ? 268 : 0
        y: 0
        opacity: 1
        width: sideBarItems.visible ? parent.width - 268 : parent.width
        height: parent.height - statusbar.height
        visible: true;
    }

    //左边栏
    Item {
        id: sideBarItems

        //左边栏背景
        Image {
            id: side_bar_bg
            source: "images/side_bar_bg.png"
            x: -3
            y: -3
            height: root.height+5
            opacity: 1
        }
    }

    //StatusBar at bottom with XX heigth
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

    //键盘事件
    /*
    Keys.onLeftPressed: {
    	statusbartext.color="red";
    }
    */

    Keys.onRightPressed: {
    	statusbartext.color="blue";
    }

    Keys.onUpPressed: {
    	statusbartext.color="yellow";
    }

    Keys.onDownPressed: {
    	statusbartext.color="black";
    }

    Keys.onEscapePressed: {
    	console.log("quit now?")
    	Qt.quit(); 
    }

    Keys.onPressed: {
    	switch(event.key){
    		case Qt.Key_Plus:
    			console.log("key plus")
    			break;
    		case Qt.Key_Minus:
    			console.log("key minus")
    			break;

            case Qt.Key_Left:
                console.log("key left")
                break;

            case Qt.Key_a:
                console.log("key a")
                break;

            case Qt.Key_0:
                console.log("key a")
                break;

    		default:
    			return;
    	}

    	event.accepted = true
    }

    KeyNavigation.tab: statusbartext

    //鼠标事件
    MouseArea {
        anchors.fill: parent;  
        acceptedButtons: Qt.LeftButton | Qt.RightButton;  
        onClicked: {  
            if(mouse.button == Qt.RightButton){
            	console.log("RightButton")
                Qt.quit();  
            }  
            else if(mouse.button == Qt.LeftButton){
                color = Qt.rgba((mouse.x % 255) / 255.0 , (mouse.y % 255) / 255.0, 0.6, 1.0);
                console.log("LeftButton-"+sideBarItems.width+"-"+side_bar_bg.width)
            }
        }  
        onDoubleClicked: {  
            color = "gray";  
        }  
    }  
}
import QtQuick 2.5
import QtQuick.Window 2.2

/*********************************************************************
* \brief: a simple hide-able catalog bar
* \author: shawhen
* \date: 2013-05-18
* \version: 0.0.1 alpha
*********************************************************************/

Rectangle{
	id: root
	width: 640;
	height: 480;
	visible: true
	color: "white"
	border.width: 0;
	radius: 4

	Rectangle{
		id: slidebar
		height: parent.height
		width:160
		color: "green"
		border.width: 0;

		//anchors.left: parent.left
		anchors { top: parent.top; bottom:parent.bottom; left:parent.left; }

		//hide slide bar label
		Text{
			id: hide_label
 			font.family: "Helvetica"
    		font.pointSize: 24
    		color: "yellow"
    		text: "<"

			//anchors.centerIn: parent
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter

	        MouseArea {
	            anchors.fill: parent;
	            onClicked: {
	            	console.log("hide slidebar clicked")

	                if(slidebar.state == '') {
	                    slidebar.state = "minSize"
	                } else {
	                    slidebar.state = ''
	                }
	            }
	        }
		}
		
		//slidebar element
	    ListModel {
	        id: featureButtonsModel
	        ListElement {
	            name: "图片"
	        }
	        ListElement {
	            name: "视频"
	        }
	        ListElement {
	            name: "音乐"
	        }
	    }

	    ListView
	    {
	        id:featureButtons
	        spacing: 2;
	        anchors { top:parent.top; /*right:parent.right;*/ bottom:parent.bottom; right:hide_label.left; }
	        width: parent.width - hide_label.width;
	        clip: true
	        model: featureButtonsModel
	        delegate:featureButtonsDelegate
	    }

	    Component {
	        id:featureButtonsDelegate
	        Rectangle
	        {
	            id:wrapper;
	            width: wrapper.ListView.view.width;
	            height: Math.max(wrapper.ListView.view.height/wrapper.ListView.view.model.count,40);
	            color: "lightblue";
	            border.width: 0;
	            Text {
	                anchors.centerIn: parent;
	                text: model.name;
	            }
	        }
	    }

	    states: [
	        State {
	            name: "minSize"
	            PropertyChanges {
	                target: hide_label
	                text: ">"
	            }
	            
	            PropertyChanges {
	                target: slidebar
	                width: 10;
	            }
	        }
	    ]
	    
	    transitions: [
	        Transition {
	            NumberAnimation { target: slidebar; property: "width"; duration: 200; easing.type: Easing.InOutQuad }
	        }
	    ]
	}
}
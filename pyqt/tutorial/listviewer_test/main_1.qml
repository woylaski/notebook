import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle {
	width: 640
	height: 480

	ListModel {
	    id: petlist
	    ListElement { type: "Cat" }
	    ListElement { type: "Dog" }
	    ListElement { type: "Mouse" }
	    ListElement { type: "Rabbit" }
	    ListElement { type: "Horse" }
	}

	ListView {
	    id: view
	    anchors.fill: parent

	    model: petlist
	    delegate: petdelegate
	}

	Component {
	    id: petdelegate
	    Text {
	        id: label
	        font.pixelSize: 24
	        text: {
	        	if (index == 0)
	            	text: type + " (default)"
	         	else
	            text: type + "-" + index
	        }
	    }
	}
}


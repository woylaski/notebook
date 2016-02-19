import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

 ListView {
    anchors.fill: parent
    clip: true
    model: nameModel

    delegate: nameDelegate
    header: bannercomponent
    footer: Rectangle {
         width: parent.width; height: 30;
         gradient: clubcolors
    }
    
    highlight: Rectangle {
         width: parent.width
         color: "lightgray"
    }

    ListModel {
	     id: nameModel
	     ListElement { name: "Alice" }
	     ListElement { name: "Bob" }
	     ListElement { name: "Jane" }
	     ListElement { name: "Harry" }
	     ListElement { name: "Wendy" }
 	}

	Component {
	     id: nameDelegate
	     Text {
	         text: name;
	         font.pixelSize: 24
	     }
	 }

	Component {     //instantiated when header is processed
	    id: bannercomponent
	    
	    Rectangle {
	         id: banner
	         width: parent.width; height: 50
	         gradient: clubcolors
	         border {color: "#9EDDF2"; width: 2}
	         Text {
	             anchors.centerIn: parent
	             text: "Club Members"
	             font.pixelSize: 32
	         }
	    }
	}

	Gradient {
	    id: clubcolors
	    GradientStop { position: 0.0; color: "#8EE2FE"}
	    GradientStop { position: 0.66; color: "#7ED2EE"}
	}
 }
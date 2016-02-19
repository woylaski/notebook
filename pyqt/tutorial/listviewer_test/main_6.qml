import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

 Rectangle {
     width: 200; height: 250

     Text {
         id: myText
         text: "Hello"
         color: "#dd44ee"
     }

     Component {
         id: myDelegate
         Text { text: model.color }
     }

     ListView {
         anchors.fill: parent
         anchors.topMargin: 30
         model: myText
         delegate: myDelegate
     }
 }
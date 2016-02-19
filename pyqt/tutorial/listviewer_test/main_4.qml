import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Item {
     width: 200; height: 250

     ListModel {
         id: myModel
         ListElement { type: "Dog"; age: 8 }
         ListElement { type: "Cat"; age: 5 }
     }

     Component {
         id: myDelegate
         Text { text: type + ", " + age }
     }

     ListView {
         anchors.fill: parent
         model: myModel
         delegate: myDelegate
     }
 }
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Item {
     width: 200; height: 250

    ListModel {
         id: fruitModel

         ListElement {
             name: "Apple"
             cost: 2.45
         }
         ListElement {
             name: "Orange"
             cost: 3.25
         }
         ListElement {
             name: "Banana"
             cost: 1.95
         }
    }

     Component {
         id: myDelegate
         Text { text: type + ", " + age }
     }

     ListView {
         anchors.fill: parent
         model: fruitModel
         //delegate: myDelegate
         delegate: Row {
             Text { text: "Fruit: " + name + ","}
             Text { text: "Cost: $" + cost }
         }

         MouseArea {
             anchors.fill: parent
             onClicked: fruitModel.append({"cost": 5.95, "name":"Pizza"})
         }
     }
 }
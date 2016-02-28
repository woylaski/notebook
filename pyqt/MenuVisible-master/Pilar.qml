import QtQuick 2.5
import QtQuick.Controls 1.4


Rectangle {
   id: myItem
   signal message(string msg)
   color: "yellow"
   anchors.fill: parent

   MouseArea {
       anchors.fill: parent
       onClicked: myItem.message("clicked!")
   }

   Label {
       anchors.centerIn: parent
       text: "Centre"
   }


}

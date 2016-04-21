import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Rectangle {
     id: overlay
     property alias highlight: overlay.color
     focus: true
     x: 150; y: 250
//     anchors.centerIn: parent
     width: (parent.width<parent.height?parent.width:parent.height)/4
     height: width
     color: "#81DAF5"
     border.color: "#1A5794"
     border.width: 1
     radius: width*0.5
}

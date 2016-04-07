import QtQuick 1.0

Rectangle {
     id: page
     width: 480; height: 272
     color: "darkcyan"
     Text {
         id: helloText
         text: "Hello world!"
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignHCenter
         anchors.fill: parent
         font.pointSize: 24; font.bold: true
     }
 }

import QtQuick 2.4

Rectangle {
     id: circle
     property alias digit: number.text
     property bool isPressed: false
     width: parent.width/4
     height: width
     radius: width/2
     color: "white"
     border.color: "#0E4A6F"
     border.width: 3

     Text {
          id: number
          font.pixelSize: 72
          font.weight: Font.Light
          anchors.centerIn: parent
          color: "black"
     }

     MouseArea {
          id: mouseArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
              digits.currDigits += digit
              background.format()
          }
          onEntered: {
              circle.forceActiveFocus()
          }
     }

     Keys.onReturnPressed: {
         digits.currDigits += digit
         background.format()
         isPressed: true
         circle.state = "confirm"
     }

     Keys.onReleased: {
          isPressed: false
          if (event.key == Qt.Key_Return) {
              circle.state = "selected"
          }
     }

     states: [
          State {
              name: "confirm"
              when: isPressed == true || mouseArea.pressed
              PropertyChanges { target: circle; color: "#0E4A6F"}
              PropertyChanges { target: number; color: "white"}
          },
          State {
              name: "selected"
              when: circle.activeFocus
              PropertyChanges { target: circle; border.width: 9 }
          }

     ]

     transitions: [
         Transition {
             from: "selected"; to: "confirm"
             ColorAnimation {
                 target: circle
                 properties: "color"
                 duration: 50
             }
             ColorAnimation {
                 target: number
                 properties: "color"
                 duration: 50
             }
         },
         Transition {
             from: "confirm"; to: "selected"
             ColorAnimation {
                 target: circle
                 properties: "color"
                 duration: 500
             }
             ColorAnimation {
                 target: number
                 properties: "color"
                 duration: 500
             }
         }
     ]
}

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: root
    title: qsTr("Hello World")
    width: 810
    height: 1080
    visible: true
    color: "white"

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: "white"

        Rectangle {
            id: numBox
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.horizontalCenter: parent.horizontalCenter
            width: 675
            height: 135
            visible: true

            Text {
                id: digits
                property string currDigits: ""
                property string allChars: ""
                anchors.centerIn: parent
                font.pixelSize: 72
                font.weight: Font.Light
                text: allChars
                wrapMode: Text.WrapAnywhere
            }

        }

        Grid {
            id: grid
            width: 540
            height: 1080
            rows: 4; columns: 3
            spacing: 67
            anchors.top: numBox.bottom
            anchors.topMargin: 45
            anchors.horizontalCenter: parent.horizontalCenter

            CircleBase {
                id: one
                digit: "1"
                KeyNavigation.right: two
                KeyNavigation.down: four
            }
            CircleBase {
                id: two
                digit: "2"
                KeyNavigation.right: three
                KeyNavigation.down: five
                KeyNavigation.left: one
            }
            CircleBase {
                id: three
                digit: "3"
                KeyNavigation.left: two
                KeyNavigation.down: six
            }
            CircleBase {
                id: four
                digit: "4"
                KeyNavigation.up: one
                KeyNavigation.down: seven
                KeyNavigation.right: five
            }
            CircleBase {
                id: five
                digit: "5"
                KeyNavigation.up: two
                KeyNavigation.down: eight
                KeyNavigation.right: six
                KeyNavigation.left: four
                focus: true
            }
            CircleBase {
                id: six
                digit: "6"
                KeyNavigation.up: three
                KeyNavigation.down: nine
                KeyNavigation.left: five
            }
            CircleBase {
                id: seven
                digit: "7"
                KeyNavigation.up: four
                KeyNavigation.down: asterisk
                KeyNavigation.right: eight
            }
            CircleBase {
                id: eight
                digit: "8"
                KeyNavigation.up: five
                KeyNavigation.down: zero
                KeyNavigation.right: nine
                KeyNavigation.left: seven
            }
            CircleBase {
                id: nine
                digit: "9"
                KeyNavigation.up: six
                KeyNavigation.down: pound
                KeyNavigation.left: eight
            }
            CircleBase {
                id: asterisk
                digit: "*"
                KeyNavigation.up: seven
                KeyNavigation.right: zero
            }
            CircleBase {
                id: zero
                digit: "0"
                KeyNavigation.up: eight
                KeyNavigation.left: asterisk
                KeyNavigation.right: pound
            }
            CircleBase {
                id: pound
                digit: "#"
                KeyNavigation.up: nine
                KeyNavigation.left: zero
            }
        }

        Keys.onPressed: {
            if (event.key == Qt.Key_0) {
                digits.currDigits += "0"
                format()
                zero.forceActiveFocus()
                zero.isPressed = true
                zero.state = "confirm"
            }
            if (event.key == Qt.Key_1) {
                digits.currDigits += "1"
                format()
                one.forceActiveFocus()
                one.isPressed = true
                one.state = "confirm"
            }
            if (event.key == Qt.Key_2) {
                digits.currDigits += "2"
                format()
                two.forceActiveFocus()
                two.isPressed = true
                two.state = "confirm"
            }
            if (event.key == Qt.Key_3) {
                digits.currDigits += "3"
                format()
                three.forceActiveFocus()
                three.isPressed = true
                three.state = "confirm"
            }
            if (event.key == Qt.Key_4) {
                digits.currDigits += "4"
                format()
                four.forceActiveFocus()
                four.isPressed = true
                four.state = "confirm"
            }
            if (event.key == Qt.Key_5) {
                digits.currDigits += "5"
                format()
                five.forceActiveFocus()
                five.isPressed = true
                five.state = "confirm"
            }
            if (event.key == Qt.Key_6) {
                digits.currDigits += "6"
                format()
                six.forceActiveFocus()
                six.isPressed = true
                six.state = "confirm"
            }
            if (event.key == Qt.Key_7) {
                digits.currDigits += "7"
                format()
                seven.forceActiveFocus()
                seven.isPressed = true
                seven.state = "confirm"
            }
            if (event.key == Qt.Key_8) {
                digits.currDigits += "8"
                format()
                eight.forceActiveFocus()
                eight.isPressed = true
                eight.state = "confirm"
            }
            if (event.key == Qt.Key_9) {
                digits.currDigits += "9"
                format()
                nine.forceActiveFocus()
                nine.isPressed = true
                nine.state = "confirm"
            }
            if (event.key == Qt.Key_Asterisk) {
                digits.currDigits += "*"
                format()
                asterisk.forceActiveFocus()
                asterisk.isPressed = true
                asterisk.state = "confirm"
            }
            if (event.key == Qt.Key_NumberSign) {
                digits.currDigits += "#"
                format()
                pound.forceActiveFocus()
                pound.isPressed = true
                pound.state = "confirm"
            }
            if (event.key == Qt.Key_Back) { removeHelper() }
        }

        Keys.onReleased: {
             if (event.key == Qt.Key_0) {
                 zero.state = "selected"
                 zero.isPressed = false
             }
             if (event.key == Qt.Key_1) {
                 one.state = "selected"
                 one.isPressed = false
             }
             if (event.key == Qt.Key_2) {
                 two.state = "selected"
                 two.isPressed = false
             }
             if (event.key == Qt.Key_3) {
                 three.state = "selected"
                 three.isPressed = false
             }
             if (event.key == Qt.Key_4) {
                 four.state = "selected"
                 four.isPressed = false
             }
             if (event.key == Qt.Key_5) {
                 five.state = "selected"
                 five.isPressed = false
             }
             if (event.key == Qt.Key_6) {
                 six.state = "selected"
                 six.isPressed = false
             }
             if (event.key == Qt.Key_7) {
                 seven.state = "selected"
                 seven.isPressed = false
             }
             if (event.key == Qt.Key_8) {
                 eight.state = "selected"
                 eight.isPressed = false
             }
             if (event.key == Qt.Key_9) {
                 nine.state = "selected"
                 nine.isPressed = false
             }
             if (event.key == Qt.Key_Asterisk) {
                 asterisk.state = "selected"
                 asterisk.isPressed = false
             }
             if (event.key == Qt.Key_NumberSign) {
                 pound.state = "selected"
                 pound.isPressed = false
             }
        }

        function format() {
            var allDigits = digits.currDigits
            if (allDigits.length > 10) {
            } else if (allDigits.length > 6) {
                var allDigits1 = "(" + allDigits.substring(0, 3) + ") "
                var allDigits2 = allDigits.substring(3, 6) + "-"
                allDigits = allDigits1 + allDigits2 + allDigits.substring(6)
            } else if (allDigits.length > 3) {
                allDigits = allDigits.substring(0, 3) + "-" + allDigits.substring(3)
            }
            digits.allChars = allDigits
        }

        function removeHelper() {
            digits.currDigits = digits.currDigits.slice(0, -1)
            format()
        }
    }
}

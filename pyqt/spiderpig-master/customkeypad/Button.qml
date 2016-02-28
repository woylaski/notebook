import QtQuick 1.1

Rectangle {
    id: button

    property alias mainText: buttonMainText.text
    property alias altText: buttonAltText.text
    property bool hasAlternates: false

    width: 57
    height: 57
    color: "#CCC"
    clip: false
    border.width: 1
    border.color: "#aaa"

    opacity: mainText.length > 0 ? 1 : 0.4

    gradient: gradientNormal

    Gradient {
        id: gradientNormal
        GradientStop {position: 1; color: "#ddd"}
        GradientStop {position: 0; color: "white"}
    }

    Gradient {
        id: gradientDown
        GradientStop {position: 0; color: "#ddd"}
        GradientStop {position: 1; color: "white"}
    }

    Text {
        id: buttonMainText
        anchors.centerIn: parent
        color: "black"
        font.pixelSize: 22
        text: "A"
    }
    Text {
        id: buttonAltText
        anchors {
            right: parent.right
            top: parent.top
            margins: 3
        }
        font.pixelSize: 10
        color: "black"
    }

//    MouseArea {
//        anchors.fill: parent
//        onPressed: {button.gradient = gradientDown}
//        onReleased: {button.gradient = gradientNormal}
//    }

//    Rectangle {
//        id: tileIndicatingAlternatesBehind

//        visible: false;//hasAlternates || altText
//        width: button.width
//        height: parent.height;
//        x: 3
//        y: 3
//        z: parent.z-1

//        color: parent.color
//        gradient: Gradient {
//            GradientStop {position: 1; color: "#ddd"}
//            GradientStop {position: 0; color: "white"}
//        }
//        border.color: parent.border.color
//        border.width: parent.border.width
//        opacity: 0.7
//    }

}

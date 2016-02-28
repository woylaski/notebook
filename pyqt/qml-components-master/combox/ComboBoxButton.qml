import QtQuick 1.1

FocusScope {
    id: container
    signal clicked
    property string source
    property string buttontext
    property string color: "#ffffff"
    property int textSize: 10
    property int buttonopacity:1
    Rectangle {
        id: buttonRectangle
        anchors.fill: parent
        color: "white"
        radius: 5
        opacity: buttonopacity
        border.width: 1
        border.color: "grey"
        Text {
            color: "black"
            anchors.centerIn: parent
            font.pointSize: 12
            text: container.buttontext
        }
        MouseArea {
            id: mouseArea;
            anchors.fill: parent
            onClicked: {
                buttonRectangle.state = "pressed"
                container.clicked()
            }
        }
    }
}

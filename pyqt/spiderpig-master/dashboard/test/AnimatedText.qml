import QtQuick 1.1

Rectangle {

    width: 600
    height: 400

    Text {
        id: txt
        anchors.centerIn: parent
        font.pointSize: 20
        text: "Meeting with big boss!"
        horizontalAlignment: Text.Center
        smooth: true
        width: 600
        height: 50
    }

    SequentialAnimation {
        id: animatedText
        loops: Animation.Infinite
        running: true

        NumberAnimation { target: txt; property: "font.letterSpacing"; to: 1; duration: 700 }
        NumberAnimation { target: txt; property: "font.letterSpacing"; to: 0; duration: 700 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(txt.font.letterSpacing);
            animatedText.running = ! animatedText.running
            console.log(animatedText.running)
        }
    }
}

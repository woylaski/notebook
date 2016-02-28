import QtQuick 1.1

Rectangle {
    id: menuBar
    width: 800
    height: quitButton.height + 10;
    property Theme theme : Theme {}
    state: "HIDDEN"

    states: State {
        name: "HIDDEN"
        PropertyChanges {
            target: menuBar
            height: 0
        }
    }

    Behavior on height {
        NumberAnimation {duration: 200 }
    }

    Rectangle {
        id: visibilityContainer
        anchors.fill: parent
        color: parent.color
        opacity: menuBar.state == "HIDDEN" ? 0 : 1

        Rectangle {
            id: quitButton
            anchors.centerIn: parent
            anchors.margins: 5
            height: 20
            border {width: 2; color: "white"}
            smooth: true
            color: parent.color
            width: height

            Text {
                x: 0; y:0
                font.family: theme.fontFamily
                font.pixelSize: 15
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 2
                text: "X"
                smooth: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onReleased: Qt.quit();
            }
        }
    }

}

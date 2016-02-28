import QtQuick 1.1

Rectangle {
    id: splash

    width: 800
    height: 600
    opacity: 1

    Image {
        id:logo
        anchors.centerIn: parent
        source: "logo.jpg"
        opacity: 0
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            splashAnimation.running = false;
            splash.visible=false;
        }
    }

    SequentialAnimation {
        id: splashAnimation
        running: true
        PauseAnimation { duration: 1000 }
        NumberAnimation {
            target: logo
            property: "opacity"
            from: 0; to: 1
            duration: 3000
        }
        PauseAnimation { duration: 1000 }
        NumberAnimation {
            target: logo
            property: "opacity"
            from: 1; to: 0
            duration: 2000
        }
        NumberAnimation {
            target: splash
            property: "opacity"
            to: 0
            duration: 3000
        }
        PropertyAction {
            target: splash
            property: "visible"
            value: false
        }
    }

}

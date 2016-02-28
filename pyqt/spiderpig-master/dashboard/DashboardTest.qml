import QtQuick 1.0

Rectangle {
    id: fullscreenResizer

    property real screenRatio: 9/16.; // intrepid

    // the size we use when developing, typically with smaller monitor
    // than the one used to display the dashboard in 'production'
    property int developmentWidth: 1000
    property int developmentHeight: screenRatio * developmentWidth

    // set initially, but may be adjusted by user.
    // this will actively change the scaling
    width: developmentWidth
    height: developmentHeight

    property real continuousScalingFactor: width / developmentWidth

    property Theme metroTheme : Theme {}
    color: metroTheme.dashboardBackground



    Rectangle {
        id: content
        width: developmentWidth
        height: developmentHeight

        transformOrigin: Item.TopLeft
        scale: continuousScalingFactor
        color: metroTheme.dashboardBackground

        Rectangle {
            id: statusAndNotifications

            width: developmentWidth
            height: childrenRect.height

            StatusBar {
                id: statusBar
                anchors {top: parent.top;}
                z: content.z + 1
                theme: metroTheme
                width: developmentWidth
            }

            Notification {
                id: notificationBar
                anchors {top: statusBar.bottom}
                width: statusBar.width
                height: statusBar.height
                theme: metroTheme
            }
        }
        PageTest {
            id: tilePage
            anchors {
                top: statusAndNotifications.bottom;
                margins: metroTheme.tilePad;
                horizontalCenter: parent.horizontalCenter
            }
            theme: metroTheme
        }
    }

    MenuBar {
        id: menuBar
        anchors {bottom: parent.bottom}
        width: developmentWidth
        color: statusBar.color
        scale: continuousScalingFactor
        theme: metroTheme
        transformOrigin: Item.BottomLeft
    }

    MouseArea {
        id: screenClickDetector
        anchors.fill: parent
        onClicked: menuBar.state = (menuBar.state == "HIDDEN" ? "" : "HIDDEN")
        z: menuBar.z - 1
    }

    Splash {
        id: splayScreenWillOnlyDisplayInitially
        anchors.fill: parent
    }

}

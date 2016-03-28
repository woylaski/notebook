import QtQuick 2.5
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

Item {

    Column {
        anchors.centerIn: parent
        spacing: Base.Units.dp(20)

        Elements.Button {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "Push subpage"
            elevation: 1
            onClicked: pageStack.push(Qt.resolvedUrl("SubPage.qml"))
        }

        Elements.Button {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "Push subpage with sidebar"
            elevation: 1
            onClicked: pageStack.push(Qt.resolvedUrl("SidebarPage.qml"))
        }

        Image {
            id: image

            anchors.horizontalCenter: parent.horizontalCenter

            //source: Qt.resolvedUrl("images/balloon.jpg")
            source: "qrc:/images/images/balloon.jpg"
            width: Base.Units.dp(400)
            height: Base.Units.dp(250)

            Elements.Ink {
                anchors.fill: parent

                onClicked: overlayView.open(image)
            }
        }

        Elements.Label {
            anchors.horizontalCenter: parent.horizontalCenter

            style: "subheading"
            color: Base.Theme.light.subTextColor
            text: "Tap to edit picture"
            font.italic: true
        }
    }

    Elements.OverlayView {
        id: overlayView

        width: Base.Units.dp(800)
        height: Base.Units.dp(500)

        Image {
            id: contentImage
            source: "qrc:/images/images/balloon.jpg"
            //source: Qt.resolvedUrl("images/balloon.jpg")
            anchors.fill: parent
        }

        Row {
            anchors {
                top: parent.top
                right: parent.right
                rightMargin: Base.Units.dp(16)
            }
            height: Base.Units.dp(48)
            opacity: overlayView.transitionOpacity

            spacing: Base.Units.dp(24)

            Repeater {
                model: ["content/add", "image/edit", "action/delete"]

                delegate: Elements.IconButton {
                    id: iconAction

                    iconName: modelData

                    color: Base.Theme.dark.iconColor
                    size: iconName == "content/add" ? Base.Units.dp(27) : Base.Units.dp(24)
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}


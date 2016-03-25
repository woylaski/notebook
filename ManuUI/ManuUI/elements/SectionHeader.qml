import QtQuick 2.5
import QtQuick.Layouts 1.1

import "qrc:/base/base" as Base

BaseListItem {
    id: listItem

    property alias text: label.text
    property alias iconName: icon.name
    property bool expanded: false

    height: Base.Units.dp(48)

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: Base.Units.dp(16)

        Item {
            Layout.preferredWidth: Base.Units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter

            visible: children.length > 1 || iconName != ""

            Icon {
                id: icon

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: name != ""
                color: listItem.expanded ? Base.Theme.primaryColor : Base.Theme.light.iconColor
                size: Base.Units.dp(24)
            }
        }

        Label {
            id: label

            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            elide: Text.ElideRight
            style: "subheading"

            color: listItem.expanded ? Base.Theme.primaryColor : Base.Theme.light.textColor
        }

        Item {
            Layout.preferredWidth: Base.Units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignRight

            Icon {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                name: "navigation/expand_more"
                rotation: listItem.expanded ? 180 : 0
                size: Base.Units.dp(24)

                Behavior on rotation {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }

    onClicked: listItem.expanded = !listItem.expanded
}



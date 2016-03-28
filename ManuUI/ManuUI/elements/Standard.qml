import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "qrc:/base/base" as Base

BaseListItem {
    id: listItem

    implicitHeight: Base.Units.dp(48)
    height: Base.Units.dp(48)

    property alias text: label.text
    property alias valueText: valueLabel.text

    property alias action: actionItem.children
    property alias iconName: icon.name
    property alias iconSource: icon.source
    property alias secondaryItem: secondaryItem.children
    property alias content: contentItem.children

    property alias itemLabel: label
    property alias itemValueLabel: valueLabel

    property alias textColor: label.color
    property alias iconColor: icon.color

    dividerInset: actionItem.visible ? listItem.height : 0

    interactive: contentItem.children.length === 0

    implicitWidth: {
        var width = listItem.margins * 2

        if (actionItem.visible)
            width += actionItem.width + row.spacing

        if (contentItem.visible)
            width += contentItem.implicitWidth + row.spacing
        else
            width += label.implicitWidth + row.spacing

        if (valueLabel.visible)
            width += valueLabel.width + row.spacing

        if (secondaryItem.visible)
            width += secondaryItem.width + row.spacing

        return width
    }

    RowLayout {
        id: row
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: Base.Units.dp(16)

        Item {
            id: actionItem

            Layout.preferredWidth: Base.Units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter

            visible: children.length > 1 || icon.valid

            Icon {
                id: icon

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: valid
                color: listItem.selected ? Base.Theme.primaryColor : Base.Theme.light.iconColor
                size: Base.Units.dp(24)
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: parent.height

            Item {
                id: contentItem

                Layout.fillWidth: true
                Layout.preferredHeight: parent.height

                visible: children.length > 0
            }

            Label {
                id: label

                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true

                elide: Text.ElideRight
                style: "subheading"

                color: listItem.selected ? Base.Theme.primaryColor : Base.Theme.light.textColor

                visible: !contentItem.visible
            }
        }

        Label {
            id: valueLabel

            Layout.alignment: Qt.AlignVCenter

            color: Base.Theme.light.subTextColor
            elide: Text.ElideRight
            style: "body1"

            visible: text != ""
        }

        Item {
            id: secondaryItem

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: parent.height

            visible: children.length > 0
        }
    }
}


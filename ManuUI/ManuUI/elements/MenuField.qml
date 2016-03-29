import QtQuick 2.5
import QtQuick.Layouts 1.1
import "qrc:/base/base" as Base

Item {
    id: field

    implicitHeight: hasHelperText ? helperTextLabel.y + helperTextLabel.height + Base.Units.dp(4)
                                  : underline.y + Base.Units.dp(8)
    implicitWidth: spinBoxContents.implicitWidth

    activeFocusOnTab: true

    property color accentColor: Base.Theme.accentColor
    property color errorColor: "#F44336"

    property alias model: listView.model

    property string textRole

    readonly property string selectedText: (listView.currentItem) ? listView.currentItem.text : ""

    property alias selectedIndex: listView.currentIndex
    property int maxVisibleItems: 4

    property alias placeholderText: fieldPlaceholder.text
    property alias helperText: helperTextLabel.text

    property bool floatingLabel: false
    property bool hasError: false
    property bool hasHelperText: helperText.length > 0

    readonly property rect inputRect: Qt.rect(spinBox.x, spinBox.y, spinBox.width, spinBox.height)

    signal itemSelected(int index)

    Ink {
        anchors.fill: parent
        onClicked: {
            listView.positionViewAtIndex(listView.currentIndex, ListView.Center)
            var offset = listView.currentItem.itemLabel.mapToItem(menu, 0, 0)
            menu.open(label, 0, -offset.y)
        }
    }

    Item {
        id: spinBox

        height: Base.Units.dp(24)
        width: parent.width

        y: {
            if(!floatingLabel)
                return Base.Units.dp(16)
            if(floatingLabel && !hasHelperText)
                return Base.Units.dp(40)
            return Base.Units.dp(28)
        }

        RowLayout {
            id: spinBoxContents

            height: parent.height
            width: parent.width + Base.Units.dp(5)

            Label {
                id: label

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                text: (listView.currentItem) ? listView.currentItem.text : ""
                style: "subheading"
                elide: Text.ElideRight
            }

            Icon {
                id: dropDownIcon

                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                Layout.preferredWidth: Base.Units.dp(24)
                Layout.preferredHeight: Base.Units.dp(24)

                name: "navigation/arrow_drop_down"
                size: Base.Units.dp(24)
            }
        }

        Dropdown {
            id: menu

            anchor: Item.TopLeft

            width: spinBox.width

            //If there are more than max items, show an extra half item so
            // it's clear the user can scroll
            height: Math.min(maxVisibleItems*Base.Units.dp(48) + Base.Units.dp(24), listView.contentHeight)

            ListView {
                id: listView

                width: menu.width
                height: count > 0 ? menu.height : 0

                interactive: true

                delegate: Standard {
                    id: delegateItem

                    text: textRole ? model[textRole] : modelData

                    onClicked: {
                        itemSelected(index)
                        listView.currentIndex = index
                        menu.close()
                    }
                }
            }

            Scrollbar {
                flickableItem: listView
            }
        }
    }

    Label {
        id: fieldPlaceholder

        text: field.placeholderText
        visible: floatingLabel

        font.pixelSize: Base.Units.dp(12)

        anchors.bottom: spinBox.top
        anchors.bottomMargin: Base.Units.dp(8)

        color: Base.Theme.light.hintColor
    }

    Rectangle {
        id: underline

        color: field.hasError ? field.errorColor : field.activeFocus ? field.accentColor : Base.Theme.light.hintColor

        height: field.activeFocus ? Base.Units.dp(2) : Base.Units.dp(1)

        anchors {
            left: parent.left
            right: parent.right
            top: spinBox.bottom
            topMargin: Base.Units.dp(8)
        }

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    Label {
        id: helperTextLabel

        anchors {
            left: parent.left
            right: parent.right
            top: underline.top
            topMargin: Base.Units.dp(4)
        }

        visible: hasHelperText
        font.pixelSize: Base.Units.dp(12)
        color: field.hasError ? field.errorColor : Qt.darker(Base.Theme.light.hintColor)

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}



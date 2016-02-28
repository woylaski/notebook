import QtQuick 2.4
import QtQml.Models 2.2
import QtQuick.Controls 1.3

ObjectModel {
    id: root
    property int width
    property int height

    property int index

    Rectangle {
        id: container
        width: root.width
        height: root.height
        color: "#e0f2f1"

        ListView {
            id: componentsListView
            anchors.fill: parent
            focus: true
            model: ComponentsListModel{}
            highlightMoveVelocity: 100
            boundsBehavior: Flickable.DragOverBounds
            onCurrentIndexChanged: loader.source = model.get(currentIndex).path

            delegate: Item {
                id: delegate
                width: componentsListView.width
                height: dpi(10)

                Rectangle {
                    anchors.fill: parent
                    color: mouseArea.containsMouse? "#80cbc4" : "transparent"
                    Behavior on color { ColorAnimation { duration: 100 } }
                }

                Label {
                    id: componentNameLabel
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: dpi(2)
                    text: name
                    font.pointSize: 12
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        componentsListView.currentIndex = index
                        root.index = 1
                    }
                }

                Image {
                    width: dpi(8)
                    height: dpi(8)
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/icons/icons/ic_keyboard_arrow_right_black_48dp.png"
                }
            }
        }
    }

    Item {
        width: root.width
        height: root.height

        Item {
            id: bar
            width: dpi(40)
            height: dpi(10)

            Row {
                width: parent.width
                height: parent.height

                Image {
                    width: dpi(8)
                    height: dpi(8)
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/icons/icons/ic_keyboard_arrow_left_black_48dp.png"
                }

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: componentsListView.model.get(componentsListView.currentIndex).name
                    color: backMouseArea.pressed? "#80cbc4" : "grey"
                }
            }

            MouseArea {
                id: backMouseArea
                anchors.fill: parent
                onClicked: root.index = 0
            }
        }

        Loader {
            id: loader
            width: root.width
            anchors.top: bar.bottom
            anchors.bottom: parent.bottom
            asynchronous: true
        }
    }
}

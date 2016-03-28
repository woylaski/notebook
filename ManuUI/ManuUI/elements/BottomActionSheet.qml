import QtQuick 2.5
import "qrc:/base/base" as Base

BottomSheet {
    id: bottomSheet

    property list<Action> actions

    property string title

    implicitHeight: title !== "" ? header.height + listViewContainer.implicitHeight
                                 : listViewContainer.implicitHeight

    Column {
        id: column

        anchors.fill: parent

        Subheader {
            id: header
            text: title
            visible: title !== ""
            height: Base.Units.dp(56)
            style: "subheading"
            backgroundColor: "white"
            elevation: listView.atYBeginning ? 0 : 1
            fullWidth: true
            z: 2
        }

        Item {
            id: listViewContainer

            width: parent.width
            height: title !== "" ? parent.height - header.height : parent.height

            implicitHeight: listView.contentHeight + listView.topMargin + listView.bottomMargin

            //提供一个较小的视窗,显示一个较大的内容,内容可在这个小视窗中进行拖动
            Flickable {
                id: listView
                //指明可供浏览的视窗大小
                width: parent.width
                height: parent.height

                interactive: bottomSheet.height < bottomSheet.implicitHeight

                topMargin: title !== "" ? 0 : Base.Units.dp(8)
                bottomMargin: Base.Units.dp(8)

                //指明了内容的大小
                contentWidth: width
                contentHeight: subColumn.height

                Column {
                    id: subColumn
                    width: parent.width

                    Repeater {
                        model: actions

                        delegate: Column {
                            width: parent.width

                            Standard {
                                id: listItem
                                text: modelData.name
                                iconSource: modelData.iconSource
                                visible: modelData.visible
                                enabled: modelData.enabled

                                onClicked: {
                                    bottomSheet.close()
                                    modelData.triggered(listItem)
                                }
                            }

                            Divider {
                                visible: modelData.hasDividerAfter
                            }
                        }
                    }
                }
            }

            Scrollbar {
                flickableItem: listView
            }
        }
    }
}



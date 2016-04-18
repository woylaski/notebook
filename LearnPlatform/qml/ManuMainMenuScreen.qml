import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import ProjectManager 1.1
import "."

ManuBlankScreen {
    id: mainMenuScreen

    ManuSplitView{
        id: menuItems
        anchors.fill: parent
        direction: "row"
        separator: true

        ManuFlickable {
            id: menuFlickable
            width: parent.width*0.2
            Layout.maximumWidth: parent.width*0.3
            Layout.minimumWidth: 50

            contentHeight: column.height

            Column {
                id: column
                anchors.left: parent.left
                anchors.right: parent.right

                //ManuNavigationButton {
                ManuTextButton{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: qsTr("PROJECTS")
                    //icon: "\uf0f6"
                    onClicked: {
                        ProjectManager.baseFolder = ProjectManager.Projects
                        stackView.push(Qt.resolvedUrl("ProjectsScreen.qml"))
                    }
                }
            }
        }

        Item{
            id: rootItem
            Layout.fillWidth: true
            anchors{
                top: parent.top
                bottom: parent.bottom
            }

            property int currentTab: 0

            ManuTabViewHeader{
                id: tabViewHeader
                height: 25
                anchors{
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                Component.onCompleted: addTab(qsTr("New tab"), "")
                onCurrentTabChanged: rootItem.currentTab = identifier
                onTabAdded: tabsModel.append({"identifier":identifier, "launchUrl":url})
                onTabRemoved: {
                    for(var i = 0; i < tabsModel.count; ++i)
                        if(tabsModel.get(i).identifier === identifier) {
                            rootItem.currentTab = prevIdentifier
                            tabsModel.remove(i)
                            return
                        }
                }
            }

            ListModel { id: tabsModel }
            Repeater {
                id: repeater
                model: tabsModel
                delegate: Tab {
                    //width: rootItem.width
                    //height: rootItem.height - tabViewHeader.height
                    //anchors.top: tabViewHeader.bottom
                    //anchors.left: parent.left
                    //anchors.bottom: parent.bottom
                    //y: tabViewHeader.y + tabViewHeader.height
                    visible: identifier === rootItem.currentTab
                    onVisibleChanged: {

                    }

                    Rectangle{
                        anchors{
                            left: rootItem.left
                            right: rootItem.right
                            //top: tabViewHeader.bottom
                            //bottom: rootItem.bottom
                        }
                        y: tabViewHeader.y + tabViewHeader.height
                        height: rootItem.height - tabViewHeader.height
                        //anchors.fill: parent
                        color: "lightgreen"

                        ManuDropDown{
                            anchors.left: parent.left
                            anchors.top: parent.top
                            height: 25; width: 100; z: 2
                            //onRoleChanged: toolBar.setRoleName(txt)
                        }

                        Text{

                            text: rootItem.currentTab
                        }
                    }

                    Component.onCompleted: {
                        rootItem.currentWebView = page
                        rootItem.currentTab = identifier
                    }
                }
            }
        }
    }
}


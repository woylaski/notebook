import QtQuick 2.5
import QtQuick.Controls 1.4

import "."

Item{
    id: root
    //width:100
    //height: 600
    //color: "green"
    height: container.height
    property alias dataView: menuList.delegate
    property alias dataModel: menuList.model
    property string key: ""
    property string subMenuKey: ""

    Column{
        id: container
        width: parent.width
        spacing: 2
        //anchors.fill: parent

        Repeater{
            id: menuList
            model: []
            delegate: view
        }
    }

    Component{
        id: view
        Rectangle{
            id: topMenu
            width: root.width
            height: menuItem.height
            //height: menuItem.height + subMenu.height

            property var subDataModel: {
                if(subMenuKey=="") return [];
                else if(modelData.hasOwnProperty(subMenuKey)) return modelData[subMenuKey]
                else return [];
            }

            Rectangle{
                id: menuItem
                width: root.width
                height: 20; radius: 3
                color: menuArea.hovered? "green":"lightBlue"
                anchors{
                    left: parent.left
                    //top: toolBar.bottom
                }
                Text{
                    font.family: FontIconVar.latoBoldFont.name
                    anchors.centerIn: parent
                    //text: index
                    text: {
                        if(key=="") return modelData;
                        else{
                            return modelData[key];
                        }
                    }
                }

                MouseArea{
                    id: menuArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    preventStealing: true
                    property bool hovered: menuArea.containsMouse && !menuArea.pressed
                    onClicked: {
                        print("current index:", index)
                        print("current item:", modelData.desc)
                        print("current item:", model[index])
                        //amenuView.color="green"
                        if(subMenu.visible==true){
                            subMenu.visible=false
                            topMenu.height=menuItem.height
                        }else{
                            subMenu.visible=true
                            topMenu.height=menuItem.height+subMenu.height
                        }
                    }
                }

                Behavior on color { ColorAnimation {}}
                transitions: Transition {ColorAnimation { duration: 250 } }
            }

            Column{
                id: subMenu
                width: parent.width
                anchors.top: menuItem.bottom
                visible: false

                Repeater{
                    id: subMenuView
                    model: subDataModel
                    delegate: Rectangle{
                        id: subMenuItem
                        width: parent.width
                        height: 20
                        color: subMenuArea.hovered? ColorVar.colorVars["alizarin"] :ColorVar.colorVars["concrete"]
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }

                        MouseArea{
                            id: subMenuArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            preventStealing: true
                            property bool hovered: containsMouse && !pressed
                            onClicked: {
                                print("current index:", index)
                                print("current item:", modelData)
                                //print("current item:", model[index])
                            }
                        }

                        Behavior on color { ColorAnimation {}}
                        transitions: Transition {ColorAnimation { duration: 250 } }
                    }
                }
            }
        }
    }
}


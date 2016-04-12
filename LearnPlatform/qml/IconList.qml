import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "js/ObjUtils.js" as ObjUtils
import "."

Window {
    id: root
    width: 800
    height: 600
    visible: true
    color: ColorVar.colorVars["greenSea"]

    Rectangle{
        id: desc
        width: parent.width
        height: 40
        anchors{
            left: parent.left
            top: parent.top
        }

        border.color: "black"

        Text{
            anchors.centerIn: parent
            wrapMode: Text.WrapAnywhere
            text: "Font Icon pickle, total "+ObjUtils.listLength(FontIconVar.faIcons)+" colors"
        }
    }

    ManuGrid{
        id: viewArea
        anchors{
            top: desc.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 10
        columns: 6; rows: ObjUtils.listLength(FontIconVar.faIcons)/columns + 1

        Repeater{
            model: ObjUtils.listKeys(FontIconVar.faIcons)
            delegate: Rectangle{
                //width: 60
                //height: 60
                width: view.width
                height: view.height
                //border.color: "black"
                color: ColorVar.colorVars["greenSea"]

                Column{
                    id: view
                    //anchors.fill: parent

                    Text{
                        text: modelData
                    }

                    Text{
                        width: 30
                        height: 30

                        //border.color: "black"
                        color: ColorVar.colorVars["wetAsphalt"]
                        //color: Qt.rgba(Math.random()%255,Math.random()%255, Math.random()%255, 0.5)

                        font.family: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons[modelData]

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                print("color ",modelData, "clicked")
                                //desc.color=ColorVar.colorVars[modelData]
                            }
                        }
                    }
                }
            }
        }
    }
}


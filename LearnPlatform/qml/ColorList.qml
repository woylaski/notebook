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
    color: "white"

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
            text: "color pickle, total "+ObjUtils.listLength(ColorVar.colorVars)+" colors"
        }
    }

    ManuGrid{
        id: viewArea
        anchors{
            top: desc.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 30
        rows: 5; columns: 5

        Repeater{
            model: ObjUtils.listKeys(ColorVar.colorVars)
            delegate: Rectangle{
                width: 60
                height: 60

                Column{
                    anchors.fill: parent

                    Text{
                        text: modelData
                    }

                    Rectangle{
                        width: 30
                        height: 30
                        //color: Qt.rgba(Math.random()%255,Math.random()%255, Math.random()%255, 0.5)
                        color: ColorVar.colorVars[modelData]

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                print("color ",modelData, "clicked")
                                desc.color=ColorVar.colorVars[modelData]
                            }
                        }
                    }
                }
            }
        }
    }
}


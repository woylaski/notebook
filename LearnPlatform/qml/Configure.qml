import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import "js/ObjUtils.js" as ObjUtils
import "."

Window {
    id: root
    width: 400
    height: 200
    visible: true
    color: "gray"

    property string fileType

    ManuFileDialog{
        id: chooseFile
        dialog.nameFilters: ["Exe files (*.exe)", "All files (*)"]
        onClick: {
            print("file dialog accept", selectFile)
            if(fileType=="python"){
                pythonPath.text=selectFile
            }else if(fileType=="database"){
                databasePath.text=selectFile
            }
        }
    }

    ManuColumnContainer{
        spacing: 20
        color: "lightgreen"
        anchors.fill: parent
        //anchors.horizontalCenter: parent.horizontalCenter

        ManuRowContainer{
            id: python
            spacing: 20
            //height:60
            width: 300; height:30
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                width: 60
                text:"Python"
                anchors.verticalCenter: parent.verticalCenter
            }
            ManuTextFiled{
                id: pythonPath
                width: 200
                placeholderText:"python path"
                anchors.verticalCenter: parent.verticalCenter
            }

            ManuFontIconButton{
                width:30; height:30;
                fontFamily: FontIconVar.fontAwesome.name
                text: FontIconVar.faIcons["fa_folder"]
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    fileType="python"
                    chooseFile.dialog.open()
                }
            }
        }

        ManuRowContainer{
            id: db
            spacing: 20
            //height:60
            width: 300; height:30
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                width: 60
                text:"Database"
                anchors.verticalCenter: parent.verticalCenter
            }
            ManuTextFiled{
                id: databasePath
                width: 200
                placeholderText:"database path"
                anchors.verticalCenter: parent.verticalCenter
            }

            ManuFontIconButton{
                width:30; height:30;
                fontFamily: FontIconVar.fontAwesome.name
                text: FontIconVar.faIcons["fa_folder"]
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    fileType="database"
                    chooseFile.dialog.open()
                }
            }
        }

        ManuRowContainer{
            spacing: 10
            width: 150; height:30
            anchors.horizontalCenter: parent.horizontalCenter

            ManuButton{
                width: 50;height:30;
                text:qsTr("确定")
                onClicked: {
                    print(pythonPath.text)
                    print(databasePath.text)
                }
            }

            ManuButton{
                width: 50;height:30;
                text:qsTr("取消")
                onClicked: {
                    root.destroy()
                }
            }
        }
    }
}



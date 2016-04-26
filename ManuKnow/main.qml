import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import manu.plugin 1.0
import "qml/js/LocalDataBase.js" as LocalDataBase

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr(appTitle)

    FileDialog{
        id: dialog
            title: "Please choose a file"
            folder: shortcuts.home
            onAccepted: {
                //console.log("You chose: " + dialog.fileUrls[0])
                //file.source=dialog.fileUrls[0]
                //Qt.resolvedUrl(newProjectFileDlg.fileUrl).toString();
                var path = dialog.fileUrl.toString();
                // remove prefixed "file:///"
                path= path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
                // unescape html codes like '%23' for '#'
                var cleanPath = decodeURIComponent(path);
                console.log(cleanPath)

                file.source=dialog.fileUrl.toString();
            }
    }

    FileIO{
        id: file
        onSourceChanged: {
            print("new source file is: ", source)
            viewtext.text=file.readString(source)
        }
    }

    Flickable{
        id: flick
        Text{
            id: viewtext
            anchors{
                left:  root.left
                 right:  root.right
                top:  root.top
            }

            text: "hello world"
        }
    }
    Button{
        id: openbtn
        x: parent.x +Math.floor(parent.width/2) - 200
        height: 30
        anchors{
            //left: parent.left+Math.floor(parent.width/2) - 60
            //right:  parent.right
            top: flick.bottom
            //bottom: parent.bottom
        }
        text: "select"

        onClicked: {
            dialog.open()
        }
    }

    Button{
        id: writebtn
        x: parent.x +Math.floor(parent.width/2) + 200
        height: 30
        anchors{
            //left: parent.left+Math.floor(parent.width/2) - 60
            //right:  parent.right
            top: flick.bottom
            //bottom: parent.bottom
        }
        text: "write"
    }

    Component.onCompleted: {
        viewtext.height=root.height - openbtn.height
        LocalDataBase.initDatabase()
    }
}

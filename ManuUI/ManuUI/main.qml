import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

import com.manu.fileio 1.0
import com.manu.treemodel 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile
import "qrc:/base/base" as Base
import "qrc:/components/components" as Components

Components.AppWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    function readDocument() {
        print("-----read doc-----")
        //io.source = Qt.resolvedUrl("file:///./hello.txt")
        //io.source = Qt.resolvedUrl("file:///E:/hello.txt")
        //io.source = "qrc:/hello.txt"
        //print(io.source.toString())

        io.source = openDialog.fileUrl
        print(io.source.toString())
        io.read()
        print(io.text)
        fileSystemModel.mdata=io.text
        view.model.fresh()
        //view.model = fileSystemModel
        //fileSystemModel.mdata=io.text
        //view.model = JSON.parse(io.text)
    }

    FileDialog {
        id: openDialog
        onAccepted: {
            readDocument()
        }
    }

    FileIO{
        id: io
    }

    TreeModel{
        id: fileSystemModel
        mdata: "hello world\tnihao\naa\tbb"
        onMdataChanged: {
            print("mdata changed")
            print(fileSystemModel.columnCount())
            print(fileSystemModel.rowCount())
        }
    }

    Item{
        id: viewarea
        width: parent.width
        height: parent.height-buttonarea.height
        anchors.top: parent.top

        ItemSelectionModel {
            id: sel
            model: fileSystemModel
            onSelectionChanged: {
                console.log("selected", selected)
                console.log("deselected", deselected)
            }
            onCurrentChanged: console.log("current", current)
        }

        TreeView {
            id: view
            anchors.fill: parent
            anchors.margins: 2 * 12
            //model: fileSystemModel
            selection: sel

            onCurrentIndexChanged: console.log("current index", currentIndex)

            itemDelegate: Rectangle {
                color: ( styleData.row % 2 == 0 ) ? "white" : "lightblue"
                height: 40

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    text: styleData.value // this points to the role we defined in the TableViewColumn below; which one depends on which column this delegate is instantiated for.
                }
            }

            TableViewColumn {
                title: "Title"
                role: "name"
                resizable: true
            }

            TableViewColumn {
                title: "Summary"
                role: "summary"
                width: view.width/2
            }
            onClicked: console.log("clicked the index is ?", index)
            onDoubleClicked: isExpanded(index) ? collapse(index) : expand(index)
        }
    }

    Item{
        id: buttonarea
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom

        Row{
            Button{
                text: "treemodel"
                onClicked: {
                    print(io.text)
                    fileSystemModel.mdata = io.text
                }
            }

            Button{
                text: "dialog"
                onClicked: openDialog.open()
            }
        }
    }
}


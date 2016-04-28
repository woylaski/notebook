import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import manu.plugin 1.0

Item {
    id: root
    property Item menuItem

    //a topic {'name':'UIDesign',  'icon':'ui.png',  'menu':'ui.json'}
    function loadTopics(){
        topicModel.append()
    }

    FileDialog{
        id: selectFile
        selectExisting: false
        selectMultiple : false
        onAccepted:{
            print("select file ",fileUrl)
        }
    }

    FileIO{
        id: rwFile
    }

    ListModel{
        id: topicModel
        Component.onCompleted: {
            topicModel.append({'name':'UIDesign111',  'icon':'ui.png',  'menu':'ui.json'})
            topicModel.append({'name':'UIDesign112',  'icon':'ui.png',  'menu':'ui.json'})
            topicModel.append({'name':'UIDesign113',  'icon':'ui.png',  'menu':'ui.json'})
        }
    }

    Component{
        id: topicDelegate
        Item{
            id: topicView
            height: 50
            width: root.width
            Text{
                text: name
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                //listView.currentItem.y
                onClicked: topicView.ListView.view.currentIndex = index
            }
        }
    }

    Component{
        id: topicHeader
        Rectangle{
            height: 20
            color: "lightgreen"
            Row{
                x:spacing
                spacing: 6
                Text{
                    text: "load"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            selectFile.open()
                            print("load was clicked")
                        }
                    }
                }

                Text{
                    text: "plus"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            print("plus was clicked")
                        }
                    }
                }

                Text{
                    text: "minus"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            print("minus was clicked")
                        }
                    }
                }
            }
        }
    }

    ListView{
        anchors.fill: parent
        orientation: Qt.Vertical
        verticalLayoutDirection: ListView.TopToBottom
        model: topicModel
        delegate: topicDelegate
        header: topicHeader
        //footer: topicHeader
        spacing: 6
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        onCurrentIndexChanged: {
            print("current index:", currentIndex)
        }
    }
}

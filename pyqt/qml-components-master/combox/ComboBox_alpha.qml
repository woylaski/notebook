import QtQuick 1.1
Column {
    id: comboBox
    property variant items          //["item1","item2","item3"]
    property int itemWidth: 80
    property int itemHeight: 20
    property int currentItem
    //property int selectedItem

    function getCurrentItem(){
        return currentItem
    }

    Row {  //下拉框
        Rectangle {
            id: headItem

            property alias headText: label.text

            width: itemWidth; height: itemHeight
            border.color: "#acb2c2"; border.width: 1

            Text { id: label; text: items[currentItem]; anchors.centerIn: parent }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dropList.state = "selecting"
                }
            }
        }

        Rectangle{
            width: icon.width; height: itemHeight
            border.color: "#acb2c2"; border.width: 1

            Image {
                id: icon
                source: "pulldown.png";
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Column {    //下拉列表
        id: dropList

        opacity: 0

        Repeater {
            model: items
            delegate: Rectangle {
                id: container
                width: itemWidth; height: itemHeight
                border.color: "#acb2c2"; border.width: 1

                Text { text: items[index]; anchors.centerIn: parent }
                MouseArea {
                    id: mousearea
                    anchors.fill: parent
                    onClicked: {
                        dropList.state = "selected"
                        currentItem = index
                    }

                }
                states: State {
                    name: "pressed"
                    when: mousearea.pressed
                    PropertyChanges{ target: container; color: "grey" }
                }
            }
        }
        states: [
            State {
                name: "selecting"
                PropertyChanges { target: dropList; opacity: 1}
                //不加这句currentItem会变回上一次的值，原因暂时不明
                //PropertyChanges { target: comboBox; explicit: true; currentItem: currentItem}

            },
            State {
                name: "selected"
                PropertyChanges { target: dropList; opacity: 0}
                //PropertyChanges { target: comboBeox; explicit: true; currentItem: selectedItem; restoreEntryValues: false}
            }

        ]
        //onStateChanged: console.log(state)
    }
}

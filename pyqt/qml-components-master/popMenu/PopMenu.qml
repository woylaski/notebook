import QtQuick 1.1

Column {
    id: popmenu
    property variant items          //[[label1,returnValue1]，[label2,returnValue2]]
    property int itemWidth: 80
    property int itemHeight: 30
    state: "inactived"

    signal itemClicked(string item)
    Repeater {
        model: items
        delegate: Rectangle {
            id: container
            width: itemWidth; height: itemHeight
            border.width: 1; border.color: "#acb2c2"
            Text { text: items[index][0]; anchors.centerIn: parent;  font.bold: true}

            MouseArea {
                id: mousearea
                anchors.fill: parent
                onClicked: {
                    itemClicked(items[index][1])
                }
//                onPressed:  color = "grey"
//                onReleased: color = "white"
            }
            states: State {
                name: "pressed"
                when: mousearea.pressed
                PropertyChanges { target: container; color: "grey" }
            }
        }
        states: [
            State {
                name: "actived"
                when: focus
                PropertyChanges {target: popmenu; opacity: 1}
            },
            State {
                name: "inactived"
                when: !focus
                PropertyChanges {target: popmenu; opacity: 0}
            }
        ]

    }
    //onStateChanged: console.log(state)
}

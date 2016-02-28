import QtQuick 1.1

Rectangle {
    id: container
    width: 400; height: 400
    focus: true

    property bool pop: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(container.state === "a")
                container.state = "b"
            else
                container.state = "a"
        }
    }
    PopMenu {
        id: popmenu
        focus: pop
        anchors.centerIn: parent
        items: [["<h3>open</h3>",1],["<b>close</b>",2],["delete",3],["back",4],["other",5]]
        onItemClicked: console.log(item)
    }
    function f(str){
        console.log(str)
    }

    states: [
        State {
            name: "a"
            PropertyChanges{target: container; pop: true}
        },
        State {
            name: "b"
            PropertyChanges{target: container; pop: false}
        }

    ]
    //onStateChanged: console.log(state)
}



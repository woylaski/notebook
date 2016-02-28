import QtQuick 1.0

Rectangle {
    id: adder

    width: 600
    height: 400
    property int componentsCreated: 0

    function add() {
        componentsCreated++;
        var comp = Qt.createComponent("TestItem.qml");

        var element = comp.createObject(column);
        var name = "Element " + componentsCreated;
        element.text = name;
        element.clicked.connect(onClicked);
    }

    function remove() {
        var c = column.children[column.children.length-1];
        console.log('destroy ', c.text);
        c.destroy();
    }

    function insert() {
        var insertPos = 1;
        var comp = Qt.createComponent("TestItem.qml");
        var element = comp.createObject(null);
        element.text = "Inserted";
        console.log('insert');

        for (var i=1; i<column.length-1; i++) {

        }
    }

    function removeElementWithText(text) {
        for (var i=0; i<column.children.length; i++) {
            if (column.children[i].text === text)
                column.children[i].destroy();
        }
    }

    function onClicked(text) {
        console.log('click', text);
        removeElementWithText(text);
    }

    Component.onCompleted: {
    }

    Row {
        id: buttons
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        spacing: 20

        Rectangle {
            border.width: 1
            color: "green"
            width: 100
            height: 20
            Text {
                text: "Add"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onReleased: add();
            }
        }
        Rectangle {
            border.width: 1
            color: "yellow"
            width: 100
            height: 20
            Text {
                text: "Insert"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onReleased: insert();
            }
        }
        Rectangle {
            border.width: 1
            visible: column.children.length > 0
            color: "red"
            width: 100
            height: 20
            Text {
                text: "Remove last"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onReleased: remove();
            }
        }

    }

    Column {
        id: column

        anchors.top:buttons.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        spacing: 20
    }
}

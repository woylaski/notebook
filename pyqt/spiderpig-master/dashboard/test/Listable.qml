import QtQuick 1.1

Rectangle {
    id: listable

    default property alias content: elements.children

    width: 400;
    height: 400

    property int index: 0

    Component.onCompleted: {
        for (var i=0; i<content.length; i++) {
            content[i].visible = false;
        }
        content[0].visible = true;
    }

    function next() {
        content[index].visible = false;
        index++;
        if (index >= content.length)
            index = 0;
        console.log("show " + index);
        content[index].visible = true;
    }

    Rectangle {
        id: elements
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: next();
    }

}

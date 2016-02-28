import QtQuick 1.1

Rectangle {
    id: container

    property alias source: image.source
    property alias mode: image.fillMode
//    property alias caption: captionItem.text

    signal clicked()

    width: 50; height: 30
    border.color: "#acb2c2"; border.width: 1

    Image {
        id: image
        width: parent.width; height: parent.height //- captionItem.height
    }

//    Text  {
//        id: captionItem
//        anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom
//    }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        onClicked: container.clicked()
    }

    states: State {
        name: "press"
        when: mousearea.pressed
        PropertyChanges {target: container; color: "grey"}
    }
}

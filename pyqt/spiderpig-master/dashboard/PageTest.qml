import QtQuick 1.1

Rectangle {
    id: page

    property Theme theme : Theme {}

    width: childrenRect.width
    height: childrenRect.height
    color: theme.dashboardBackground

    Column {
        spacing: theme.tileSpacing

        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left
            Tile {}
            Tile {}
            Tile {}
            Tile {}
        }
        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left
            Tile {}
            Tile {}
            Tile {}
            Rotatable {
                width: 200; height: 200
                elementList: [
                    Rectangle {width: 200; height: 200; color: "yellow"},
                    Rectangle {width: 100; height: 100; color: "green"},
                    Rectangle {width: 50; height: 50; color: "red"}
                ]
            }
        }
        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left
            Tile {}
            Tile {}
            Tile {}
            Tile {}
        }
        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left
            Tile {}
            Tile {}
            Tile {}
            Tile {width: 110}
            Tile {width: 110}
        }
    } // column

}

import QtQuick 1.0

Rectangle {
    id: content
    width: 1600
    height: 1200
    color: "#F2F2F2"


    Column {
        x: 100
        y: 100
        spacing: 100

        Row {
            spacing: 100

            Conversation {}
            Conversation {}
        }

        Row {
            spacing: 50

            MenuRow {}
            MenuRow {}
        }

    }

}

import QtQuick 1.1

Rectangle {

    id: keyboard
    color: "black"
    property int spacing: 4
    width: rows.width + spacing*2
    height: rows.height + spacing*2

    Column {
        id: rows
        anchors.centerIn: parent
        spacing: keyboard.spacing

        Row {
            id: row1
            spacing: keyboard.spacing
            PreviewButton {
                mainText: "Q"
                altText: "1"
            }
            PreviewButton {
                mainText: "W"
                altText: "2"
            }
            PreviewButton {
                mainText: "E"
            }
            PreviewButton {
                mainText: "R"
            }
            PreviewButton {
                mainText: "T"
            }
            PreviewButton {
                mainText: "Y"
            }
            PreviewButton {
                mainText: "U"
            }
            PreviewButton {
                mainText: "I"
            }
            PreviewButton {
                mainText: "O"
            }
            PreviewButton {
                mainText: "P"
            }
        }
    }
}

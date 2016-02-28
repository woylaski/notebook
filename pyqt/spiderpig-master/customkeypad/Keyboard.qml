import QtQuick 1.1

Rectangle {

    id: keyboard
    color: "#ddd"
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
            Button {
                mainText: "Q"
                altText: "1"
            }
            Button {
                mainText: "W"
                altText: "2"
            }
            Button {
                mainText: "E"
                altText: "3"
            }
            Button {
                mainText: "R"
                altText: "4"
            }
            Button {
                mainText: "T"
                altText: "5"
            }
            Button {
                mainText: "Y"
                altText: "6"
            }
            Button {
                mainText: "U"
                altText: "7"
            }
            Button {
                mainText: "I"
                altText: "8"
            }
            Button {
                mainText: "O"
                altText: "9"
            }
            Button {
                mainText: "P"
                altText: "10"
            }
        }

        Row {
            id: row2
            spacing: keyboard.spacing
            Button {
                mainText: "A"
                hasAlternates: true
            }
            Button {
                mainText: "S"
            }
            Button {
                mainText: "D"
            }
            Button {
                mainText: "F"
            }
            Button {
                mainText: "G"
            }
            Button {
                mainText: "H"
            }
            Button {
                mainText: "J"
            }
            Button {
                mainText: "K"
            }
            Button {
                mainText: "L"
            }
            Button {
                mainText: "Ø"
            }
        }

    }
}

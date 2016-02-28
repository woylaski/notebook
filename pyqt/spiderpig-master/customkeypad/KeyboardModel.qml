import QtQuick 1.1

ListModel {
    id: keyboardModel

    ListElement {
        name: "row1"
        buttons: [
            ListElement { label: "Q"; altLabel: "1"},
            ListElement { label: "W"; altLabel: "2"},
            ListElement { label: "E"; altLabel: "3"},
            ListElement { label: "R"; altLabel: "4"},
            ListElement { label: "T"; altLabel: "5"},
            ListElement { label: "Y"; altLabel: "6"},
            ListElement { label: "U"; altLabel: "7"},
            ListElement { label: "I"; altLabel: "8"},
            ListElement { label: "O"; altLabel: "9"},
            ListElement { label: "P"; altLabel: "0"}
        ]
    }
    ListElement {
        name: "row2"
        buttons: [
            ListElement { label: "A"; altLabel: "Ä"},
            ListElement { label: "S"; altLabel: ""},
            ListElement { label: "D"; altLabel: ""},
            ListElement { label: "F"; altLabel: ""},
            ListElement { label: "G"; altLabel: ""},
            ListElement { label: "H"; altLabel: ""}
        ]
    }
    ListElement {
        name: "row3"
        buttons: [
            ListElement { label: "Z"; altLabel: ""},
            ListElement { label: "X"; altLabel: ""},
            ListElement { label: "C"; altLabel: ""},
            ListElement { label: "V"; altLabel: ""},
            ListElement { label: "B"; altLabel: ""},
            ListElement { label: ""; altLabel: ""},
            ListElement { label: ""; altLabel: ""},
            ListElement { label: ""; altLabel: ""}
        ]
    }
}

import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 1000
    height: 600
    color: "light grey"

    Column {
        TextArea {
            id: textarea
            text: qsTr("Hello World")
        }

        Reader {
            width: 250
            height: 100
            id: speedread
            selectedtext: textarea.text
        }
    }
}




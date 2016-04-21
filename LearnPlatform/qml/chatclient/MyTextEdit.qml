import QtQuick 2.0

Rectangle {
    property string text: id_textEdit.text

    border {width: 1; color: "lightblue";}
    color: "white"

    TextEdit {
        id: id_textEdit
        anchors.fill: parent
        focus: true
        wrapMode: TextEdit.WrapAnywhere

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.IBeamCursor
        }
    }
}


import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    id: textBrowser
    property string text
    property font textBrowserFont
    border {width: 1; color: "lightblue"}

    TextArea {
        anchors.fill: parent
        backgroundVisible: false
        textColor: textArea.textColor
//        textColor: "#00ffff"
//        textColor: "#5500ff"
//        textColor: "purple"
//        textColor: "#55ff00"
        readOnly: true
        text: textBrowser.text
        font: textBrowserFont
    }
}


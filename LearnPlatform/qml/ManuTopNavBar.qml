import QtQuick 2.5
import "."

Rectangle {
    id: root
    width: parent.width
    height: 40
    radius: 6
    color: ColorVar.colorVars["wetAsphalt"]

    property bool searchBarVisible: false

    ManuSearchInput {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 15
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        width: 250
        visible: root.searchBarVisible
    }
}


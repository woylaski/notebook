import QtQuick 2.0

Item {
    property bool topFocus

    anchors.fill: parent
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.parent.forceActiveFocus()
        }
    }
    // Handle the binded Python class's signals
    onTopFocusChanged: parent.forceActiveFocus()
}


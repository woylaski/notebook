import QtQuick 2.0
import "."

Item {
    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------
    height: Size.scale (52)

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    property alias text: status.text;

    //--------------------------------------------------------------------------
    // Objects
    //--------------------------------------------------------------------------

    Rectangle {
        color: "#ededed"
        anchors.fill: parent
    }

    Rectangle {
        color: "#ccc"
        anchors.fill: parent
        anchors.bottomMargin: parent.height - Size.scale (1)
    }

    Text {
        id: status;
        anchors.fill: parent;
        font.pointSize: 12;
    }

    Behavior on opacity { NumberAnimation{} }
}

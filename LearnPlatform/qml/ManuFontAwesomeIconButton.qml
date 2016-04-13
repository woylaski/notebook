import QtQuick 2.0
import "."

Item {
    //--------------------------------------------------------------------------
    // Custom properties
    //--------------------------------------------------------------------------

    property string text
    property string name
    property bool enabled: true
    property bool selected: false
    property string color: enabled ? (selected ? "#064" : "#222") : "#111"

    signal clicked

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    id: button
    width: Size.scale (30)
    height: Size.scale (30)

    //--------------------------------------------------------------------------
    // Behaviors
    //--------------------------------------------------------------------------

    Behavior on opacity { NumberAnimation{} }

    //--------------------------------------------------------------------------
    // Objects
    //--------------------------------------------------------------------------

    Column {
        anchors.fill: parent
        spacing: Size.scale (4)

        ManuLabel {
            id: icon
            color: button.color
            font.pixelSize: Size.scale (24)
            font.family: FontIconVar.fontAwesome.name
            anchors.horizontalCenter: parent.horizontalCenter

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            text: FontIconVar.faIcons[button.name]
        }

        ManuLabel {
            text: button.text
            color: button.color
            fontSize: Size.scale (8)
            anchors.horizontalCenter: icon.horizontalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button.enabled ? button.clicked() : undefined
    }
}



import QtQuick 2.5
import "qrc:/base/base" as Base

View {
    id: listItem

    //----- STYLE PROPERTIES -----//

    height: Base.Units.dp(48)
    property int margins: Base.Units.dp(16)

    anchors {
        left: parent.left
        right: parent.right
    }

    property int spacing

    property alias text: label.text
    property alias style: label.style
    property alias textColor: label.color

    Label {
        id: label

        font.pixelSize: Base.Units.dp(14)
        font.family: "Roboto"
        font.weight: Font.DemiBold

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: margins
        }

        color: Base.Theme.light.subTextColor
    }

    property bool showDivider: false

    ThinDivider {
        anchors.bottom: parent.bottom
        visible: showDivider
    }
}


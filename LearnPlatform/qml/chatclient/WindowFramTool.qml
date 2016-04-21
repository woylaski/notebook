import QtQuick 2.0
import QtQuick.Controls 1.2

ToolButton {
    id: id_windowToolButton
    property string toolName
    signal buttonClicked

    width: 20
    height: 20

    Image {
        width: 11
        height: 11
        anchors.centerIn: parent
        source: "Img/Images/" + id_windowToolButton.toolName + ".png"
    }

    onClicked: {
        buttonClicked()
    }
}


import QtQuick 2.5
import QtQuick.Controls 1.4
import "."

Rectangle {
    id: root
    default property alias content: ccontainer.children
    property alias spacing: ccontainer.spacing

    Column{
        id: ccontainer
        anchors.fill: parent
    }
}


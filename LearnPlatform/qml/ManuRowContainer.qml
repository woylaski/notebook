import QtQuick 2.5
import QtQuick.Controls 1.4
import "."

Item {
    id: root
    default property alias content: rcontainer.children
    property alias spacing: rcontainer.spacing

    Row{
        id: rcontainer
        /*anchors{
            top: parent.top
            bottom: parent.bottom
        }*/
        anchors.fill: parent
    }
}


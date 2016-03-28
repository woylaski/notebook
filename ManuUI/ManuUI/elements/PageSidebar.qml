import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls

Page {
    id: pageSidebar

    default property alias sidebar: sidebar.data
    property alias mode: sidebar.mode
    property bool showing: true

    anchors {
        rightMargin: showing ? 0 : -width

        Behavior on rightMargin {
            id: behavior
            enabled: false

            NumberAnimation { duration: 200 }
        }
    }

    height: parent.height

    Sidebar {
        id: sidebar

        anchors.fill: parent
    }

    Component.onCompleted: behavior.enabled = true
}



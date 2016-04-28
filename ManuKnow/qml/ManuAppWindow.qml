import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import manu.plugin 1.0

ApplicationWindow {
    id: appWin
    visible:  true
    title: qsTr(appTitle)
    width: 800
    height: 600

    ManuSplitView{
        anchors.fill: parent
        direction: "row"
        separator: true

        //border menu
        ManuTopic{
            //color: "gray"
            Layout.minimumWidth: 0.1*parent.width
            Layout.maximumWidth: 0.2*parent.width
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }

        //menu item
        ManuTopicMenu{
            //color: "lightgreen"
            Layout.minimumWidth: 0.1*parent.width
            Layout.maximumWidth: 0.3*parent.width
            Layout.preferredWidth: 100
        }

        //work area
        ManuWorkArea{
            //color: "gray"
            Layout.fillWidth: true
        }
    }
}

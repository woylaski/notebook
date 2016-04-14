import QtQuick 2.5
import ProjectManager 1.1
import "."

ManuBlankScreen {
    id: mainMenuScreen

    ManuTextBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        ManuLabel {
            anchors.fill: parent
            anchors.leftMargin: 5 * settings.pixelDensity
            text: appWindow.title
            font.pixelSize: 10 * settings.pixelDensity
        }
    }

    ManuFlickable {
        id: menuFlickable
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        contentHeight: column.height

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            //ManuNavigationButton {
            ManuTextButton{
                text: qsTr("PROJECTS")
                //icon: "\uf0f6"
                onClicked: {
                    ProjectManager.baseFolder = ProjectManager.Projects
                    stackView.push(Qt.resolvedUrl("ProjectsScreen.qml"))
                }
            }
        }
    }
}


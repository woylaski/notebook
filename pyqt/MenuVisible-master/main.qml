import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: qsTr("Slide Menu with Loader")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Rectangle {
        id: containerMenu
        width: 200
        height: 720
        color: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.top: parent.top

        property bool stateVisible: true
        states: [
                State { when: containerMenu.stateVisible;
                        PropertyChanges {   target: containerMenu; anchors.leftMargin: 0}},
                State { when: !containerMenu.stateVisible;
                        PropertyChanges {   target: containerMenu; anchors.leftMargin: -195 }}
            ]
        transitions: [ Transition { NumberAnimation { property: "anchors.leftMargin"; duration: 200}} ]



        ItemMenu {
            id: itemMenuTaula
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.left: parent.left
            itemName: "Taula Castellers"
            MouseArea {
                id: clickableAreaTaula
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Taula.qml"
            }
        }

        ItemMenu {
            id: itemMenuPilar
            anchors.right: parent.right
            anchors.top: itemMenuTaula.bottom
            anchors.left: parent.left
            itemName: "Pilar"
            MouseArea {
                id: clickableAreaPilar
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Pilar.qml"
            }
        }

        ItemMenu {
            id: itemMenuTorre
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuPilar.bottom
            itemName: "Torre"
            MouseArea {
                id: clickableAreaTorre
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Torre.qml"
            }
        }

        ItemMenu {
            id: itemMenuTres
            anchors.top: itemMenuTorre.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            itemName: "Tres"
            MouseArea {
                id: clickableAreaTres
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Tres.qml"
            }
        }

        ItemMenu {
            id: itemMenuQuatre
            anchors.top: itemMenuTres.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            itemName: "Quatre"
            MouseArea {
                id: clickableAreaQuatre
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Quatre.qml"
            }
        }

        ItemMenu {
            id: itemMenuCinc
            anchors.right: parent.right
            anchors.top: itemMenuQuatre.bottom
            anchors.left: parent.left
            itemName: "Cinc"
            MouseArea {
                id: clickableAreaCinc
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Cinc.qml"
            }
        }

        ItemMenu {
            id: itemMenuSet
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuCinc.bottom
            itemName: "Set"
            MouseArea {
                id: clickableAreaSet
                anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                onClicked: pageLoader.source = "Set.qml"
            }
        }

        ItemMenu {
            id: itemMenuSocaPilar
            anchors.top: itemMenuSet.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            itemName: "Soca Pilar"
            MouseArea {
                          id: clickableSPilar
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "SPilar.qml"
                      }
        }

        ItemMenu {
            id: itemMenuFolrePilar
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuSocaPilar.bottom
            itemName: "Folre Pilar"
            MouseArea {
                          id: clickableFPilar
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "FPilar.qml"
                      }
        }

        ItemMenu {
            id: itemMenuSocaTorre8
            anchors.top: itemMenuFolrePilar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            itemName: "Soca Torre"
            MouseArea {
                          id: clickableSTorre
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"

                          onClicked: pageLoader.source = "STorre.qml"
                      }
        }

        ItemMenu {
            id: itemMenuFolreTorre8
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuSocaTorre8.bottom
            itemName: "Folre Torre"
            MouseArea {
                          id: clickableFTorre
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "FTorre.qml"
                      }
        }

        ItemMenu {
            id: itemMenuSocaTres
            anchors.top: itemMenuFolreTorre8.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            itemName: "Soca Tres"
            MouseArea {
                          id: clickableSTres
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "Stres.qml"
                      }
        }

        ItemMenu {
            id: itemMenuFolreTres
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuSocaTres.bottom
            itemName: "Folre Tres"
            MouseArea {
                          id: clickableFTres
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "FTres.qml"
                      }
        }

        ItemMenu {
            id: itemMenuSocaQuatre
            anchors.top: itemMenuFolreTres.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            itemName: "Soca Quatre"
            MouseArea {
                          id: clickableSQuatre
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "SQuatre.qml"
                      }
        }

        ItemMenu {
            id: itemMenuFolreQuatre
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: itemMenuSocaQuatre.bottom
            anchors.bottom: parent.bottom
            itemName: "Folre Quatre"
            MouseArea {
                          id: clickableFQuatre
                          anchors.fill: parent
                onPressed: parent.color = "#2b2e37"
                onReleased: parent.color = "#383c4a"
                          onClicked: pageLoader.source = "FQuatre.qml"
                      }
        }

    }

    Button {
        id: butVisMenu
        anchors.verticalCenter: containerMenu.verticalCenter
        anchors.horizontalCenter: checked ? parent.left : containerMenu.right
        checkable: true
        text: checked ? "  >" : "  <"
        z: -1
        onClicked: containerMenu.stateVisible ? containerMenu.stateVisible = false : containerMenu.stateVisible = true
    }

    Item {
        z: -2
        anchors.left: containerMenu.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Loader {
            id: pageLoader
            source: "Taula.qml"
            anchors.fill: parent
        }

        Connections {
               target: pageLoader.item
               onMessage: console.log(msg)
           }


    }
}



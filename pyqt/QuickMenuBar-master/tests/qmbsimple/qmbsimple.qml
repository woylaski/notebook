
import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/QmbMenuBar"

Item {
    anchors.fill: parent

    // Create a rectangle with an action that can "toggle" itself...
    Rectangle {
        id: testRectangle
        x: 120
        y: 50
        width: textLabel.implicitWidth + 15
        height: textLabel.implicitHeight + 15
        color: "lightblue"
        border.color : "red"
        border.width : 0

        Text {
            id: textLabel
            text: "Test control"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: { testRectangle.color = "blue" }
            onExited: { testRectangle.color = "lightblue" }
            onClicked: { testAction.trigger( ) }
        }

        Action {
            id: testAction
            checkable : true
            onToggled: {
                console.debug( "Action toggled to " + checked )
                testRectangle.border.width = ( checked ? 2 : 0 )
            }
        }
    }

    Action {
        id: disabledAction
        enabled: false
    }

    QmbMenuBar {
        id: myMenuBar
        style.elementPreferredSize: 64

        QmbMenuItem {
            iconSource: "qrc:/oxygen/application-exit.svg"
            text: "Menu Elem 1"
        }
        QmbMenuSeparator { }
        QmbMenuItem {
            iconSource: "qrc:/oxygen/document-open.svg"
            text: "Menu Elem 2 with reallyyyyyyyy long label"
            checkable: true

            onTriggered: { console.debug( "Menu item " + text + " triggered" ) }
            onChecked: { console.debug( "Menu item " + text + " checked to " + state ) }
        }
        QmbMenuItem {
            iconSource: "qrc:/oxygen/media-playlist.svg"
            text: "Menu Elem 2b"
            action: testAction
        }
        QmbMenuItem {
            iconSource: "qrc:/breeze/showfoto.png"
            text: "Disabled Menu Elem"
            action: disabledAction
        }
        QmbMenuItem {
            iconSource: "qrc:/oxygen/office-chart-ring.svg"
            text: "Sub Menu 3"
            QmbMenu {
                orientation: Qt.Horizontal
                QmbMenuItem {
                    iconSource: "qrc:/oxygen/media-playlist.svg"
                    text: "Menu Elem 31"
                    onTriggered: { console.debug( "Menu item " + text + " triggered" ) }
                }
                QmbMenuSeparator { }
                QmbMenuItem {
                    iconSource: "qrc:/oxygen/office-chart-ring.svg"
                    text: "Menu Elem 32"

                    QmbMenu {
                        orientation: Qt.Vertical
                        QmbMenuItem {
                            iconSource: "qrc:/breeze/cuttlefish.png"
                            text: "Menu Elem 321"
                            onTriggered: { console.debug( "Menu item " + text + " triggered" ) }
                        }
                        QmbMenuSeparator { }
                        QmbMenuItem {
                            iconSource: "qrc:/breeze/pixelart-trace.png"
                            text: "Menu Elem 322"
                        }
                        QmbMenuItem {
                            iconSource: "qrc:/breeze/plank.png"
                            text: "Menu Elem 323"
                        }
                    }

                }
                QmbMenuItem {
                    iconSource: "qrc:/breeze/applications-engineering.png"
                    text: "Menu Elem 33"
                }
            }
        }

        QmbMenuItem {
            iconSource: "qrc:/oxygen/media-playlist.svg"
            text: "Menu Elem 2c"
            QmbMenu {
                orientation: Qt.Vertical
                QmbMenuItem {
                    iconSource: "qrc:/breeze/showfoto.png"
                    text: "Menu Elem 2c1"
                    onTriggered: { console.debug( "Menu item " + text + " triggered" ) }
                }
                QmbMenuSeparator { }
                QmbMenuItem {
                    iconSource: "qrc:/breeze/user-desktop.png"
                    text: "Menu Elem 2c2"
                }
                QmbMenuItem {
                    iconSource: "qrc:/breeze/utilities-system-monitor.png"
                    text: "Menu Elem 2c3"
                }
            }
        }
    } //  QmbMenuBar: myMenuBar

/*    QmbMenuBar {
        id: qmbLogoBar
        x: 0; y:0
        style.elementPreferredSize: 94
        style.subMenuMargin: 10
        style.elementHilightGradColor: Qt.rgba( 0.2, 0.7, 0.9, 0.45 )


        QmbMenuItem {
            iconSource: "qrc:/breeze/qmb.png"
            text: "QuickMenuBar"

            QmbMenu {
                orientation: Qt.Horizontal
                QmbMenuItem {
                    iconSource: "qrc:/breeze/rating.png"
                    text: "Simple/Light drop down menu"
                }
                QmbMenuSeparator { }
                QmbMenuItem {
                    iconSource: "qrc:/breeze/qtcreator.png"
                    text: "Pure QML"
                    checkable: true
                    QmbMenu {
                        orientation: Qt.Vertical
                        QmbMenuItem {
                            iconSource: "qrc:/gplv3.png"
                            text: "GPL"
                        }
                    }
                }
            }
        }
    }*/
}

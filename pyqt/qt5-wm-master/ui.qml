import QtQuick 2.1;
import QtQuick.Window 2.1;
import Qt5WM 1.0;

Window {
    id: root;
    color: "black";
    width: 1280;
    height: 800;
    visible: true;

    property var windowList : ({});

    Image {
        id: background
        source: "data/background.jpg";
        fillMode: Image.Tile;
        anchors.fill: parent;
    }
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            compositor.currentActiveClient = null;
            root.focus = true;
        }
    }
    Component {
        id: windowContainerComponent;

        Item {
            id: frame;
            x: client.x;
            y: client.y;
            z: client.z;
            width: client.w;
            height: client.h;
            visible: !client.minimized;

            property ClientWrapper client : null;

            Rectangle {
                id: decoration;
                color: "#242424";
                radius: 3;
                visible: frame.client.decorated;
                antialiasing: true;
                border {
                    width: 1;
                    color: (frame.client.current ? "skyblue" : "gray");
                }
                anchors {
                    top: titlebar.top;
                    left: frame.left;
                    right: frame.right;
                    bottom: frame.bottom;
                    margins: -4;
                }
            }
            MouseArea {
                id: titlebar;
                height: 30;
                visible: frame.client.decorated;
                drag.target: frame;
                anchors {
                    left: frame.left;
                    right: frame.right;
                    bottom: frame.top;
                }
                onPositionChanged: { compositor.moveClient (frame.client, frame.x, frame.y); }

                Row {
                    spacing: 4;
                    anchors.left: parent.left;
                    anchors.verticalCenter: parent.verticalCenter;

                    Image {
                        source: frame.client.icon;
                    }
                }
                Text {
                    text: frame.client.title;
                    color: "white";
                    anchors.centerIn: parent;
                }
                Row {
                    spacing: 4;
                    anchors.right: parent.right;
                    anchors.verticalCenter: parent.verticalCenter;

                    MouseArea {
                        width: 20;
                        height: 20;
                        onClicked: { }

                        Text {
                            text: "^";
                            color: "lightgray";
                            font.bold: true;
                            font.pixelSize: 16;
                            anchors.centerIn: parent;
                        }
                    }
                    MouseArea {
                        width: 20;
                        height: 20;
                        onClicked: { compositor.minimizeClient (frame.client); }

                        Text {
                            text: "─";
                            color: "lightgray";
                            font.bold: true;
                            font.pixelSize: 16;
                            anchors.centerIn: parent;
                        }
                    }
                    MouseArea {
                        width: 20;
                        height: 20;
                        onClicked: { compositor.maximizeClient (frame.client); }

                        Text {
                            text: "+";
                            color: "lightgray";
                            font.bold: true;
                            font.pixelSize: 16;
                            anchors.centerIn: parent;
                        }
                    }
                    MouseArea {
                        width: 20;
                        height: 20;
                        onClicked: { compositor.closeClient (frame.client); }

                        Text {
                            text: "×";
                            color: "lightgray";
                            font.bold: true;
                            font.pixelSize: 16;
                            anchors.centerIn: parent;
                        }
                    }
                }
            }
            Rectangle {
                id: container;
                color: "black";
                border.width: (frame.client.current ? 1 : 0);
                border.color: "magenta";
                anchors.fill: frame;
            }
        }
    }
    CompositorFacade {
        id: compositor;
        onClientAdded: {
            var delegate = windowContainerComponent.createObject (root, { "client" : clientWindowItem });
            windowList [clientWindowItem] = delegate;
        }
        onClientRemoved: {
            var delegate = windowList [clientWindowItem];
            delegate.destroy ();
        }
        Component.onCompleted: { init (root); }
    }
}

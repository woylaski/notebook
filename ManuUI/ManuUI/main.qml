import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
//import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

import com.manu.fileio 1.0
import com.manu.treemodel 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile

/*
import "base/"
*/
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/components/components" as Components

Components.AppWindow {
    id: demo

    clientSideDecorations: true

    theme {
        primaryColor: "blue"
        accentColor: "red"
        tabHighlightColor: "white"
    }

    /*
    initialPage: page0

    Elements.Page {
        id: page0
        title: "Page Title"

        Elements.Label {
            anchors.centerIn: parent
            text: "Hello World!"
        }
    }
    */
    property var styles: [
            "Icons", "Custom Icons", "Color Palette", "Typography"
    ]

    property var basicComponents: [
            "Button", "CheckBox", "Progress Bar", "Radio Button",
            "Slider", "Switch", "TextField"
    ]

    property var compoundComponents: [
            "Bottom Sheet", "Dialog", "Forms", "List Items", "Page Stack", "Time Picker", "Date Picker"
    ]

    property var sections: [ basicComponents, styles, compoundComponents ]
    property var sectionTitles: [ "Basic Components", "Style", "Compound Components" ]
    property string selectedComponent: sections[0][0]

    initialPage: Elements.TabbedPage {
        id:page
        title: "Demo"
        actionBar.maxActionCount: navDrawer.enabled ? 3 : 4

        backAction: navDrawer.action

        Elements.NavigationDrawer {
            id: navDrawer

            enabled: page.width < Base.Units.dp(500)

            onEnabledChanged: smallLoader.active = enabled

            Flickable {
                anchors.fill: parent

                contentHeight: Math.max(content.implicitHeight, height)

                Column {
                    id: content
                    anchors.fill: parent

                    Repeater {
                        model: sections

                        delegate: Column {
                            width: parent.width

                            Elements.Subheader {
                                text: sectionTitles[index]
                            }

                            Repeater {
                                model: modelData
                                delegate: Elements.Standard {
                                    text: modelData
                                    selected: modelData == demo.selectedComponent
                                    onClicked: {
                                        demo.selectedComponent = modelData
                                        navDrawer.close()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Repeater {
            model: !navDrawer.enabled ? sections : 0

            delegate: Tab {
                title: sectionTitles[index]

                property string selectedComponent: modelData[0]
                property var section: modelData

                sourceComponent: tabDelegate
            }
        }

        Loader {
            id: smallLoader
            anchors.fill: parent
            sourceComponent: tabDelegate

            property var section: []
            visible: active
            active: false
        }
    }

    Elements.Dialog {
        id: colorPicker
        title: "Pick color"

        positiveButtonText: "Done"

        Elements.MenuField {
            id: selection
            model: ["Primary color", "Accent color", "Background color"]
            width: Base.Units.dp(160)
        }

        Grid {
            columns: 7
            spacing: Base.Units.dp(8)

            Repeater {
                model: [
                    "red", "pink", "purple", "deepPurple", "indigo",
                    "blue", "lightBlue", "cyan", "teal", "green",
                    "lightGreen", "lime", "yellow", "amber", "orange",
                    "deepOrange", "grey", "blueGrey", "brown", "black",
                    "white"
                ]

                Rectangle {
                    width: Base.Units.dp(30)
                    height: Base.Units.dp(30)
                    radius: Base.Units.dp(2)
                    color: Base.Palette.colors[modelData]["500"]
                    border.width: modelData === "white" ? Base.Units.dp(2) : 0
                    border.color: Base.Theme.alpha("#000", 0.26)

                    Elements.Ink {
                        anchors.fill: parent

                        onPressed: {
                            switch(selection.selectedIndex) {
                                case 0:
                                    Base.theme.primaryColor = parent.color
                                    break;
                                case 1:
                                    Base.theme.accentColor = parent.color
                                    break;
                                case 2:
                                    Base.theme.backgroundColor = parent.color
                                    break;
                            }
                        }
                    }
                }
            }
        }

        onRejected: {
            // TODO set default colors again but we currently don't know what that is
        }
    }

    Component {
        id: tabDelegate

        Item {
            Elements.Sidebar {
                id: sidebar

                expanded: !navDrawer.enabled

                Column {
                    width: parent.width

                    Repeater {
                        model: section
                        delegate: Elements.Standard {
                            text: modelData
                            selected: modelData == selectedComponent
                            onClicked: selectedComponent = modelData
                        }
                    }
                }
            }
            Flickable {
                id: flickable
                anchors {
                    left: sidebar.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                clip: true
                contentHeight: Math.max(example.implicitHeight + 40, height)
                Loader {
                    id: example
                    anchors.fill: parent
                    asynchronous: true
                    visible: status == Loader.Ready
                    // selectedComponent will always be valid, as it defaults to the first component
                    source: {
                        if (navDrawer.enabled) {
                            return Qt.resolvedUrl("%1Demo.qml").arg(demo.selectedComponent.replace(" ", ""))
                        } else {
                            return Qt.resolvedUrl("%1Demo.qml").arg(selectedComponent.replace(" ", ""))
                        }
                    }
                }

                Elements.ProgressCircle {
                    anchors.centerIn: parent
                    visible: example.status == Loader.Loading
                }
            }
            Elements.Scrollbar {
                flickableItem: flickable
            }
        }
    }

}


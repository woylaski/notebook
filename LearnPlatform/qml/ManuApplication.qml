import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import ProjectManager 1.1
import "."

ApplicationWindow {
    id: application
    visible: true
    width: 800
    height: 600
    title: qsTr("Learn-Work-Create-") + Qt.application.version

    //visibility: settings.debugMode ? "FullScreen" : "Maximized"

    style: ApplicationWindowStyle {
        background: Rectangle {
            color: palette.background
        }
    }

    // Loading
    signal loaded()

    // Settings
    QtObject {
        id: settings

        // configurable
        property string font: "Ubuntu Mono"
        property int fontSize: 40
        property string palette: "Cute"
        property int indentSize: 4
        property bool debugging: true

        // internal
        property bool debugMode: false
        property double pixelDensity
        property string previousVersion: "0.0.0"
        property bool desktopPlatform: Qt.platform.os === "windows" ||
                                       Qt.platform.os === "linux" ||
                                       Qt.platform.os === "osx" ||
                                       Qt.platform.os === "unix"
    }

    ManuSettings {
        category: "Editor"
        property alias font: settings.font
        property alias fontSize: settings.fontSize
        property alias palette: settings.palette
        property alias indentSize: settings.indentSize
        property alias debugging: settings.debugging
    }

    ManuSettings {
        category: "Version"
        property alias previousVersion: settings.previousVersion
    }

    property alias settings: settings

    // Palettes
    ManuPaletteLoader {
        id: paletteLoader
        name: settings.palette
    }

    property alias palette: paletteLoader.palette

    // Message Handler
    QtObject {
        id: messageHandler
        objectName: "messageHandler"
        signal messageReceived(string message)
    }

    property alias messageHandler: messageHandler

    // Focus Management
    property Item focusItem: null
    signal backPressed()

    onActiveFocusItemChanged: {
        if (focusItem !== null && focusItem.Keys !== undefined)
            focusItem.Keys.onReleased.disconnect(onKeyReleased)

        if (activeFocusItem !== null)
        {
            activeFocusItem.Keys.onReleased.connect(onKeyReleased)
            focusItem = activeFocusItem
        }
    }

    function onKeyReleased(event) {
        if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
            if (Qt.inputMethod.visible)
                Qt.inputMethod.hide()
            else
                backPressed()

            event.accepted = true
        }
    }
}



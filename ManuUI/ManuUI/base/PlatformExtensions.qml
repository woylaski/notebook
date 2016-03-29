import QtQuick 2.5
import "qrc:/base/base" as Base

Object {
    id: platform

    property var platformExtensions

    property color decorationColor: Base.Theme.primaryDarkColor
    property var window: null
    readonly property real multiplier: platformExtensions ? platformExtensions.multiplier : 1

    onDecorationColorChanged: {
        if (platformExtensions && color != "#000000") {
            platformExtensions.decorationColor = decorationColor
        }
    }

    onWindowChanged: {
        if (platformExtensions) {
            platformExtensions.window = window
        }
    }

    Component.onCompleted: {
        try {
            var code = "import 'qrc:/base/base' as Base; Base.PlatformExtensions {}"
            platformExtensions = Qt.createQmlObject(code, platform, "ManuUI-base-Extensions");

            platformExtensions.window = window
            if (decorationColor != "#000000")
                platformExtensions.decorationColor = decorationColor

            print('create platformextension ok')
        } catch (error) {
            print(error)
            // Ignore the error; it only means that the Papyros
            // platform extensions are not available
        }
    }
}



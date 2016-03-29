import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import QtQuick.Window 2.2

import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/base/base/Promise.js" as Promise

Controls.ApplicationWindow {
    id: app
    visible: true
    width: Base.Units.dp(800)
    height: Base.Units.dp(600)

    property bool clientSideDecorations: false
    property alias initialPage: __pageStack.initialItem
    property alias pageStack: __pageStack
    property alias theme: __theme

    Base.AppTheme {
        id: __theme
    }

    /*
    Base.PlatformExtensions {
        id: platformExtensions
        //decorationColor: __toolbar.decorationColor
        window: app
    }
    */

    Elements.PageStack {
        id: __pageStack
        anchors {
            left: parent.left
            right: parent.right
            top: __toolbar.bottom
            bottom: parent.bottom
        }

        onPushed: {
            print("pagestack push a page")
            __toolbar.push(page)
        }

        onPopped: {
            print("pagestack pop a page")
            __toolbar.pop(page)
        }

        onReplaced: {
            print("pagestack replace a page")
            __toolbar.replace(page)
        }
    }

    Elements.Toolbar {
        id: __toolbar
        clientSideDecorations: app.clientSideDecorations
    }

    Elements.Dialog {
        id: errorDialog

        property var promise

        positiveButtonText: "Retry"

        onAccepted: {
            promise.resolve()
            promise = null
        }

        onRejected: {
            promise.reject()
            promise = null
        }
    }

    function showError(title, text, secondaryButtonText, retry) {
        if (errorDialog.promise) {
            errorDialog.promise.reject()
            errorDialog.promise = null
        }

        errorDialog.negativeButtonText = secondaryButtonText ? secondaryButtonText : "Close"
        errorDialog.positiveButton.visible = retry || false

        errorDialog.promise = new Promise.Promise()
        errorDialog.title = title
        errorDialog.text = text
        errorDialog.open()

        return errorDialog.promise
    }

    Component.onCompleted: {
        if (clientSideDecorations)
            flags |= Qt.FramelessWindowHint
        //flags |= Qt.FramelessWindowHint

        Base.Device.initDeviceSize(Screen.width, Screen.height,Screen.pixelDensity)
        print(Base.Units.printUintsInfo())

        // Nasty hack because singletons cannot import the module they were declared in, so
        // the grid unit cannot be defined in either Device or Units, because it requires both.
        Base.Units.gridUnit = Qt.binding(function() {
            if (Base.Device.type === Base.Device.phone || Base.Device.type === Base.Device.phablet) {
                return isPortrait ? Base.Units.dp(56) : Base.Units.dp(48)
            } else if (Base.Device.type == Base.Device.tablet) {
                return Base.Units.dp(64)
            } else {
                return Base.Device.hasTouchScreen ? Base.Units.dp(64) : Base.Units.dp(48)
            }
        })

        print(Base.Units.printUintsInfo())
    }
}


import QtQuick 2.3
import QtQuick.Window 2.1

Item {
    id: root
    width: 400
    height: propertyGrid.implicitHeight + 16

    function orientationToString(o) {
        switch (o) {
        case Qt.PrimaryOrientation:
            return "primary";
        case Qt.PortraitOrientation:
            return "portrait";
        case Qt.LandscapeOrientation:
            return "landscape";
        case Qt.InvertedPortraitOrientation:
            return "inverted portrait";
        case Qt.InvertedLandscapeOrientation:
            return "inverted landscape";
        }
        return "unknown";
    }

    Grid {
        id: propertyGrid
        columns: 2
        spacing: 8
        x: spacing
        y: spacing

        Text {
            text: "Screen \"" + Screen.name + "\":"
            font.bold: true
        }
        Item { width: 1; height: 1 } // spacer

        Text { text: "dimensions" }
        Text { text: Screen.width + "x" + Screen.height }

        Text { text: "pixel density" }
        Text { text: Screen.pixelDensity.toFixed(2) + " dots/mm (" + (Screen.pixelDensity * 25.4).toFixed(2) + " dots/inch)" }

        Text { text: "logical pixel density" }
        Text { text: Screen.logicalPixelDensity.toFixed(2) + " dots/mm (" + (Screen.logicalPixelDensity * 25.4).toFixed(2) + " dots/inch)" }

        Text { text: "device pixel ratio" }
        Text { text: Screen.devicePixelRatio.toFixed(2) }

        Text { text: "available virtual desktop" }
        Text { text: Screen.desktopAvailableWidth + "x" + Screen.desktopAvailableHeight }

        Text { text: "orientation" }
        Text { text: orientationToString(Screen.orientation) + " (" + Screen.orientation + ")" }

        Text { text: "primary orientation" }
        Text { text: orientationToString(Screen.primaryOrientation) + " (" + Screen.primaryOrientation + ")" }
    }
}

import QtQuick 2.0

Rectangle {
    id: line
    width: 2

    // Line gradient.
    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.rgba( line.color, 0.5 ) }
        GradientStop { position: 1.0; color:  Qt.rgba( line.color, 0.0 ) }
    }
}

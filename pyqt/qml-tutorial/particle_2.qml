import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {
    width: 450
    height: 300

    Image {
        id: car
        source: "graphical_car.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }

    DirectionalBlur {
        anchors.fill: car
        source: car
        angle: 90
        length: 30
        samples: 18
    }
}
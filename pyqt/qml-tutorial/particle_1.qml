import QtQuick 2.3
import QtQuick.Particles 2.0

Item {
    width: 450
    height: 300

    Image {
        source: "graphical_car.png"
    }

    Text {
        text: "Left click to start/stop"
        color: "white"
        font.pixelSize: 20
    }

    MouseArea {
        anchors.fill: parent
        onClicked: particles.running = !particles.running
    }

    ParticleSystem {
        id: particles
        running: false
    }

    ImageParticle {
        system: particles
        source: "star.png"
        alpha: 0.1
        colorVariation: 0.6
    }

    Emitter {
        width: 100
        height: parent.height
        anchors.right: parent.right
        system: particles
        emitRate: 10
        lifeSpan: 1000
        size: 30
        sizeVariation: 10
    }
}
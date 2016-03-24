import QtQuick 2.5
import "qrc:/elements/elements" as Elements
import QtGraphicalEffects 1.0

Item {
    id: item

    property alias source: image.source
    property alias status: image.status
    property alias averageColor: image.averageColor
    property alias sourceSize: image.sourceSize
    property alias asynchronous: image.asynchronous
    property alias cache: image.cache
    property alias fillMode: image.fillMode

    width: image.implicitWidth
    height: image.implicitHeight

    Elements.Image {
        id: image
        anchors.fill: parent
        smooth: true
        visible: false
        mipmap: true
    }

    Elements.Image {
        id: mask
        source: "qrc:/images/images/circle.png"
        //source: Qt.resolvedUrl("../../images/images/circle.png")
        anchors.fill: image
        smooth: true
        visible: false
        mipmap: true
    }

    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: mask
    }
}


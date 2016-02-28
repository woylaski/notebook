import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    function dpi(pixels) {
        return Math.round(pixels * Screen.pixelDensity * Screen.devicePixelRatio)
    }


    ListView {
        id: listView
        anchors.fill: parent
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.DragOverBounds
        orientation: ListView.Horizontal
        interactive: currentIndex === 1
        highlightMoveDuration: 150

        model: ComponentsListObjectModel {
            width: listView.width
            height: listView.height

            onIndexChanged: listView.currentIndex = index
        }
    }
}

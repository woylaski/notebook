import QtQuick 2.0;
import QtQuick.Window 2.0;

Window {
    id: window;
    width: 960;
    height: 540;
    visible: true;

    Rectangle {
        color: "#000000";
        anchors.fill: parent;
    }
    VideoGallery { }
}

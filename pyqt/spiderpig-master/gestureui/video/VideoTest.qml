import QtQuick 1.1
import QtMultimediaKit 1.1
Rectangle {

    width: 800
    height: 600

    Video {
        id: video
        anchors.centerIn: parent
        width : 400
        height : 300
        source: "test.mp4"

        property bool isNotPlaying: video.paused || !video.playing

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (video.isNotPlaying)
                    video.play();
                else
                    video.pause();
            }

        }

        focus: true
        Keys.onSpacePressed: video.paused = !video.paused
        Keys.onLeftPressed: video.position -= 5000
        Keys.onRightPressed: video.position += 5000
    }



    Rectangle {
        id: tintOverlay
        visible: video.isNotPlaying
        color: "#88ff0000"
        anchors.fill: video
        //color: Qt.tint("#cccccccc", "#10FF0000")
    }

}

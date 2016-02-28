import QtQuick 2.1;
import QtQuick.Window 2.1;
import QtQmlTricks 1.0;
import QtLyricsChords 1.0;

Window {
    title: qsTr ("Lyrics & Chords editor");
    color: "white";
    width: 1280;
    height: 800;
    visible: true;

    LyricsChordsEditor {
        width: (rotation % 180 ? parent.height : parent.width);
        height: (rotation % 180 ? parent.width : parent.height);
        rotation: (parent.width < parent.height ? 90 : 0);
        anchors.centerIn: parent;
    }
}

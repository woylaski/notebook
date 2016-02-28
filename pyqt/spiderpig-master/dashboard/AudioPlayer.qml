import QtQuick 1.1
import QtMultimediaKit 1.1

Item {

    function play(file) {
        player.source = file;
        player.play();
    }

    Audio {
        id: player
    }

}

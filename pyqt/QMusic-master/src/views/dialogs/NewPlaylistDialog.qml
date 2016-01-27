import QtQuick 2.3
import DMusic 1.0
import "../DMusicWidgets"

StandardDialog {
    id: mediaItem

    width: 300
    // height: 100

    centerItem: TextInput {
        id: playlistInputText
        anchors.centerIn: parent
        text: I18nWorker.newPlaylist + (PlaylistWorker.playlistNames.length + 1)
    }

    onEntered:{
        var name = playlistInputText.text;
        var names = PlaylistWorker.playlistNames;
        if (name in names){
        }else{
            SignalManager.addNewPlaylist(playlistInputText.text)
            SignalManager.dialogClosed();
        }
    }

    onClosed:{
        SignalManager.dialogClosed()
    }
}
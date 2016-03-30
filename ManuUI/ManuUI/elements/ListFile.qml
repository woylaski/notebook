import QtQuick 2.5
import Qt.labs.folderlistmodel 2.1

ListView {
    anchors.fill: parent
    property var folder: __folderModel
    //property alias folder: folderModel.folder
    //property alias filters: folderModel.nameFilters

    FolderListModel {
        id: __folderModel
        //showDirs : bool
        //showDirsFirst : bool
        //showDotAndDotDot : bool
        //showFiles : bool
        //showHidden : bool
        //showOnlyReadable : bool
        //sortField : enumeration
        //folder : string
        //rootFolder : url
        //parentFolder : url
        //nameFilters: ["*.qml"]
    }

    Component {
        id: fileDelegate
        Text { text: fileName }
    }

    model: folderModel
    delegate: fileDelegate
}


import QtQuick 2.5

Loader {
    id: dialogLoader

    visible: status === Loader.Loading || status === Loader.Ready

    property var parameters
    property var callback

    property alias types: dialogTypes

    QtObject {
        id: dialogTypes

        property string message: "MessageDialog.qml"
        property string confirmation: "ConfirmationDialog.qml"
        property string list: "ListDialog.qml"
        property string fontFamily: "FontFamilyDialog.qml"
        property string fontSize: "FontSizeDialog.qml"
        property string indentSize: "IndentSizeDialog.qml"
        property string newFile: "NewFileDialog.qml"
        property string newProject: "NewProjectDialog.qml"
    }

    function open(type, parameters, callback) {
        dialogLoader.parameters = parameters
        dialogLoader.callback = callback
        dialogLoader.source = type
    }

    function close() {
        source = ""
    }

    onLoaded:
        item.initialize(parameters)

    Connections {
        target: item

        onProcess: {
            dialogLoader.source = ""
            dialogLoader.callback(value)
        }

        onClose: {
            dialogLoader.source = ""
        }
    }
}

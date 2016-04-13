import QtQuick 2.2
import QtQuick.Dialogs 1.0

ColorDialog {
    id: colorDialog
    title: "Please choose a color"
    onAccepted: {
        console.log("You chose: " + colorDialog.color)
        //Qt.quit()
    }
    onRejected: {
        console.log("Canceled")
        //Qt.quit()
    }
    Component.onCompleted: visible = true
}


import QtQuick 1.1

Rectangle {

    width: 800
    height: 600
    //color: keyboard.color

    Keyboard2 {
        id: keyboard
        anchors.centerIn: parent
    }

    Row {
        id: testRow
        anchors.top: keyboard.bottom
        anchors.horizontalCenter: keyboard.horizontalCenter
        anchors.margins: 20
        spacing: 10
        visible: false

        GuiButton {
            text: "Read"
            onClicked: readModel()
        }

        GuiButton {
            text: "Reposition"
            onClicked: repositionTest()
        }

        GuiButton {
            text: "Insert"
            onClicked: insertLetter()
        }

        GuiButton {
            text: "Edit button"
            onClicked: insertEditor()
        }

    }

    ButtonEditor {
        id: editor
        anchors.top: testRow.bottom
        anchors.margins: 10
        anchors.horizontalCenter: parent.horizontalCenter
        buttonElement: keyboard.model.get(0).buttons.get(0);
    }

    function insertEditor() {
        editor.buttonElement = keyboard.model.get(1).buttons.get(1);

        console.log(editor.buttonElement.label);
        editor.buttonElement.label = "X";
    }

    function readModel() {
        for (var i=0; i<keyboard.model.count; i++) {
            var row = keyboard.model.get(i);
            console.log(row.name);
            for (var b=0; b<row.buttons.count; b++) {
                var button = row.buttons.get(b);
                console.log(button.label, button.altLabel);
            }
        }
    }

    function repositionTest() {
        keyboard.model.get(0).buttons.move(5, 0, 2);
    }

    function insertLetter() {
        var btn = {"label": "N", "altLabel": ""};
        keyboard.model.get(2).buttons.append(btn);
    }
}

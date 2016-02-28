import QtQuick 1.1

Rectangle {

    id: editor

    property QtObject buttonElement;

    width: 300
    height: 100
    color: "#eee"

    Row {
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: label
            text: "Button label:"
        }

        TextInput {
            id: input

            maximumLength: 2
            height: 30
            width: 30
            font.pixelSize: 20
            onTextChanged: buttonElement.label = text
        }
    }

    Component.onCompleted: {
        input.text = buttonElement.label;
    }
}


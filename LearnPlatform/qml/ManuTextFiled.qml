import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import "."

TextField {
    id: xField
    Layout.alignment: Qt.AlignVCenter
    Layout.preferredWidth: 0.25 * parent.width
    horizontalAlignment: TextInput.AlignLeft

    //maximumLength : 6//限制字数
    //echoMode : TextInput.Password

    //floatingLabel: true
    //placeholderText: qsTr("X")
    placeholderText: xField.activeFocus ? "" : qsTr("INPUT")
    validator: IntValidator {}

    style: TextFieldStyle {
        //font: poppinsFont.name
        placeholderTextColor: "white"
        textColor: "white"
        selectionColor: "#e9cb00"
        selectedTextColor: "black"
        background: Rectangle {
            id: background
            anchors.fill: parent
            color: "#33ffffff"
            radius: 28
            border.width: 1
            border.color: xField.activeFocus ? "#e9cb00" : "white"
       }
    }

    function getValue() {
        if (text == "")
            return 0;
        else
            return Number(text)
    }
}


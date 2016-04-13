import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import "."

TextField {
    width: Size.scale (192)
    height: Size.scale (24)
    //font.family: q_global.font
    opacity: enabled ? 1 : 0.5
    font.pixelSize: Size.getSize ("medium")

    style: Component {
        id: textFieldStyle

        TextFieldStyle {
            textColor: "#222"
            placeholderTextColor: "#888"

            background: Rectangle {
                color: "#fff"
                border.color: "#268"
                radius: Size.scale (5)
                border.width: Size.scale (1)
                Behavior on border.color {ColorAnimation{}}
            }
        }
    }

    Behavior on opacity { NumberAnimation{} }
}



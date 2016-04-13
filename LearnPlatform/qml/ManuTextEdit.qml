import QtQuick 2.0
import QtQuick.Controls.Styles 1.0
import "."

TextEdit {
    //--------------------------------------------------------------------------
    // Custom Properties
    //--------------------------------------------------------------------------

    property string fontSize: "medium"

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    color: "#222"
    selectedTextColor: "#fff"
    opacity: enabled ? 1 : 0.5
    //font.family: q_global.font
    textFormat: Text.PlainText
    font.pixelSize: Size.getSize (fontSize)
    selectionColor: enabled ? "#286" : "#888"
    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere

    //--------------------------------------------------------------------------
    // Objects
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    // Behaviors
    //--------------------------------------------------------------------------

    Behavior on color { ColorAnimation{} }
    Behavior on opacity { NumberAnimation{} }
    Behavior on selectionColor { ColorAnimation{} }

    onOpacityChanged: {
        focus = opacity > 0
        enabled = opacity > 0
    }
}


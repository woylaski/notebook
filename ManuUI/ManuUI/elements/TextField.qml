import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls
import "qrc:/base/base" as Base
import "qrc:/style/style" as Style

Controls.TextField {
    property color color: Base.Theme.accentColor
    property color errorColor: Base.Palette.colors["red"]["500"]
    property string helperText
    property bool floatingLabel: false
    property bool hasError: characterLimit && length > characterLimit
    property int characterLimit
    property bool showBorder: true

    style: Style.TextFieldStyle {}
}


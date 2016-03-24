import QtQuick 2.5
import "."

//palette:调色板
QtObject {
    id: palette

    property bool light

    readonly property color textColor: light ? shade(0.7) : shade(1)
    readonly property color subTextColor: light ? shade(0.54) : shade(0.70)
    readonly property color iconColor: light ? subTextColor : textColor
    readonly property color hintColor: light ? shade(0.26) : shade(0.30)
    readonly property color dividerColor: shade(0.12)

    /*!
       A version of the accent color specifically for lighter or darker backgrounds. This is
       normally the same as the global \l Theme::accentColor, but for some application's color
       schemes, the accent color is too dark or too light  and a lighter/darker version is needed
       for some surfaces. This can be customized via the \l ApplicationWindow::theme group property.
       According to the Material Design guidelines, this should taken from a second color palette
       that complements the primary color palette at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color accentColor: Theme.accentColor
    //property color accentColor: theme.accentColor

    function shade(alpha) {
        if (light) {
            return Qt.rgba(0,0,0,alpha)
        } else {
            return Qt.rgba(1,1,1,alpha)
        }
    }
}



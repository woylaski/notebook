import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import "qrc:/base/base" as Base
import "qrc:/style/style" as Style

Controls.Button {
    id: button

    /*!
       The background color of the button. By default, this is white for a raised
       button and transparent for a flat button.
     */
    property color backgroundColor: elevation > 0 ? "white" : "transparent"

    /*!
       \internal

       The context of the button, which is used to control special styling of
       buttons in dialogs or snackbars.
     */
    property string context: "default" // or "dialog" or "snackbar"

    /*!
       Set to \c true if the button has a dark background color
     */
    property bool darkButton: Base.Theme.isDarkColor(backgroundColor)

    /*!
       Set to \c true if the button is on a dark background
     */
    property bool darkBackground

    /*!
       The elevation of the button. Normally either \c 0 or \c 1.
     */
    property int elevation

    /*!
       The text color of the button. By default, this is calculated based on the background color,
       but it can be customized to the theme's primary color or another color.
     */
    property color textColor: button.darkButton ? Base.Theme.dark.textColor : Base.Theme.light.textColor

    style: Style.ButtonStyle {}
}



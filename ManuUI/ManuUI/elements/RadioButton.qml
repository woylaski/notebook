import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import "qrc:/base/base" as Base
import "qrc:/style/style" as Style

Controls.RadioButton {
    id: radioButton

    /*!
       The switch color. By default this is the app's accent color
     */
    property color color: darkBackground ? Base.Theme.dark.accentColor
                                         : Base.Theme.light.accentColor

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    /*!
       Set to \c true if the radio button can be toggled from checked to unchecked
     */
    property bool canToggle

    style: Style.RadioButtonStyle {}

    Ink {
        id: inkArea
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: Base.Units.dp(4)
        }

        width: Base.Units.dp(40)
        height: Base.Units.dp(40)
        color: radioButton.checked ? Base.Theme.alpha(radioButton.color, 0.20) : Qt.rgba(0,0,0,0.1)

        onClicked: {
            if(radioButton.canToggle || !radioButton.checked)
                radioButton.checked = !radioButton.checked
            radioButton.clicked()
        }

        circular: true
        centered: true
    }

    MouseArea {
        anchors {
            left: inkArea.right
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        onClicked: {
            if(radioButton.canToggle || !radioButton.checked)
                radioButton.checked = !radioButton.checked
            radioButton.clicked()
        }
    }
}



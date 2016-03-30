import QtQuick 2.5
import QtQuick.Controls.Styles 1.4
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

RadioButtonStyle {
    id: style

    spacing: 0

    property color color: control.hasOwnProperty("color")
            ? control.color : Base.Theme.light.accentColor

    property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

    label: Elements.Label {
        text: control.text
        style: "button"
        color: control.enabled ? style.darkBackground ? Base.Theme.dark.textColor
                                                        : Base.Theme.light.textColor
                               : style.darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                                        : Base.Theme.alpha("#000", 0.26)
    }

    background: Rectangle {
        color: "transparent"
    }

    indicator: Rectangle {
        implicitWidth: Base.Units.dp(48)
        implicitHeight: Base.Units.dp(48)
        radius: implicitHeight / 2
        color: control.activeFocus ? Base.Theme.alpha(control.color, 0.20) : "transparent"

        Rectangle {
            anchors.centerIn: parent

            implicitWidth: Base.Units.dp(20)
            implicitHeight: Base.Units.dp(20)
            radius: implicitHeight / 2
            color: "transparent"

            border.color: control.enabled
                ? control.checked ? style.color
                                  : style.darkBackground ? Base.Theme.alpha("#fff", 0.70)
                                                         : Base.Theme.alpha("#000", 0.54)
                : style.darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                       : Base.Theme.alpha("#000", 0.26)

            border.width: Base.Units.dp(2)
            antialiasing: true

            Behavior on border.color {
                ColorAnimation { duration: 200}
            }

            Rectangle {
                anchors {
                    centerIn: parent
                    alignWhenCentered: false
                }
                implicitWidth: control.checked ? Base.Units.dp(10) : 0
                implicitHeight: control.checked ? Base.Units.dp(10) : 0
                color: control.enabled ? style.color
                                       : style.darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                                              : Base.Theme.alpha("#000", 0.26)
                radius: implicitHeight / 2
                antialiasing: true

                Behavior on implicitWidth {
                    NumberAnimation { duration: 200 }
                }

                Behavior on implicitHeight {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }
}



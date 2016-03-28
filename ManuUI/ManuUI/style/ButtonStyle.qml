import QtQuick 2.5
import QtQuick.Controls.Styles 1.4
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

ButtonStyle {
    id: style

    padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
    }

    property bool darkBackground: control.hasOwnProperty("darkBackground")
                ? control.darkBackground : Base.Theme.isDarkColor(controlBackground)

    property int controlElevation: control.hasOwnProperty("elevation") ? control.elevation : 1

    property color controlBackground: control.hasOwnProperty("backgroundColor")
            ? control.backgroundColor : controlElevation == 0 ? "transparent" : "white"

    property string context: control.hasOwnProperty("context") ? control.context : "default"

    background: Elements.View {
        id: background

        implicitHeight: Base.Units.dp(36)

        radius: Base.Units.dp(2)

        backgroundColor: control.enabled || controlElevation === 0
                ? controlBackground
                : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                 : Qt.rgba(0, 0, 0, 0.12)

        elevation: {
            var elevation = controlElevation

            if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                elevation++;

            if(!control.enabled)
                elevation = 0;

            return elevation;
        }

        tintColor: mouseArea.currentCircle || control.focus || control.hovered
           ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1
                            : elevation > 0 ? 0.03
                            : 0.05)
           : "transparent"

        Elements.Ink {
            id: mouseArea

            anchors.fill: parent
            focused: control.focus && background.context !== "dialog"
                    && background.context !== "snackbar"
            focusWidth: parent.width - Base.Units.dp(30)
            focusColor: Qt.darker(background.backgroundColor, 1.05)

            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }
    }
    label: Item {
        implicitHeight: Math.max(Base.Units.dp(36), label.height + Base.Units.dp(16))
        implicitWidth: context == "dialog"
                ? Math.max(Base.Units.dp(64), label.width + Base.Units.dp(16))
                : context == "snackbar" ? label.width + Base.Units.dp(16)
                                        : Math.max(Base.Units.dp(88), label.width + Base.Units.dp(32))

        Elements.Label {
            id: label
            anchors.centerIn: parent
            text: control.text
            style: "button"
            color: control.enabled ? control.hasOwnProperty("textColor")
                                     ? control.textColor : darkBackground ? Base.Theme.dark.textColor
                                                                          : Base.Theme.light.textColor
                    : control.darkBackground ? Qt.rgba(1, 1, 1, 0.30)
                                             : Qt.rgba(0, 0, 0, 0.26)
        }
    }
}


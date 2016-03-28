import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls.Styles 1.4 as ControlStyles

import "qrc:/base/base" as Base

Controls.Switch {
    id: control

    property color color: darkBackground ? Base.Theme.dark.accentColor
                                         : Base.Theme.light.accentColor

    property bool darkBackground

    style: ControlStyles.SwitchStyle {
        handle: View {
            width: Base.Units.dp(22)
            height: Base.Units.dp(22)
            radius: height / 2
            elevation: 2
            backgroundColor: control.enabled ? control.checked ? control.color
                                                               : darkBackground ? "#BDBDBD"
                                                                                : "#FAFAFA"
                                             : darkBackground ? "#424242"
                                                              : "#BDBDBD"
        }

        groove: Item {
            width: Base.Units.dp(40)
            height: Base.Units.dp(22)

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - Base.Units.dp(2)
                height: Base.Units.dp(16)
                radius: height / 2
                color: control.enabled ? control.checked ? Base.Theme.alpha(control.color, 0.5)
                                                         : darkBackground ? Qt.rgba(1, 1, 1, 0.26)
                                                                          : Qt.rgba(0, 0, 0, 0.26)
                                       : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                                        : Qt.rgba(0, 0, 0, 0.12)

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

}


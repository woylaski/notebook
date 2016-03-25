import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

////control means the object that style control for
CheckBoxStyle {
    id: style

    property color color: control.hasOwnProperty("color")
            ? control.color : Base.Theme.light.accentColor

    property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

    spacing: 0

    label: Item {
        implicitWidth: control.text !== "" ? text.implicitWidth + 2 : 0
        implicitHeight: text.implicitHeight

        baselineOffset: text.baselineOffset

        Elements.Label {
            id: text

            anchors.centerIn: parent

            property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

            style: "button"
            color: control.enabled ? darkBackground ? Base.Theme.dark.textColor
                                                    : Base.Theme.light.textColor
                                   : darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                                    : Base.Theme.alpha("#000", 0.26)
            text: control.text
        }
    }

    indicator: Item {
        id: parentRect

        implicitWidth: Base.Units.dp(48)
        implicitHeight: implicitWidth

        Rectangle {
            id: indicatorRect

            anchors.centerIn: parent

            property color __internalColor: control.enabled
                    ? style.color
                    : style.darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                           : Base.Theme.alpha("#000", 0.26)

            width: Base.Units.dp(18)
            height: width
            radius: Base.Units.dp(2)

            border.width: Base.Units.dp(2)

            border.color: control.enabled
                    ? control.checked ? style.color
                                      : style.darkBackground ? Base.Theme.alpha("#fff", 0.70)
                                                             : Base.Theme.alpha("#000", 0.54)
                    : style.darkBackground ? Base.Theme.alpha("#fff", 0.30)
                                           : Base.Theme.alpha("#000", 0.26)

            color: control.checked ? __internalColor : "transparent"

            Behavior on color {
                ColorAnimation {
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }

            Behavior on border.color {
                ColorAnimation {
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }

            Item {
                id: container

                anchors.centerIn: indicatorRect

                height: parent.height
                width: parent.width

                opacity: control.checked ? 1 : 0

                property int thickness: Base.Units.dp(3)

                Behavior on opacity {
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }

                Rectangle {
                    id: vert

                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }

                    radius: Base.Units.dp(1)
                    color: style.darkBackground ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                    width: container.thickness * 2

                }
                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }

                    radius: Base.Units.dp(1)
                    color: style.darkBackground ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                    height: container.thickness
                }

                transform: [
                    Scale {
                        origin { x: container.width / 2; y: container.height / 2 }
                        xScale: 0.5
                        yScale: 1
                    },
                    Rotation {
                        origin { x: container.width / 2; y: container.height / 2 }
                        angle: 45;
                    },
                    Scale {
                        id: widthScale

                        origin { x: container.width / 2; y: container.height / 2 }
                        xScale: control.checked ? 0.6 : 0.2
                        yScale: control.checked ? 0.6 : 0.2

                        Behavior on xScale {
                            NumberAnimation {
                                easing.type: Easing.InOutQuad
                                duration: 200
                            }
                        }

                        Behavior on yScale {
                            NumberAnimation {
                                easing.type: Easing.InOutQuad
                                duration: 200
                            }
                        }
                    },
                    Translate { y: -(container.height - (container.height * 0.9)) }
                ]
            }
        }
    }
}


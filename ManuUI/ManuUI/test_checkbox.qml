import QtQuick 2.5
import QtQuick.Layouts 1.3
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

//Layout Provides attached properties for items pushed onto a GridLayout, RowLayout or ColumnLayout.
ColumnLayout {
    spacing: 0

    Repeater {
        model: 2

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: grid.height + Base.Units.dp(80)
            Layout.minimumWidth: grid.width + Base.Units.dp(80)
            color: index == 0 ? "#EEE" : "#333"

            GridLayout {
                id: grid
                anchors.centerIn: parent
                columns: 3

                // Empty filler
                Item { width: 1; height: 1 }

                Label {
                    Layout.alignment : Qt.AlignHCenter
                    text: "Normal"
                    color: index == 0 ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                }

                Label {
                    Layout.alignment : Qt.AlignHCenter
                    text: "Disabled"
                    color: index == 0 ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                }

                Label {
                    text: "On"
                    color: index == 0 ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                }

                Elements.CheckBox {
                    checked: true
                    text: "On"
                    darkBackground: index == 1
                }

                Elements.CheckBox {
                    checked: true
                    enabled: false
                    text: "Disabled"
                    darkBackground: index == 1
                }

                Label {
                    text: "Off"
                    color: index == 0 ? Base.Theme.light.textColor : Base.Theme.dark.textColor
                }

                Elements.CheckBox {
                    text: "Off"
                    darkBackground: index == 1
                }

                Elements.CheckBox {
                    text: "Disabled"
                    enabled: false
                    darkBackground: index == 1
                }
            }
        }
    }
}



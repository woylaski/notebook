import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/style/style" as Style

Controls.CheckBox {
    id: checkBox
    property color color: darkBackground ? Base.Theme.dark.accentColor : Base.Theme.light.accentColor
    property bool darkBackground

    style: Style.CheckBoxStyle {}

    Ink {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: Base.Units.dp(4)
        }

        width: Base.Units.dp(40)
        height: Base.Units.dp(40)
        color: checkBox.checked ? Base.Theme.alpha(checkBox.color, 0.20)
                                : checkBox.darkBackground ? Qt.rgba(1,1,1,0.1)
                                                          : Qt.rgba(0,0,0,0.1)
        enabled: checkBox.enabled

        circular: true
        centered: true

        onClicked: {
          checkBox.checked = !checkBox.checked
          checkBox.clicked()
        }
    }
}


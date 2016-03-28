import QtQuick 2.5
import "qrc:/base/base" as Base

View {
    width: Base.Units.dp(300)
    height: Base.Units.dp(250)
    elevation: flat ? 0 : 1

    property bool flat: false

    border.color: flat ? Qt.rgba(0,0,0,0.2) : "transparent"
    radius: fullWidth || fullHeight ? 0 : Base.Units.dp(2)

}


import QtQuick 2.5
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

Item {
    id: divider

    anchors {
        left: parent.left
        right: parent.right
    }

    height: Base.Units.dp(16)

    ThinDivider {
        anchors.verticalCenter: parent.verticalCenter
    }
}


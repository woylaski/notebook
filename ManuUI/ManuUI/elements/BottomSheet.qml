import QtQuick 2.5
import "qrc:/base/base" as Base

PopupBase {
    id: bottomSheet

    property int maxHeight: parent.height * 0.6
    default property alias content: containerView.data

    overlayLayer: "dialogOverlayLayer"
    //ColorOverlay,在源 Item 上覆盖一层颜色 Colorize,设置源 Item 的 HSL 颜色空间
    overlayColor: Qt.rgba(0, 0, 0, 0.2)
    height: Math.min(maxHeight, implicitHeight)
    implicitHeight: containerView.childrenRect.height
    width: parent.width

    visible: percentOpen > 0

    property real percentOpen: showing ? 1 : 0

    Behavior on percentOpen {
        NumberAnimation {
            duration: 200
            easing {
                 type: Easing.OutCubic
            }
        }
    }

    anchors {
        bottom: parent.bottom
        bottomMargin: (bottomSheet.percentOpen - 1) * height
    }

    View {
        id:containerView
        anchors.fill: parent
        elevation: 2
        backgroundColor: "#fff"
    }
}


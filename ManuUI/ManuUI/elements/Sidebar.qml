import QtQuick 2.5
import "qrc:/base/base" as Base

View {
    id: root

    backgroundColor: style === "default" ? "white" : "#333"

    anchors {
        left: mode === "left" ? parent.left : undefined
        right: mode === "right" ? parent.right : undefined
        top: parent.top
        bottom: parent.bottom
        leftMargin: expanded ? 0 : -width
        rightMargin: expanded ? 0 : -width
    }

    width: Base.Units.dp(250)

    property bool expanded: true

    property string mode: "left" // or "right"
    property alias header: headerItem.text

    property color borderColor: style === "dark" ? Qt.rgba(0.5,0.5,0.5,0.5) : Base.Theme.light.dividerColor

    property bool autoFlick: true

    default property alias contents: contents.data

    Behavior on anchors.leftMargin {
        NumberAnimation { duration: 200 }
    }

    Behavior on anchors.rightMargin {
        NumberAnimation { duration: 200 }
    }

    Rectangle {
        color: borderColor
        width: 1

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: mode === "left" ? parent.right : undefined
            left: mode === "right" ? parent.left : undefined
            //rightMargin: -1
        }
    }

    Item {
        clip: true

        anchors {
            fill: parent
            rightMargin: mode === "left" ? 1 : 0
            leftMargin: mode === "right" ? 1 : 0
        }

        Subheader {
            id: headerItem

            visible: text !== ""
            backgroundColor: root.backgroundColor
            elevation: flickable.atYBeginning ? 0 : 1
            fullWidth: true
            z: 2
        }

        Flickable {
            id: flickable

            clip: true

            anchors {
                top: headerItem.visible ? headerItem.bottom : parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            contentWidth: width
            contentHeight: autoFlick ? contents.height : height
            interactive: contentHeight > height

            Item {
                id: contents

                width: flickable.width
                height: autoFlick ? childrenRect.height : flickable.height
            }

            function getFlickableChild(item) {
                if (item && item.hasOwnProperty("children")) {
                    for (var i=0; i < item.children.length; i++) {
                        var child = item.children[i];
                        if (internal.isVerticalFlickable(child)) {
                            if (child.anchors.top === page.top || child.anchors.fill === page) {
                                return item.children[i];
                            }
                        }
                    }
                }
                return null;
            }
        }

        Scrollbar {
            flickableItem: flickable
        }
    }
}



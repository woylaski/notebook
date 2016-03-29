import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import QtQuick.Layouts 1.1
import "qrc:/base/base" as Base

View {
    id: toolbar

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    property int actionBarHeight: {
        if (!page || page.actionBar.hidden)
            return 0

        var height = implicitHeight + page.actionBar.extendedHeight

        if (page.rightSidebar && page.rightSidebar.showing) {
            var sidebarHeight = implicitHeight + page.rightSidebar.actionBar.extendedHeight

            height = Math.max(height, sidebarHeight)
        }

        return height
    }
    property int targetHeight: actionBarHeight
    property int maxActionCount: Base.Device.type === Base.Device.desktop
                                 ? 5 : Base.Device.type === Base.Device.tablet ? 4 : 3
    property bool clientSideDecorations: false
    property string color: "white"
    property var page
    property bool showBackButton

    property color decorationColor: page && page.actionBar
            ? page.actionBar.decorationColor
            : Base.Theme.primaryDarkColor

    opacity: page && page.actionBar.hidden ? 0 : 1

    backgroundColor: page ? page.actionBar.backgroundColor.a === 0
                            ? page.backgroundColor : page.actionBar.backgroundColor
                          : Base.Theme.primaryColor

    implicitHeight: Base.Units.gu(1)
    height: targetHeight
    elevation: backgroundColor === page.color ? 0 : page.actionBar.elevation
    fullWidth: true
    clipContent: true

    Behavior on decorationColor {
        ColorAnimation { duration: Base.MaterialAnimation.pageTransitionDuration }
    }

    Behavior on height {
        NumberAnimation { duration: Base.MaterialAnimation.pageTransitionDuration }
    }

    Behavior on opacity {
        NumberAnimation { duration: Base.MaterialAnimation.pageTransitionDuration }
    }

    function pop(page) {
        stack.pop(page.actionBar)

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.pop(page.rightSidebar.actionBar)
        else
            rightSidebarStack.pop(emptyRightSidebar)

        toolbar.page = page
    }

    function push(page) {
        stack.push(page.actionBar)

        page.actionBar.toolbar = toolbar
        toolbar.page = page

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.push(page.rightSidebar.actionBar)
        else
            rightSidebarStack.push(emptyRightSidebar)
    }

    function replace(page) {
        page.actionBar.maxActionCount = Qt.binding(function() { return toolbar.maxActionCount })
        toolbar.page = page

        stack.replace(page.actionBar)

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.replace(page.rightSidebar.actionBar)
        else
            rightSidebarStack.replace(emptyRightSidebar)
    }

    Rectangle {
        anchors.fill: rightSidebarStack

        color: page.rightSidebar && page.rightSidebar.actionBar.backgroundColor
               ? Qt.darker(page.rightSidebar.actionBar.backgroundColor,1).a === 0
                 ? page.rightSidebar.color
                 : page.rightSidebar.actionBar.backgroundColor
               : Base.Theme.primaryColor
    }

    Controls.StackView {
        id: stack
        height: actionBarHeight

        Behavior on height {
            NumberAnimation { duration: Base.MaterialAnimation.pageTransitionDuration }
        }

        anchors {
            left: parent.left
            right: page && page.rightSidebar
                   ? rightSidebarStack.left
                   : clientSideDecorations ? windowControls.left : parent.right
            rightMargin: 0
        }

        delegate: toolbarDelegate
    }

    Controls.StackView {
        id: rightSidebarStack
        height: actionBarHeight
        width: page && page.rightSidebar
               ? page.rightSidebar.width
               : 0

        Behavior on height {
            NumberAnimation { duration: Base.MaterialAnimation.pageTransitionDuration }
        }

        anchors {
            right: clientSideDecorations ? windowControls.left : parent.right
            rightMargin: page.rightSidebar ? page.rightSidebar.anchors.rightMargin : 0
        }

        delegate: toolbarDelegate
    }

    Controls.StackViewDelegate {
        id: toolbarDelegate

        pushTransition: Controls.StackViewTransition {
            SequentialAnimation {
                id: actionBarShowAnimation

                ParallelAnimation {
                    NumberAnimation {
                        duration: Base.MaterialAnimation.pageTransitionDuration
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                    }

                    NumberAnimation {
                        duration: Base.MaterialAnimation.pageTransitionDuration
                        target: enterItem
                        property: "y"
                        from: enterItem.height
                        to: 0
                    }
                }
            }
            SequentialAnimation {
                id: previousHideAnimation

                ParallelAnimation {

                    NumberAnimation {
                        duration: Base.MaterialAnimation.pageTransitionDuration
                        target: exitItem
                        property: "opacity"
                        to: 0
                    }

                    NumberAnimation {
                        duration: Base.MaterialAnimation.pageTransitionDuration
                        target: exitItem
                        property: "y"
                        to: exitItem ? -exitItem.height : 0
                    }
                }
            }
        }
    }

    Row {
        id: windowControls

        visible: clientSideDecorations

        anchors {
            verticalCenter: stack.verticalCenter
            right: parent.right
            rightMargin: Base.Units.dp(16)
        }

        spacing: Base.Units.dp(24)

        IconButton {
            iconName: "navigation/close"
            color: Base.Theme.lightDark(toolbar.backgroundColor, Base.Theme.light.textColor,
                Base.Theme.dark.textColor)
            onClicked: Qt.quit()
        }
    }

    Component {
        id: emptyRightSidebar

        Item {}
    }
}


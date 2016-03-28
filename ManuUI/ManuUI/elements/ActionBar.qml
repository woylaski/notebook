import QtQuick 2.5
import QtQuick.Layouts 1.1
import "qrc:/base/base" as Base
import "qrc:/base/base/ListUtils.js" as ListUtils

Item {
    id: actionBar

    implicitHeight: Base.Units.gu(1)

    anchors {
        left: parent.left
        right: parent.right
    }

    property list<Action> actions
    property Action backAction

    property color decorationColor: Base.Theme.primaryDarkColor
    property color backgroundColor: Base.Theme.primaryColor

    property alias customContent: customContentView.data
    property alias extendedContent: extendedContentView.data

    property int elevation: 2
    readonly property int extendedHeight: extendedContentView.height +
            (tabBar.visible && !integratedTabBar ? tabBar.height : 0)

    property bool hidden: false

    property int iconSize: Base.Units.gridUnit == Base.Units.dp(48) ? Base.Units.dp(20) : Base.Units.dp(24)

    property bool integratedTabBar: false

    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    property alias selectedTabIndex: tabBar.selectedIndex
    property alias tabBar: tabBar

    property alias tabs: tabBar.tabs

    property string title

    property Item toolbar

    property int leftKeyline: label.x
    readonly property alias overflowMenuShowing: overflowMenu.showing
    readonly property bool overflowMenuAvailable: __internal.visibleActions.length > maxActionCount

    function openOverflowMenu() {
        if (overflowMenuAvailable && !overflowMenuShowing)
            overflowMenu.open(overflowButton, Base.Units.dp(4), Base.Units.dp(-4));
    }

    function closeOverflowMenu() {
        if (overflowMenuAvailable && overflowMenuShowing)
            overflowMenu.close();
    }

    QtObject {
        id: __internal

        property var visibleActions: ListUtils.filter(actions, function(action) {
            return action.visible
        })
    }

    IconButton {
        id: leftItem

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? Base.Units.dp(16) : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: Base.Theme.lightDark(actionBar.backgroundColor, Base.Theme.light.iconColor,
                                                            Base.Theme.dark.iconColor)
        size: iconSize
        action: backAction

        opacity: show ? enabled ? 1 : 0.6 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        property bool show: backAction && backAction.visible
    }

    Label {
        id: label

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            right: actionsRow.left
            leftMargin: Base.Units.dp(16) + (leftItem.show ? Base.Units.gu(1) : 0)
            rightMargin: Base.Units.dp(16)

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        visible: customContentView.children.length === 0 &&
                (!integratedTabBar || !tabBar.visible)

        textFormat: Text.PlainText
        text: actionBar.title
        style: "title"
        color: Base.Theme.lightDark(actionBar.backgroundColor, Base.Theme.light.textColor,
                                                            Base.Theme.dark.textColor)
        elide: Text.ElideRight
    }

    Row {
        id: actionsRow

        anchors {
            right: parent.right
            rightMargin: Base.Units.dp(16)
        }

        height: parent.implicitHeight

        spacing: Base.Units.dp(24)

        Repeater {
            model: __internal.visibleActions.length > maxActionCount
                    ? maxActionCount - 1
                    : __internal.visibleActions.length

            delegate: IconButton {
                id: iconAction

                objectName: "action/" + action.objectName

                action: __internal.visibleActions[index]

                color: Base.Theme.lightDark(actionBar.backgroundColor, Base.Theme.light.iconColor,
                                                                  Base.Theme.dark.iconColor)
                size: iconSize

                anchors.verticalCenter: parent ? parent.verticalCenter : undefined
            }
        }

        IconButton {
            id: overflowButton

            iconName: "navigation/more_vert"
            objectName: "action/overflow"
            size: Base.Units.dp(27)
            color: Base.Theme.lightDark(actionBar.backgroundColor, Base.Theme.light.iconColor,
                                                              Base.Theme.dark.iconColor)
            visible: actionBar.overflowMenuAvailable
            anchors.verticalCenter: parent.verticalCenter

            onClicked: openOverflowMenu()
        }
    }

    Item {
        id: customContentView

        height: parent.height

        anchors {
            left: label.left
            right: label.right
        }
    }

    Item {
        id: extendedContentView
        anchors {
            top: actionsRow.bottom
            left: label.left
            right: parent.right
            rightMargin: Base.Units.dp(16)
        }

        height: childrenRect.height
    }

    TabBar {
        id: tabBar

        darkBackground: Base.Theme.isDarkColor(actionBar.backgroundColor)
        leftKeyline: actionBar.leftKeyline
        height: integratedTabBar ? parent.implicitHeight : implicitHeight

        anchors {
            top: integratedTabBar ? undefined : extendedContentView.bottom
            bottom: integratedTabBar ? actionsRow.bottom : undefined
            left: parent.left
            right: integratedTabBar ? actionsRow.left : parent.right
        }
    }

    Dropdown {
        id: overflowMenu
        objectName: "overflowMenu"

        width: Base.Units.dp(250)
        height: columnView.height + Base.Units.dp(16)

        ColumnLayout {
            id: columnView
            width: parent.width
            anchors.centerIn: parent

            Repeater {
                model: __internal.visibleActions.length - (maxActionCount - 1)

                Standard {
                    id: listItem

                    objectName: "action/" + action.objectName

                    property Action action: __internal.visibleActions[index + maxActionCount - 1]

                    text: action.name
                    iconSource: action.iconSource
                    enabled: action.enabled

                    onClicked: {
                        action.triggered(listItem)
                        overflowMenu.close()
                    }
                }
            }
        }
    }
}


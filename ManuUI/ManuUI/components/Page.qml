import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls

import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements

FocusScope {
    id: page
    property alias actionBar: __actionBar
    property list<Base.Action> actions

    property Base.Action backAction: Base.Action {
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: page.pop()
        visible: canGoBack
    }

    property color backgroundColor: Theme.backgroundColor
    property bool canGoBack: false
    default property alias data: content.data
    property Item rightSidebar
    property alias selectedTabIndex: __actionBar.selectedTabIndex
    property alias tabBar: __actionBar.tabBar
    property alias tabs: __actionBar.tabs
    property string title
    signal goBack(var event)

    function pop(event, force) {
        if (Controls.Stack.view.currentItem !== page)
            return false

        if (!event)
            event = {accepted: false}

        if (!force)
            goBack(event)

        if (event.accepted) {
            return true
        } else {
            return Controls.Stack.view.pop()
        }
    }

    function forcePop() {
        pop(null, true)
    }

    function push(component, properties) {
        return Controls.Stack.view.push({item: component, properties: properties});
    }

    onRightSidebarChanged: {
        if (rightSidebar)
            rightSidebar.mode = "right"
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            // When the Android back button is tapped
            if (__actionBar.overflowMenuShowing) {
                // Close the action bar overflow menu if it's open
                __actionBar.closeOverflowMenu();
                event.accepted = true;
            } else {
                // Or pop the page from the page stack
                if (pop()) {
                    event.accepted = true;
                }
            }
        } else if (event.key === Qt.Key_Menu) {
            // Display or hide the action bar overflow menu when the Android menu button is tapped
            if (__actionBar.overflowMenuAvailable) {
                if (__actionBar.overflowMenuShowing) {
                    __actionBar.closeOverflowMenu();
                } else {
                    __actionBar.openOverflowMenu();
                }
                event.accepted = true;
            }
        }
    }

    ActionBar {
        id: __actionBar

        title: page.title
        backAction: page.backAction
        actions: page.actions
    }

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    Item {
        id: content

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: rightSidebarContent.left
        }
    }

    Item {
        id: rightSidebarContent

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        children: [rightSidebar]

        width: rightSidebar
               ? rightSidebar.width + rightSidebar.anchors.rightMargin
               : 0
    }
}


import QtQuick 2.5

// Set properties here that all ListViews used within Phoenix will set anyway.

ListView {
    id: listView;
    clip: true;
    boundsBehavior: Flickable.StopAtBounds;
    activeFocusOnTab: true;

    // A silly workaround needed because apparently currentItem.y isn't up-to-date when it needs to be?
    property real currentItemOffset: 0;

    property bool growOnFocus: true;
    property real growOnFocusValue: growOnFocus ? 12 : 4;

    signal doShowAnimation();
    onCurrentIndexChanged: {
        currentItemOffset = orientation === ListView.Vertical ? currentItem.y : currentItem.x;
        listView.doShowAnimation();
    }

    highlightFollowsCurrentItem: false;
    property color highlighterColor: "lightgreen";

    highlight: Rectangle {
        id: highlighter;
        width:  orientation === ListView.Vertical   ? ( listView.activeFocus ? growOnFocusValue : 4 ) : listView.currentItem.width;
        height: orientation === ListView.Horizontal ? ( listView.activeFocus ? growOnFocusValue : 4 ) : listView.currentItem.height;
        color: highlighterColor;

        Behavior on width { PropertyAnimation { duration: 200; } }
        Behavior on height { PropertyAnimation { duration: 200; } }

        anchors.left: orientation === ListView.Vertical ? parent.left : undefined;
        anchors.bottom: orientation === ListView.Horizontal ? parent.bottom : undefined;

        Connections {
            target: listView;
            onDoShowAnimation: {
                showAnimation.complete();
                showAnimation.start();
            }
            onActiveFocusChanged:
                showAnimation.complete();
        }

        SequentialAnimation {
            id: showAnimation;
            PropertyAction { target: highlighter; property: orientation === ListView.Vertical ? "y" : "x"; value: listView.currentItemOffset; }
            PropertyAnimation {
                target: highlighter;
                property: orientation === ListView.Vertical ? "width" : "height";
                from: 1;
                to: listView.activeFocus ? growOnFocusValue : 4;
                duration: 300;
                easing.type: Easing.InOutQuart;
            }
        }
    }
}

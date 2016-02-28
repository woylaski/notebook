import QtQuick 2.0

Rectangle {
    id: groove;
    color: "#DCDBCB";
    visible: (flicker.visibleArea.heightRatio < 1.0);
    width: 5;
    clip: true;
    anchors {
        top: flicker.top;
        right: flicker.right;
        bottom: flicker.bottom;
    }

    property Flickable flicker : null;

    Rectangle {
        id: handle;
        height: (groove.height * flicker.visibleArea.heightRatio);
        color: "#999999";
        anchors {
            left: parent.left;
            right: parent.right;
        }

        Binding { // Calculate handle's x/y position based on the content position of the Flickable
            target: handle;
            property: "y";
            value: (flicker.visibleArea.yPosition * groove.height);
            when: (!dragger.drag.active);
        }
        Binding { // Calculate Flickable content position based on the handle x/y position
            target: flicker;
            property: "contentY";
            value: (handle.y / groove.height * flicker.contentHeight);
            when: (dragger.drag.active);
        }
        MouseArea {
            id: dragger;
            anchors.fill: parent;
            drag {
                target: handle;
                minimumX: handle.x;
                maximumX: handle.x;
                minimumY: 0;
                maximumY: (groove.height - handle.height);
                axis: Drag.YAxis;
            }
        }
    }
}

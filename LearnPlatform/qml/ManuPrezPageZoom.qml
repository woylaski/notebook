import QtQuick 2.0

ManuPrezPageTransition {
    id: transitionFromSide;

    property int side: 0;
    readonly property int right       : 0;
    readonly property int bottomRight : 1;
    readonly property int bottom      : 2;
    readonly property int bottomLeft  : 3;
    readonly property int left        : 4;
    readonly property int topLeft     : 5;
    readonly property int top         : 6;
    readonly property int topRight    : 7;
    readonly property int center      : 8;

    Component.onCompleted: {
        previousPage.z = 1;
        nextPage.scale = 0.1;
        console.debug(side);
        if      ([topRight, right, bottomRight].indexOf(side) !== -1) { nextPage.anchors.right = container.right;console.debug("anchors right") }
        else if ([topLeft, left, bottomLeft].indexOf(side) !== -1)    { nextPage.anchors.left = container.left;console.debug("anchors left") }
        else                                                          { nextPage.anchors.horizontalCenter = container.horizontalCenter; console.debug("anchors horizontal")}

        if      ([bottomLeft, bottom, bottomRight].indexOf(side) !== -1) { nextPage.anchors.bottom = container.bottom;console.debug("anchors bottom")  }
        else if ([topLeft, top, topRight].indexOf(side) !== -1)          { nextPage.anchors.top = container.top;console.debug("anchors top")  }
        else                                                             { nextPage.anchors.verticalCenter = container.verticalCenter; console.debug("anchors vertical") }

        nextPage.visible = true;
        nextPage.z = 1000;
        start ();
    }

    PropertyAnimation {
        target: transitionFromSide.nextPage;
        properties: "scale";
        to: 1;
        duration: transitionFromSide.duration;
    }

    ScriptAction {
        script: {
            nextPage.anchors.right = undefined;
            nextPage.anchors.left = undefined;
            nextPage.anchors.top = undefined;
            nextPage.anchors.bottom = undefined;
            nextPage.anchors.verticalCenter = undefined;
            nextPage.anchors.horizontalCenter = undefined;
            nextPage.x = 0;
            nextPage.y = 0;
            previousPage.visible = false;
        }
    }
}


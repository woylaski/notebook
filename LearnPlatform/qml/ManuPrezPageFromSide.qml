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

    Component.onCompleted: {
        previousPage.z = 1;
        if      ([topRight, right, bottomRight].indexOf(side) !== -1) { nextPage.x = container.width; }
        else if ([topLeft, left, bottomLeft].indexOf(side) !== -1)    { nextPage.x = -container.width; }
        else                                                          { nextPage.x = 0; }

        if      ([bottomLeft, bottom, bottomRight].indexOf(side) !== -1) { nextPage.y = container.height; }
        else if ([topLeft, top, topRight].indexOf(side) !== -1)          { nextPage.y = -container.height; }
        else                                                             { nextPage.y = 0; }

        nextPage.visible = true;
        nextPage.z = 1000;
        start ();
    }

    PropertyAnimation {
        target: transitionFromSide.nextPage;
        properties: "x,y";
        to: 0;
        duration: transitionFromSide.duration;
    }

    ScriptAction {
        script: {
            previousPage.visible = false;
        }
    }
}

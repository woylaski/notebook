import QtQuick 2.0

SequentialAnimation {
    id: transition;
    loops: 1;
    running: false;
    alwaysRunToEnd: true;
    onStopped: { destroy (); }

    property Item previousPage : null;
    property Item nextPage : null;
    property Item container : null;
    property int duration: 500;
}

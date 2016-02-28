import QtQuick 1.0

Item {

    property int currentlyPressedKeyId

    signal moveHorizontal(int direction, int speed)
    signal moveVertical(int direction, int speed)
    signal zoom(int direction, int speed)
    signal pressed()
    signal hold()

    anchors.fill: parent
    focus: true

    Keys.onPressed: {
        var LEFT = -1;
        var RIGHT = -LEFT;
        var UP = LEFT;
        var DOWN = -UP;
        var IN = 1;
        var OUT = -IN;
        var speed = 1;

        if (event.key == Qt.Key_Left) {
            moveHorizontal(LEFT, speed);
        }
        else if (event.key == Qt.Key_Right) {
            moveHorizontal(RIGHT, speed);
        }
        else if (event.key == Qt.Key_Up) {
            moveVertical(UP, speed);
        }
        else if (event.key == Qt.Key_Down) {
            moveVertical(DOWN, speed);
        }
        else if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
            pressed();
        }
        else if (event.key == Qt.Key_Z) {
            zoom(IN, speed);
        }
        else if (event.key == Qt.Key_X) {
            zoom(OUT, speed);
        }
        else if (event.key == Qt.Key_Escape) {
            hold();
        }

        event.accepted = true;
    }
 }

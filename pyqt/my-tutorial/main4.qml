import QtQuick 2.0

Rectangle {
    id: page
    width: 500; height: 200
    color: "lightgray"

    function updateRotater() {
        rotater.angle += 45
    }

    Rectangle {
        id: rotater
        property real angle : 0
        x: 240; y: 95
        width: 100; height: 5
        color: "black"

        transform: Rotation {
            origin.x: 10; origin.y: 5
            angle: rotater.angle
        }
    }
}
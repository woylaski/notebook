import QtQuick 2.2

Rectangle {
    id: root
    visible: true
    width: 100; height: 400;

    Repeater{
        model: [0, 1, 2, 3]
        Rectangle {
            //x: index*100
            y: index*100
            width: 100; height: 100;
            color: index % 2 == 0 ? "blue" : "green"

            Text {
                anchors.centerIn: parent
                text: index
            }
        }
    }
}
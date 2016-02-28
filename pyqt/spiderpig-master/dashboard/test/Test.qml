import QtQuick 1.1

Rectangle {

    width:400
    height: 400

    Listable {
        Rectangle {width: 200; height: 200; color: "green"; anchors.centerIn: parent}
        Rectangle {width: 150; height: 150; color: "blue"; anchors.centerIn: parent}
        Rectangle {width: 100; height: 100; color: "pink"; anchors.centerIn: parent}
    }

}

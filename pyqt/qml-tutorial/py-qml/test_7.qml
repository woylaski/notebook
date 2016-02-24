import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle {
    id: root
    property string textData: "hello world";
    width: 100; height: 30

    Text {
        anchors.fill: parent;
        text: root.textData;
    }
}
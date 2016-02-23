import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
	id: root
	width: 640
	height: 480
	visible: true

	MouseArea {
        id: mouseArea
        anchors.fill: parent
	}

    Text {
        anchors.centerIn: parent
        text: qsTr("Hello World")
    }
}
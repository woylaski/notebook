import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

ApplicationWindow{
	id: root
	width: 640;height:480;
	visible: true
	title: qsTr("gridview")

	Rectangle {
		id: rec
		width: 240
		height: 300
		color: "green"
		anchors.centerIn: parent

        GridView {
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 100
            cellWidth: 45
            cellHeight: 45
            delegate: numberDelegate
        }

        Component {
            id: numberDelegate
            Rectangle {
                width: 40
                height: 40
                color: "lightGreen"
                Text {
                    anchors.centerIn: parent
                    font.pixelSize: 10
                    text: index
                }
            }
        }
	}
}
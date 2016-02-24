import QtQuick 2.0

Rectangle{
	id: root
	width: 640;height:480;
	color: "lightgreen"
	signal sendClicked(string str)

	Text{
		id: txt
		text: "click me"
		anchors.fill: parent
		font.pixelSize: 20
	}

	MouseArea{
		id: mouse_area
		anchors.fill: parent
		onClicked:{
			root.sendClicked("hello python3")
		}
	}
}

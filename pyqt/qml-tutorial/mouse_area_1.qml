import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle{
	id: root
	width: 640
	height: 480
	visible: true

    property color buttonColor: "lightblue"
    property color onHoverColor: "gold"
    property color borderColor: "white"
    property int count: 0

	Text{
		id: buttonLabel
		width: parent.width
		height: parent.width/2

		anchors {bottom: parent.bottom}
		//anchors.centerIn: parent
		text: "show text area"
	}

    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent //在矩形区域内描定Mouse Area的所有边
        //onClicked处理按钮点击事件
        onClicked: {
        	console.log(buttonLabel.text + " clicked" )
        	count = count + 1
        	buttonLabel.text = "hello world, click count:" + count
        }
    }
}
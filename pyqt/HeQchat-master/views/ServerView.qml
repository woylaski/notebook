import QtQuick 2.1

import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0

ColumnLayout {
	property var mainWindowTitle: tabModel.server.currentNickname + " @ " + tabModel.server.network.name

	anchors.fill: parent

	ListView {
		model: tabModel.messages

		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: inputTextField.top

		delegate: MessageLabel {
			messageModel: model
		}
	}

	TextField {
		id: inputTextField

		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
	}
}

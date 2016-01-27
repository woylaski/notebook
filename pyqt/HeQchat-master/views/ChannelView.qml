import QtQuick 2.1

import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0

RowLayout {
	property var mainWindowTitle: tabModel.channel.server.currentNickname + " @ " + tabModel.channel.server.network.name + " / " + tabModel.channel.name

	anchors.fill: parent

	ColumnLayout {
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: rightColumn.left

		TextField {
			id: topicTextField
			text: tabModel.channel.topic

			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: parent.top
		}

		ListView {
			model: tabModel.messages

			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: topicTextField.bottom
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

	ColumnLayout {
		id: rightColumn

		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right

		Label {
			id: numUsersLabel
			text: tabModel.numOps + " ops, " + tabModel.channel.users.count + " total"

			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: parent.top
		}

		ListView {
			model: tabModel.channel.users

			delegate: Label {
				text: model.symbol + model.nickname

				Menu {
					id: menu

					Menu {
						title: model.nickname

						MenuItem {
							text: "Real name: " + model.realname
						}

						MenuItem {
							text: "User name: " + model.username + "@" + model.hostname
						}
					}
				}

				MouseArea {
					anchors.fill: parent

					acceptedButtons: Qt.RightButton

					onClicked: {
						menu.popup()
					}
				}
			}

			orientation: Qt.Vertical

			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: numUsersLabel.bottom
			anchors.bottom: lagMeterLabel.top
		}

		Label {
			id: lagMeterLabel
			text: tabModel.channel.server.lag + "s"

			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: parent.bottom
		}
	}
}

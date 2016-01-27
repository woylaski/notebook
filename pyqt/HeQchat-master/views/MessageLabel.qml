import QtQuick 2.1

import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0

import "text-events.js" as TextEvents

Label {
	property var messageModel

	text: TextEvents.display(messageModel)

	textFormat: Text.RichText
}

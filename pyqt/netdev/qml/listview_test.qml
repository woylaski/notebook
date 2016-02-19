import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

import "./"

Rectangle {
	id: root
	width:640; height:480;

    ListView {
      id: dataView
      height: contentHeight
      anchors.fill: parent
      spacing: 2
      model: DataBank{}
      delegate: MultiDelegate{}
    }
}
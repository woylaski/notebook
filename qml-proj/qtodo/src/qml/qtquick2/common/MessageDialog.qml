/*
 *  Copyright 2011 Ruediger Gad
 *
 *  This file is part of Q To-Do.
 *
 *  Q To-Do is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Q To-Do is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Q To-Do.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0

CommonDialog {
    id: messageDialog

    property alias title: titleText.text
    property alias message: message.text

    Item {
      anchors.fill: parent
        Text {
            id: titleText
            anchors.top: parent.top
            anchors.margins: primaryFontSize
            width: parent.width
            color: "white"
            font.pointSize: primaryFontSize
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Text {
            id: message

            anchors.top: titleText.bottom
            anchors.topMargin: primaryBorderSize

            width: parent.width
            color: "white"
            font.pointSize: primaryFontSize * 0.75
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }
    }
}

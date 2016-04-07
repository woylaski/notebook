/*
 *  Copyright 2012, 2013 Ruediger Gad
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

Rectangle {
    id: textField

    property int echoMode: TextInput.Normal
    property alias pointSize: textInput.font.pointSize
    property alias text: textInput.text

    border.width: primaryBorderSize / 8
    border.color: textInput.focus ? primaryColorSchemeColor : tertiaryColorSchemeColor
    color: enabled ? primaryBackgroundColor : secondaryBackgroundColor
    height: textInput.height * 1.5
    smooth: true

    TextInput {
        id: textInput

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        echoMode: textField.echoMode
        color: "black"
        focus: textField.focus
        font.pointSize: primaryFontSize * 0.75
        width: parent.width - primaryBorderSize

        onFocusChanged: {
            if (focus) {
                Qt.inputMethod.show()
            } else {
                Qt.inputMethod.hide()
            }
        }
    }

}

/****************************************************************************
**
** The MIT License (MIT)
**
** Copyright (c) 2014 Ricardo do Valle Flores de Oliveira
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
** SOFTWARE.
**
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

import "qrc:/FontAwesome" 4.5

Window {
    visible: true
    width: 1024
    height: 768

    ColumnLayout {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Source code version " + Qt.application.version
        }

        Text { text: "FontAwesome label demonstration:" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 15
            font.family: FontAwesome.family
            text: FontAwesome.fa_money
        }

        Text { text: "FontAwesomeModel model character selection demonstration:" }
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: faSelector.implicitHeight
            Layout.rightMargin: 15
            GridView {
                id: faSelector
                Layout.fillWidth:  true
                Layout.fillHeight:  true
                cellWidth: 64; cellHeight: 64
                focus: true
                clip: true
                model: FontAwesomeModel
                delegate: Text {
                    id: faText
                    font.pixelSize: 45
                    font.family: FontAwesome.family
                    text: character
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: faSelector.currentIndex = index
                        onDoubleClicked: faSelectedCharacter.text = character
                    }
                }
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            }
            Text {
                id: faSelectedCharacter
                font.pointSize: 128
                font.family: FontAwesome.family
                text: FontAwesome.fa_bluetooth
                horizontalAlignment: Qt.AlignHCenter
            }
        }

        Text { text: "FontAwesomeModel demonstration:" }
        GridView {
            Layout.fillHeight:  true
            Layout.fillWidth: true

            cellWidth: 250
            cellHeight: 25
            focus: true

            model: FontAwesomeModel
            delegate: Item {
                Row {
                    Text { text: name + " " }
                    Text { font.family: FontAwesome.family; text: character }
                }
            }
        }
    }
}

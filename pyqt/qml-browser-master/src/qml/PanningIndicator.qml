/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.0
import org.hildon.components 1.0

Item {
    id: root

    property bool panningOn: false

    signal clicked

    width: 64
    height: 64
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
    }

    Rectangle {
        x: -10
        width: 74
        height: 64
        color: "black"
        opacity: 0.5
        radius: 10
        smooth: true
    }

    Image {
        id: icon

        width: 64
        height: 64
        anchors.centerIn: parent
        source: "image://icon/browser_panning_mode_" + (root.panningOn ? "on" : "off")
        smooth: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

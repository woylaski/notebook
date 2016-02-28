/*
    This file is part of Quick Qanava library.

    Copyright (C) 2008-2015 Benoit AUTHEMAN

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//-----------------------------------------------------------------------------
// This file is a part of the Quickmenubar software. copyright 2015 benoit autheman.
//
// \file	QmbMenuLayout.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import "./"

/*! \brief Used internally to lay out QmbMenu, should be considered private.
 *
 * Might be usefull if you are looking for a ColumnLayout that could also be a RowLayout, ie either
 * vertical or horizontal.
 */
Item {
    id: layout

    x: 0
    y: 0
    z: 1
    transformOrigin: Item.TopLeft

    property int orientation: Qt.Vertical
    property var spacing: 0

    onOrientationChanged : { onChildrenChanged() }  // Relayout when orientation changes

    onChildrenChanged: {
        var itemX = spacing
        var itemY = spacing
        var layoutHeight = spacing
        var layoutWidth = spacing

        // Force children orientation setting
        for ( var i = 0; i < layout.children.length; i++ )
            layout.children[ i ].orientation = orientation

        var maxWidth = -1
        for ( var i = 0; i < layout.children.length; i++ )
            maxWidth = Math.max( maxWidth, layout.children[ i ].Layout.preferredWidth )

        // Laying out horizontally or vertically, centering children according to max width and max height
        if ( orientation === Qt.Vertical )
        {
            for ( var i = 0; i < layout.children.length; i++ )
            {
                var childrenPrefWidth = layout.children[ i ].Layout.preferredWidth
                var childrenPrefHeight = layout.children[ i ].Layout.preferredHeight
                layout.children[ i ].x = itemX + ( ( maxWidth - childrenPrefWidth ) / 2 )
                layout.children[ i ].y = itemY
                layout.children[ i ].width = childrenPrefWidth
                layout.children[ i ].height = childrenPrefHeight
                itemY += childrenPrefHeight + spacing

                layoutWidth = Math.max( layoutWidth, childrenPrefWidth )
                layoutHeight = itemY
            }
        }
        else if ( orientation === Qt.Horizontal )
        {
            for ( var i = 0; i < layout.children.length; i++ )
            {
                var childrenPrefWidth = layout.children[ i ].Layout.preferredWidth
                var childrenPrefHeight = layout.children[ i ].Layout.preferredHeight
                layout.children[ i ].x = itemX
                layout.children[ i ].y = itemY  // No y centering with horizontal layout
                layout.children[ i ].width = childrenPrefWidth
                layout.children[ i ].height = childrenPrefHeight
                itemX += childrenPrefWidth + spacing

                layoutWidth = itemX
                layoutHeight = Math.max( layoutHeight, childrenPrefHeight )
            }
        }

        implicitHeight = layoutHeight + spacing
        height = implicitHeight

        implicitWidth = layoutWidth + spacing
        width = implicitWidth
    }

    function    relayout( ) { onChildrenChanged( ) }

    Component.onCompleted: {
        onChildrenChanged()
    }
}


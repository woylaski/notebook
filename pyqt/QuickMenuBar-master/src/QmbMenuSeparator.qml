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
// \file	QmbMenuSeparator.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.1

/*! \brief Main QuickMenuBar component used to built and define a menu bar.
 *
 * Add a visual separation line between menu item QmbMenuItem components in a QmbMenubar or QmbMenu menu.
 *
 * Should only be specified as a QmbMenuBar or QmbMenu child.
 *
 * QmbMenuSeparator should be configured trought QmbMenuBar.style property, the following options are
 * available:
 * \li QmbMenuStyle.separatorColor: color of the separator line.
 * \li QmbMenuStyle.separatorWidth: width of the separator line.
 *
 * \code
 *   QmbMenuBar {
 *     style.separatorWidth: "red"  // Optional configuration
 *     style.separatorColor: 2.     // Optional configuration
 *     // ...
 *     QmbMenuItem {
 *       // ...
 *     }
 *     QmbMenuSeparator { }
 *     QmbMenuItem {
 *       // ...
 *     }
 *   }
 * \endcode
 *
 * \note do not change the default \c objectName property.
 */
Item {
    id: menuSeparator
    objectName: "QmbMenuSeparator"    // Do not change separator object name...

    // Menu bar style sheet (initialized by QmbMenuBar)
    property QmbMenuStyle style : parent.style
    property int orientation: Qt.Vertical   // Will be sets in QmbMenuLayout

    // Parent width and height could be unitialized during initialization, take style preferredSize as default width/height
    Layout.preferredWidth: parent.orientation === Qt.Vertical ? ( Math.max( parent.width, style.elementPreferredSize ) - 6 ): 3
    Layout.preferredHeight: parent.orientation === Qt.Vertical ? 3 : ( Math.max( parent.height, style.elementPreferredSize ) - 6 )

    opacity: 0.7

    Canvas {
        id: separatorCanvas
        anchors.fill: parent
        onPaint: {
            var context = getContext( "2d" )

            context.beginPath( )
            context.lineWidth = style.separatorWidth
            context.strokeStyle = style.separatorColor

            if ( parent.orientation === Qt.Horizontal ) {
                context.moveTo( width - 1.5, 3 )
                context.lineTo( width - 1.5, height - 3 )
            }
            else {
                context.moveTo( 3, 1.5 )
                context.lineTo( menuSeparator.width - 3, 1.5 )
            }
            context.stroke( )
        }
    } // Canvas: separatorCanvas
}

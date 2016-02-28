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
// \file	QmbMenuStyle.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2

/*! \brief Define styling options available to user for QmbMenuBar component.
 *
 * A QmbMenu component could be style using QmbMenuStyle by setting properties directly in the default \c style
 * property of QmbMenuBar:
 * \code
 *  QmbMenuBar {
 *      style.elementPreferredSize: 64
 * }
 * \endcode
 *
 * You could also define a custom QmbMenuStyle component and affect it to the \c QmbMenuBar.style property.
 *
 * \sa QmbMenuBar style property \c QmbMenuBar.style
 */
QtObject {
    /*! \brief When set to true, QuickMenuBar will output debug information to console, use the resulting log for filling bugreports
     *
     * Default to false. */
    property bool   debug: false;
    /*! \brief The menu will be visible and fully expanded at startup.
     *
     * Default to true.*/
    property bool   expandedAtStartup : true
    /*! \brief Menu will be always visible and will not release when the user leave the menu area.
     *
     * Default to false.*/
    property bool   stayVisible : false
    /*! \brief Define the global menu opacity.
     *
     * Default to 1.0.*/
    property real   menuOpacity : 1.0
    /*! \brief Define the color used for all textual elements (mainly QmbMenuItem labels).
     *
     * Default to #232323 (almost black) */
    property color  textColor : "#232323"
    /*! \brief Define if the menu item and text should have shadow.
     *
     * Default to true */
    property bool   showShadows : true

    /*! \brief Define the margin between a menu and its sub menu
     *
     * For vertical menu, a sub menu will be shown with the specified margin across its parent menu).
     *
     * Example:
     * \image html 20150726_quickmenubar-subMenuMargin.png
     * Default to 5. */
    property int    subMenuMargin: 5

    /*! \brief Define the preffered size for menu items.
     *
     * Used as a width and height paramter for menu QmbMenuItem components.
     * Example:
     * \image html 20150729_quickmenubar-preferredSize.png
     * Default to 64 */
    property double elementPreferredSize: 64
    /*! \brief Define the color used to hilighted the current menu item.
     *
     * Default to #4f4ae1 (shade of blue)*/
    property color  elementHilightGradColor : "#4f4ae1"
    /*! \brief Define the color used to hilight when a menu item is in checked state.
     *
     * Default to #4f4ae1 (shade of violet)*/
    property color  elementCheckedGradColor : "#f971ee"
    /*! \brief Define the color used to hilighted the current menu item when it is in checked state.
     *
     * Usually it is a color lighter than elementCheckedGradColor.
     * Default to #4f4ae1 (shade of violet lighter thant elementCheckedGradColor)*/
    property color  elementHilightCheckedGradColor : "#ff50f1"

    /*! \brief Define the color for the QmbSeparator components where this style apply.
     *
     * Default to black.*/
    property color  separatorColor : "black"
    /*! \brief Define the line width for QmbSeparator components where this style apply.
     *
     * Default to 1.0 */
    property real   separatorWidth : 1.

    property QtObject menu : QtObject {
        property QtObject border : QtObject {
            property int width: 2
            property color color: "transparent"
            property int radius: 0
        }

        property Gradient gradient : Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }
}


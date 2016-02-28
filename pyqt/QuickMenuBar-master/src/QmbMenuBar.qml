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
// \file	QmbMenuBar.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.1

/*! \brief Main QuickMenuBar component used to built and define a menu bar.
 *
 * QmbMenuBar is the main QuickMenuBar "container" component where menu items (ie "elements") should be
 * specified as children QmbMenuItem components. The only two children supported actually are QmbMenuItem and
 * QmbMenuSeparator. Sub menus should be defined only into QmbMenuItem, with QmbMenu components.
 *
 * QmbMenuBar position could be set with its \c 'x' and \c 'y' properties, but \c anchors or \c Layout
 * options are managed automatically by QuickMenuBar to adapt menu content size. Do not try to resize the menu bar
 * manually, instead use the QmbMenuStyle.elementPreferredSize property to select menu item width and height.
 *
 * Set the \c state property (QmbMenuBar.state) to expand or release the menu:
 * \image html	20150928_quickmenubar-ACTIVATED-RELEASED.png
 *
 * \code
 *   QmbMenuBar {
 *     // x and y could be set manually, don't use anchors or Layout with QmbMenuBar, it will be
 *     // sized automatically according to content
 *
 *     // Configure style options
 *     style.elementPreferredSize: 64
 *     //style.whatEverOption: xx
 *
 *     // Add either QmbMenuItem or QmbMenuSeparator
 *     QmbMenuItem {
 *       // ...
 *     }
 *     QmbMenuSeparator {
 *       // ...
 *     }
 *     QmbMenuItem {
 *       // ...
 *     }
 *   }
 * \endcode
 */
Item {
    id: menuBar
    objectName: "QmbMenuBar"    // Do not modify objectName...
    anchors.fill: parent

    opacity: style.menuOpacity
    visible: true
    transformOrigin: Item.TopLeft
    implicitWidth: mainMenu.implicitWidth
    implicitHeight: mainMenu.implicitHeight

    // Public properties //----------------------------------------------------
    QmbMenuStyle { id: menuBarStyle }
    //! \brief Menu bar styling options available to user.
    property alias style: menuBarStyle

    /*! \brief Define the current menu bar state, it could be either "ENVELOPPED", "RELEASED" or "ACTIVATED", see QmbMenu \c state property documentation.
     *
     * \image html	20150928_quickmenubar-ACTIVATED-RELEASED.png
     *
     * Default to "ENVELOPPED", use QmbMenuStyle \c stayVisible or \c expandedAtStartup properties to modify the default behaviour.
     *
     * \sa QmbMenuStyle \c QmbMenuStyle.stayVisible and QmbMenuStyle.expandedAtStartup properties.
     * \sa QmbMenu \c QmbMenu.state property.*/
    property alias state : mainMenu.state

    // Private properties //---------------------------------------------------
    default property alias children : mainMenu.children

    /*! \brief Used internally, do not modify or use.
     * \private */
    property bool stayVisible: style.stayVisible
    onStayVisibleChanged: {
        var s = ( stayVisible ? "ACTIVATED" : "ENVELOPED" )
        if ( state !== s )
            state = s
    }

    QmbMenu{
        id : mainMenu
        x : 0.; y : 0.
        visible: true
        root: true
        state: "ENVELOPED"
        style : menuBarStyle
        Component.onCompleted: { mainMenu.state = style.expandedAtStartup ? "ACTIVATED" : "ENVELOPED" }
    }
}

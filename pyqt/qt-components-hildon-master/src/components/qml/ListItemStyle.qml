/*
 * Copyright (C) 2016 Stuart Howarth <showarth@marxoft.co.uk>
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

/*!
    \class ListItemStyle
    \brief Provides styling properties for a ListItem.
    
    \ingroup components
    
    \sa ListItem, OssoListItemStyle
*/
Style {
    // Background
    
    /*!
        \brief The url for the background image.
    */
    property url background: "image://theme/TouchListBackgroundNormal"
    
    /*!
        \brief The url for the background image used when the ListItem is pressed.
    */
    property url backgroundPressed: "image://theme/TouchListBackgroundPressed"
    
    /*!
        \brief The url for the background image used when the ListItem is selected.
    */
    property url backgroundSelected: "image://theme/TouchListBackgroundPressed"
    
    /*!
        \brief The right margin for the background image, in pixels.
    */
    property int backgroundMarginRight: 4
    
    /*!
        \brief The left margin for the background image, in pixels.
    */
    property int backgroundMarginLeft: 4
    
    /*!
        \brief The top margin for the background image, in pixels.
    */
    property int backgroundMarginTop: 4
    
    /*!
        \brief The bottom margin for the background image, in pixels.
    */
    property int backgroundMarginBottom: 4
    
    // Dimensions
    
    /*!
        \brief The default height for the ListItem.
    */
    property int itemHeight: 70
}

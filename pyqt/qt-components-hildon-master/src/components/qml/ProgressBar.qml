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
    \class ProgressBar
    \brief A component for displaying the progress of a process.
    
    \ingroup components
    
    \sa ProgressBarStyle, Slider
*/
Item {
    id: root
    
    /*!
        \brief The minimum value of the progress bar.
        
        The default value is \c 0.
    */
    property int minimum: 0
    
    /*!
        \brief The maximum value of the progress bar.
        
        The default value is \c 100.
    */
    property int maximum: 100
    
    /*!
        \brief The current value of the progress bar.
        
        The default value is 0.
    */
    property int value
    
    /*!
        \brief The text to be displayed in the progress bar.
        
        The default value is an empty string.
    */
    property string text
    
    /*!
        \brief Whether the text should be visible in the progress bar.
        
        The default value is \c false.
    */
    property bool textVisible: false
    
    /*!
        type:ProgressBarStyle
        \brief Provides styling properties for the progress bar.        
    */
    property QtObject style: ProgressBarStyle {}
    
    width: style.progressBarWidth
    height: style.progressBarHeight
    
    BorderImage {
        id: background
        
        anchors.fill: parent
        border {
            left: root.style.backgroundMarginLeft
            right: root.style.backgroundMarginRight
            top: root.style.backgroundMarginTop
            bottom: root.style.backgroundMarginBottom
        }
        smooth: true
        source: root.style.background
    }
    
    BorderImage {
        id: bar
        
        width: root.value > 0 ? Math.floor((parent.width * root.value) / (root.maximum - root.minimum))
               - (root.style.barPaddingLeft + root.style.barPaddingRight) : 0
        anchors {
            left: parent.left
            leftMargin: root.style.barPaddingLeft
            top: parent.top
            topMargin: root.style.barPaddingTop
            bottom: parent.bottom
            bottomMargin: root.style.barPaddingBottom
        }
        border {
            left: root.style.barMarginLeft
            right: root.style.barMarginRight
            top: root.style.barMarginTop
            bottom: root.style.barMarginBottom
        }
        smooth: true
        source: root.value > 0 ? root.style.bar : ""
    }
    
    Label {
        id: label
        
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.text
        visible: root.textVisible
    }
}

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
    \class Slider
    \brief A slider for choosing an integer value.
    
    \ingroup components
    
    \sa BiDirectionalSlider, SliderStyle
*/
FocusScope {
    id: root
    
    /*!
        \brief The minimum value of the slider.
        
        The default value is \c 0.
    */
    property int minimum: 0
    
    /*!
        \brief The maximum value of the slider.
        
        The default value is \c 100.
    */
    property int maximum: 100
    
    /*!
        \brief The current value of the slider.
        
        The default value is \c 0.
    */
    property int value: 0
    
    /*
        type:enumeration
        \brief The orientation of the slider.
        
        Possible values are:
        
        <table>
            <tr>
                <th>Value</th>
                <th>Description</th>
            </tr>
            <tr>
                <td>Qt.Horizontal</td>
                <td>Horizontal orientation (default).</td>
            </tr>
            <tr>
                <td>Qt.Vertical</td>
                <td>Vertical orientation.</td>
            </tr>
        </table>        
    */
    property int orientation: Qt.Horizontal
    
    /*!
        \brief Whether the value should be changed while the slider handle is pressed down.
        
        If true, the value property will change when slider is dragged by the user. Otherwise, the value property will 
        change only when the handle is released.
        
        The default value is \c false.
    */
    property bool tracking: false
    
    /*!
        type:bool
        \brief Whether the slider handle is pressed down.
    */
    property alias pressed: mouseArea.pressed
        
    /*!
        type:SliderStyle
        \brief Provides styling properties for the slider.
        
        You can provide your own SliderStyle component if you wish to use custom styling.
    */
    property QtObject style: SliderStyle {}
        
    width: style.sliderWidth
    height: style.sliderHeight
    rotation: orientation == Qt.Vertical ? -90 : 0
    
    BorderImage {
        id: leftBackground
        
        anchors {
            left: parent.left
            right: handle.left
            top: parent.top
            bottom: parent.bottom
        }
        border {
            left: root.style.backgroundMarginLeft
            right: root.style.backgroundMarginRight
            top: root.style.backgroundMarginTop
            bottom: root.style.backgroundMarginBottom
        }
        smooth: true
        source: root.enabled ? root.style.leftBackground : root.style.leftBackgroundDisabled
    }
    
    BorderImage {
        id: rightBackground
        
        anchors {
            left: handle.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        border {
            left: root.style.backgroundMarginRight
            right: root.style.backgroundMarginLeft
            top: root.style.backgroundMarginTop
            bottom: root.style.backgroundMarginBottom
        }
        smooth: true
        source: root.enabled ? root.style.rightBackground : root.style.rightBackgroundDisabled
    }
    
    Image {
        id: handle
        
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        source: root.enabled ? root.style.handle : root.style.handleDisabled
    }
    
    MouseArea {
        id: mouseArea
                
        anchors.fill: parent
        drag {
            target: handle
            axis: Drag.XAxis
            minimumX: 0
            maximumX: Math.floor(width - (handle.width / 2))
        }
        onPressed: handle.x = Math.floor(mouseX - (handle.width / 2))
        onReleased: internal.updateValue()
    }
    
    QtObject {
        id: internal
        
        function updateValue() {
            root.value = Math.floor((mouseArea.mouseX / root.width) * (root.maximum - root.minimum));
        }
    }
    
    Binding {
        target: handle
        property: "x"
        value: Math.floor((root.width * root.value) / (root.maximum - root.minimum) - (handle.width / 2))
        when: (!mouseArea.pressed) && (root.value > 0) && (root.maximum > root.minimum)
    }
    
    Connections {
        target: root.tracking ? mouseArea : null
        onMouseXChanged: internal.updateValue()
    }
}

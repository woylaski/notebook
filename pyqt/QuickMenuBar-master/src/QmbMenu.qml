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
// \file	QmbMenu.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import "./"

/*! \brief Define a menu where QmbMenuItem could be inserted as menu sub elements.
 *
 * QmbMenu could be used for defining sub menu in menu items. Root menu bar QmbMenuBar component embed an hidden QmbMenu that is not direclty
 * available for users.
 *
 * QmbMenu support three different states:
 * \li \c RELEASED: it is the default state, menu is invisible and all its sub elements (either menu items of sub menus) are also RELEASED.
 * \li \c ACTIVATED: in activated state, menu is visible and the user can select its sub elements.
 * \li \c ENVELOPPED (used internally in QmbMenuBar): for root menu only, the menu could be envelopped, ie it is not visible to the user, but a small 'envelop/develop' control is shown in order to allow the user to activate the menu again.
 *
 * A simple sub menu could be defined with the following code:
 * \code
 *   QmbMenuBar {
 *     // Don't define QmbMenu in the root QmbMenuBar, it already has an "hidden" one
 *     QmbMenuItem {
 *       iconSource: "qrc:/anyicon.png"
 *       text: "Sub Menu"
 *       QmbMenu {  // QmbMenu should only be defined inside a QmbMenuItem
 *          orientation: Qt.Horizontal
 *          QmbMenuItem {
 *            //...
 *          }
 *       } // QmbMenu
 *     } // QmbMenuItem
 *   } // QmbMenuBar
 * \endcode
 */
Rectangle {
    id: menu
    x: 0; y: 0

    width: elementsLayout.implicitWidth * elementsLayout.scale
    height: elementsLayout.implicitHeight * elementsLayout.scale
    transformOrigin: Item.TopLeft

    gradient: style.menu.gradient
    opacity: 1.
    radius: style.menu.border.radius
    border.width: style.menu.border.width
    border.color: style.menu.border.color

    // Public properties //----------------------------------------------------
    /*! \brief Actual menu state, must be either \c "RELEASED", \c "ACTIVATED" or \c "RELEASED"
     *
     * QmbMenu support three different states:
     * \li \c "RELEASED": it is the default state, menu is invisible and all its sub elements (either menu items of sub menus) are also RELEASED.
     * \li \c "ACTIVATED": in activated state, menu is visible and the user can select its sub elements.
     * \li \c "ENVELOPPED" (used internally in QmbMenuBar): for root menu only, the menu could be envelopped, ie it is not visible to the user, but a small 'envelop/develop' control is shown in order to allow the user to activate the menu again.
     */
    state: "RELEASED"
    //! \brief Menu bar style configuration object, if unmodified, default value for QmbMenuStyle will be used.
    property QmbMenuStyle style: parent.style

    /*! Define this menu orientation, either vertical with \c Qt.Vertical or horizontal with \c Qt.Horizontal.
     *
     * \image html 20150928_quickmenubar-orientation.png
     *
     * Defautl to \c Qt.Vertical. */
    property int orientation: Qt.Vertical

    //! \brief Read-only property wich is true if the menu is a root menu, ie a top level menu.
    property bool   root: ( parent != null && parent.objectName === "QmbMenuBar" )

    //! \brief Menu label (not used actually, default to an empty string).
    property string label: ""

    // Private properties //---------------------------------------------------
    /*! \brief Private menu QmbMenuLayout layout for menu children sub elements.
     *
     * Private QuickMenuBar property.
     * \private */
    default property alias children : elementsLayout.children

    // Menu mouse area used to release the menu when the mouse exits
    MouseArea {
        id: menuMouseArea
        opacity: 1
        x: 0
        y: 0
        width: parent.width
        height: parent.height

        z: menu.z + 1.
        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: {        }
        onExited: {
            if ( style.debug )
                console.log( "QmbMenu::MouseArea::onExited(): " + menu + " / " + menu.label );
            if ( menu.root ) {   // For root menu, release all menu elements
                for ( var c = 0; c < elementsLayout.children.length; c++ )
                    if ( elementsLayout.children[ c ].state !== "CHECKED" )
                        elementsLayout.children[ c ].state = "RELEASED" ;
                if ( !style.stayVisible )
                    menu.state = "ENVELOPED";
            }
        }

        Image {
            id: menuHandler
            source: "qrc:/expand.png"
            fillMode: Image.Stretch
            antialiasing: true
            x: -1   // Hide part of the icon
            y: 0
            width: implicitWidth
            height: implicitHeight

            // visible property is managed in transitions scripactions
            z: menu.z + 1.
            transformOrigin: Item.TopLeft

            MouseArea {
                id: menuHandlerMouseArea
                opacity: 1
                anchors.fill: parent
                z: menuHandler.z + 1.
                hoverEnabled: true
                propagateComposedEvents: true
                onEntered: {
                    if ( style.debug )
                        console.log( "QmbMenu:menuHandlerMouseArea::onEntered()" );
                    if ( menu.state != "ACTIVATED" )
                        menu.state = "ACTIVATED"
                }
            }
        }

        // Layout must be a child of mouse area to prevent an exited() signal to be cast
        // when a child elemnt is entered
        QmbMenuLayout {
            id: elementsLayout

            x: 0
            y: 0
            z: menuMouseArea.z + 1.

            property var menu : menu
            property QmbMenuStyle style: menu.style
            transformOrigin: Item.TopLeft
            orientation: menu.orientation
            spacing: 5
        }
        Item {
            id: menuEnvelop
            x: menu.width - ( menuEnvelopImage.implicitWidth + menuEnvelopShadow.horizontalOffset + menuEnvelopShadow.radius + 1 )
            y: 2
            z: elementsLayout.z + 1.

            // visible property is managed in transition scriptactions

            Image {     // Menu envelop button
                id: menuEnvelopImage
                source: "qrc:/envelop.png"
                z: elementsLayout.z + 1.

                width: 25
                height: 25
                sourceSize.width: 25
                sourceSize.height: 25

                fillMode: Image.PreserveAspectFit
                antialiasing: true
                smooth: true

                MouseArea {
                    opacity: 1
                    anchors.fill: parent
                    z: menuEnvelop.z + 1.
                    hoverEnabled: true
                    propagateComposedEvents: true
                    onEntered: {
                        menuEnvelopShadow.color = style.elementHilightGradColor
                        menu.releaseAllMenuItem( null )
                    }
                    onExited: { menuEnvelopShadow.color = "#80000000" }
                    onClicked: {
                            if ( menu.state != "ENVELOPED" )
                                menu.state = "ENVELOPED"
                    }
                }
            }
            DropShadow {
                id: menuEnvelopShadow
                anchors.fill: menuEnvelopImage
                visible: style.showShadows && menuEnvelop.visible
                horizontalOffset: 2
                verticalOffset: 2
                radius: 3.0
                samples: 16
                color: "#80000000"
                source: menuEnvelopImage
                fast: true
            }
        }
    }

    states: [
        State { // When activated, menu is visible and answer to user inputs
            name: "ACTIVATED"
            PropertyChanges { target: menu;             enabled: true;              /*visible: true;*/      opacity : 1 }
            PropertyChanges { target: elementsLayout;   enabled: true;  scale: 1.0;                     opacity : 1 }
            PropertyChanges { target: menuHandler;      enabled: true;                                  opacity : 0 }
            PropertyChanges { target: menuEnvelop;      enabled: true;                                  opacity : 1 }
        },
        State { // When released, menu is invisible, and its parent menu is automatically released
            name: "RELEASED"
            PropertyChanges { target: menu;             enabled: false;                                         }
            PropertyChanges { target: elementsLayout;   enabled: false; scale: 0.1; visible: true;  opacity : 0 }
            PropertyChanges { target: menuHandler;      enabled: false;                             opacity : 0 }
            PropertyChanges { target: menuEnvelop;      enabled: false;                             opacity : 0 }

            StateChangeScript {
                script: {
                    // When a menu is released, all its menu elements are also released exept the active one
                    for ( var i = 0; i < elementsLayout.children.length; i++ )
                    {
                        if ( elementsLayout.children[ i ].state !== "CHECKED" )     // Checked items should not be released...
                            elementsLayout.children[ i ].state = "RELEASED"
                    }

                    // Parent element is released with this menu
                    // FIXME
                    //if ( parentElement && parentElement.state != "CHECKED" )
                    //    parentElement.state = "RELEASED"
                    visible: false
                }
            }
        },
        State { // When envelopped, menu is hidden, only the menu handler is visible
            name: "ENVELOPED"
            PropertyChanges { target: menu;                                                         }
            PropertyChanges { target: elementsLayout;   enabled: false; scale: 0.1;     opacity : 0 }
            PropertyChanges { target: menuHandler;      enabled: true;                  opacity : 1 }
            PropertyChanges { target: menuEnvelop;      enabled: false;                 opacity : 0 }
        }
    ]

    transitions: [
        Transition {
            from: "ACTIVATED"
            to: "RELEASED"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: menu;             properties: "opacity";          duration: 500 }
                    NumberAnimation { target: elementsLayout;   properties: "scale, opacity";   duration: 500 }
                    NumberAnimation { target: menuHandler;      properties: "opacity";          duration: 500 }
                    NumberAnimation { target: menuEnvelop;      properties: "opacity";          duration: 500 }
                }
                ScriptAction { script: {
                        menu.visible = false;
                        menuHandler.visible = false;
                        menuEnvelop.visible = false;
                    }
                }
            }
        },
        Transition {
            from: "RELEASED"
            to: "ACTIVATED"
            SequentialAnimation {
                ScriptAction { script: {
                        menu.visible = true
                        menuHandler.visible = root
                        menuEnvelop.visible = root
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: menu;             properties: "opacity";          duration: 500 }
                    NumberAnimation { target: elementsLayout;   properties: "scale, opacity";   duration: 500 }
                    NumberAnimation { target: menuEnvelop;      properties: "opacity";          duration: 500 }
                }
            }
        },
        Transition {
            from: "ENVELOPED"
            to: "ACTIVATED"
            SequentialAnimation {
                ScriptAction { script: {
                        menu.visible = true
                        menuEnvelop.visible = style.stayVisible && menu.root // Show only in root menu
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: menu;             properties: "opacity";          duration: 500 }
                    NumberAnimation { target: elementsLayout;   properties: "scale, opacity";   duration: 500 }
                    NumberAnimation { target: menuHandler;      properties: "opacity";          duration: 100 }
                    NumberAnimation { target: menuEnvelop;      properties: "opacity";          duration: 500 }
                }
                ScriptAction { script: {
                        menuHandler.visible = false
                        var v = root
                        menuEnvelop.visible = v
                    }
                }
            }
        },
        Transition {
            from: "ACTIVATED"
            to: "ENVELOPED"
            SequentialAnimation {
                ScriptAction { script: {
                        menuHandler.visible = true;
                    }
                }
                ParallelAnimation {
                    NumberAnimation { target: menu;             properties: "opacity";          duration: 500 }
                    NumberAnimation { target: elementsLayout;   properties: "scale, opacity";   duration: 500 }
                    NumberAnimation { target: menuHandler;      properties: "opacity";          duration: 700 }
                    NumberAnimation { target: menuEnvelop;      properties: "opacity";          duration: 500 }
                }
                ScriptAction { script: {
                        menuEnvelop.visible = false;
                    }
                }
            }
        }
    ]

    function releaseAllMenuItem( except )
    {
        if ( style.debug && except !== null )
            console.log( "QmbMenu::releaseAllMenuElement(): except " + except + " / " + except.label );
        for ( var i = 0; i < elementsLayout.children.length; i++ ) {
            if ( elementsLayout.children[ i ] !== except && elementsLayout.children[ i ].state !== "CHECKED" )
                elementsLayout.children[ i ].state = "RELEASED";
        }
    }
}


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
// \file	QmbMenuItem.qml
// \author	benoit@qanava.org
// \date	2015 January 09
//-----------------------------------------------------------------------------

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0

/*! \brief Model a "command" item in a main QmbMenuBar menu or a QmbMenu sub-menu.
 *
 * Menu item state, must be either \c "RELEASED", \c "ACTIVATED" or \c "CHECKED" (default is \c "RELEASED").
 *
 * \c orientation, \c parentOrientation, \c children alias, \c menuItemEnabled and \c hilightGradColor properties should be
 * considered private.
 *
 * \note do not change the default \c objectName property.
 */
Rectangle {
    id: menuItem
    objectName: "QmbMenuItem"    // Do not change menu element object name...

    // Menu bar style sheet (initialized by QmbMenuBar)
    property QmbMenuStyle style : parent.style
    color: "transparent"
    visible: true
    opacity: 1.
    x: 0; y: 0
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: elementLayout.implicitWidth
    Layout.preferredHeight: elementLayout.implicitHeight
    Layout.minimumWidth: 16
    Layout.minimumHeight: 16
    Layout.rightMargin: style.subMenuMargin
    Layout.leftMargin: style.subMenuMargin

    // Public properties //----------------------------------------------------
    state: "RELEASED"

    /*! \brief Text that will appears under the menu item icon.
     *
     * Default to an empty string.
     */
    property string text
    /*! \brief Url for the icon image that should be displayed in the menu item.
     *
     * Default to an empty url.
     */
    property url    iconSource

    /*! \brief Define is this menu item should be checkable and thus emit the checked() signal when checked.
     *
     * Do not setup this property manually if you have specified a Qt/QML action with the \c action property (especially
     * if \c action is already checkable.
     *
     * Default to \c false.
     */
    property bool   checkable: false

    /*! \brief Emitted when the element is activated and the user click this element.
     *
     * Signal is also emitted when an action is specified in \c action property (it is better to catch
     * \c action triggered() signal in that specific use case).
     */
    signal  triggered( );

    /*! \brief Emitted when the element has the checkable property set to true and the item is checked or unchecked.
     *
     * Signal is also emitted when a checkable action is specified in \c action property (it is better to catch
     * \c action checked() signal in that specific use case).
     */
    signal  checked( var state );

    /*! \brief Eventual Qt/QML action associed to this menu element.
     *
     * Standard/checkable actions are supported, enabled/disabled state is also taken into account.
     *
     * Action \c iconSource and \c text properties are not taken into account by QuickMenuBar, so it must
     * be set manually for this QmbMenuItem corresponding properties.
     *
     * Default to null.
     */
    property QtObject   action : null

    // Private properties //---------------------------------------------------
    //! \private
    property int    orientation: Qt.Vertical   // Will be sets in QmbMenuLayout
    property var    parentOrientation: 0

    //! \private
    default property alias children : childMenu.children

    function getParentMenu( ) { return ( parent !== null ? parent.menu : null ) }
    function getChildMenu( ) { return childMenu.children.length === 1 ? childMenu.children[ 0 ] : null }

    Rectangle {
        id: childMenu
        objectName: "QmbMenuItem"

        scale: ( 1 / parent.scale ) - 0.1   // parent scale should not affect child menu and its scale is reduced since sube menu are not as large as top level menu

        property var style: ( parent != null ? parent.style : null )
        property var parentMenu : ( parent != null ? parent.menu : null )

        // If parent menu is laid out horizontally, top left corner is under parent menu item
        // If parent menu is laid ou vertically, top left corner is at menu item right
        x: ( menuItem.parent !== null && menuItem.parent.menu.orientation === Qt.Vertical ? menuItem.width : menuItem.width / 5 )
        y: ( menuItem.arent !== null && menuItem.parent.menu.orientation === Qt.Vertical ? menuItem.height / 5 : menuItem.height )
        z: menuItem.z + 1
        visible: true
    }

    onActionChanged : {
        if ( action !== null ) {
            action.toggled.connect( menuItem.actionCheckedChanged )
            action.enabledChanged.connect( menuItem.actionEnabledChanged )

            menuItem.actionCheckedChanged( action.checked ) // Force checked and enabled initialization
            menuItem.actionEnabledChanged( action.enabled )
        }
    }
    function actionCheckedChanged( checked ) {
        if ( checked && menuItem.state !== "CHECKED" )
        {
            menuItem.state = "CHECKED"
            menuItem.checked( menuItem.state === "CHECKED" )
        }
        if ( !checked && menuItem.state === "CHECKED" )
        {
            menuItem.state = "RELEASED"
            menuItem.checked( menuItem.state === "CHECKED" )
        }
    }
    function actionEnabledChanged( ) {
        if ( action !== null )
            menuItemEnabled = action.enabled
    }

    property bool menuItemEnabled: true

    // Private properties //-----------
    property color hilightGradColor : style.elementHilightGradColor

    states: [
        State {
            name: "CHECKED"
            PropertyChanges { target: hiligther;                    opacity : 0.7;                                                      }
            PropertyChanges { target: menuItem;  scale : 1.;                        hilightGradColor : style.elementCheckedGradColor   }
        },
        State {
            name: "ACTIVATED"
            PropertyChanges { target: hiligther;                    opacity : 0.7                                                       }
            PropertyChanges { target: menuItem;  scale : 1.1                                                                         }
            StateChangeScript {
                script: {
                    if ( getParentMenu( ) !== null )
                    {
                        getParentMenu( ).releaseAllMenuItem( menuItem );
                        getParentMenu( ).state = "ACTIVATED"; // Force parent menu activation (avoid release once an item is activated)
                    }
                    if ( getChildMenu( ) !== null )
                        getChildMenu( ).state = "ACTIVATED"
                }
            }
        },
        State {
            name: "RELEASED"
            PropertyChanges { target: hiligther;                opacity : 0.    }
            PropertyChanges { target: menuItem;  scale : 1.                  }
            StateChangeScript {
                script: {
                    if ( getChildMenu( ) !== null )
                        getChildMenu( ).state = "RELEASED";
                }
            }
        }
    ]

    transitions: [
        Transition {
            from: "ACTIVATED"
            to: "RELEASED"
            NumberAnimation { target: hiligther; properties: "opacity"; duration: 400 }
            NumberAnimation { target: menuItem; properties: "scale"; easing.type: Easing.OutElastic; duration: 400 }
        },
        Transition {
            from: "RELEASED"
            to: "ACTIVATED"
            NumberAnimation { target: hiligther; properties: "opacity"; duration: 200 }
            NumberAnimation { target: menuItem; properties: "scale"; easing.type: Easing.OutElastic; duration: 200 }
        }
    ]

    ColumnLayout {
        id: elementLayout
        spacing: 1
        Layout.alignment: Qt.AlignCenter

        Item { // Add a transparent content rectangle, or drop shadow graphics effect won't works
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth : true
            Layout.fillHeight : true
            Layout.rightMargin: imageShadow.horizontalOffset
            Layout.bottomMargin: imageShadow.verticalOffset


            Layout.preferredWidth: menuItem.style.elementPreferredSize
            Layout.preferredHeight: menuItem.style.elementPreferredSize

            Layout.minimumWidth: 16
            Layout.minimumHeight: 16

            Layout.maximumWidth: Number.POSITIVE_INFINITY
            Layout.maximumHeight: Number.POSITIVE_INFINITY

            Image {
                id: menuItemImage
                anchors.fill: parent
                source: menuItem.iconSource
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                smooth: true
                sourceSize.width: 64
                sourceSize.height: 64
            }
            DropShadow {
                id: imageShadow
                anchors.fill: menuItemImage
                visible: style.showShadows
                horizontalOffset: 2
                verticalOffset: 2
                radius: 4.0
                samples: 16
                color: "#80000000"
                source: menuItemImage
                fast: true
            }
            BrightnessContrast {
                id: imageContrast
                anchors.fill: menuItemImage
                source: menuItemImage
                brightness: 0.5
                contrast: -0.5
                visible: !menuItemEnabled
            }
        }

        Item { // Add a transparent content rectangle, or drop shadow graphics effect won't works
            Layout.alignment: Qt.AlignHCenter

            Layout.preferredWidth: menuItemLabel.contentWidth
            Layout.preferredHeight: menuItemLabel.contentHeight
            Layout.minimumWidth: 16
            Layout.minimumHeight: 16
            Layout.rightMargin: labelShadow.horizontalOffset
            Layout.bottomMargin: labelShadow.verticalOffset

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                id: menuItemLabel
                width: menuItem.style.elementPreferredSize * 2  // Text size can't be larger than 2 times the icon image width
                smooth: true
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                text : menuItem.text
                color: menuItem.style.textColor
                onTextChanged: { menuItem.parent.relayout( ) }  // Force layout when text change (eg translation changed)
            }
            DropShadow {
                id: labelShadow
                anchors.fill: menuItemLabel
                visible: style.showShadows
                horizontalOffset: 2
                verticalOffset: 2
                radius: 4.0
                samples: 16
                color: "#80000000"
                source: menuItemLabel
                fast: true
            }
        }
    } // ColumnLayout: elementLAyout

    Image { // check image to differentiate checkable menu elements
        id: checkableIcon
        visible: menuItem.checkable || ( menuItem.action !== null && menuItem.action.checkable === true )
        opacity: 0.9

        source: "checkbox.svg"

        x: parent.width - 15
        y: menuItemImage.height - 6
        width: 12
        height: 12
    }

    Image { // sub menu arrow image to differentiate item with a submenu
        id: subMenuIcon
        visible: menuItem.getChildMenu( ) !== null
        opacity: 0.9

        source: "arrow-right.svg"

        x: parent.width - 15
        y: menuItemImage.height - 6
        width: 12
        height: 12
    }

    Rectangle {
        id: hiligther
        anchors.fill: parent

        // Hilight rectangle fill gradient
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#00000000";
            }
            GradientStop {
                position: 0.50;
                color: hilightGradColor;
            }
            GradientStop {
                position: 1.00;
                color: "#00000000";
            }
        }

        border.width: 0
        enabled: true
        antialiasing: true
        opacity: 0.0

        MouseArea {
            id: elementMouseArea
            opacity: 1
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                if ( style.debug )
                    console.log( "QanmenuItem::MouseArea::onEntered(): " + menuItem.text )

                if ( menuItem.state !== "CHECKED" )
                    menuItem.state = "ACTIVATED"
                if ( menuItem.state === "CHECKED" )
                    menuItem.hilightGradColor = style.elementHilightCheckedGradColor
                if ( menuItem.state === "CHECKED" && getParentMenu( ) !== null )
                    getParentMenu( ).releaseAllMenuItem( menuItem )
            }
            onExited: {
                if ( style.debug )
                    console.log( "QanmenuItem::MouseArea::onExited(): " + menuItem.text )
                if ( menuItem.state === "CHECKED" )
                    menuItem.hilightGradColor = style.elementCheckedGradColor;

                // Only release element who have no child menu (ie leaf menu elements)
                if ( !getChildMenu( ) && menuItem.state !== "CHECKED" )
                    menuItem.state = "RELEASED"
            }
            onClicked: {
                if ( checkable || ( action !== null && action.enabled && action.checkable === true ) )
                {
                    menuItem.state = ( menuItem.state === "CHECKED" ? "RELEASED" : "CHECKED" )
                    menuItem.checked( menuItem.state === "CHECKED" )
                    if ( action !== null && action.checkable === true )
                        action.toggled( menuItem.state === "CHECKED" )
                }
                if ( menuItem.state !== "CHECKED" )
                    menuItem.state = "RELEASED"
                // Release element when clicked and release its host menu except for checkable items and root menu elements
                if ( menuItem.state !== "CHECKED" && getParentMenu( ) !== null && !getParentMenu( ).root )
                    getParentMenu( ).state = "RELEASED"
                menuItem.triggered( )

                if ( action !== null && action.enabled )
                    action.trigger( )
                else if ( action !== null && action.enabled && checkable && action.checkable )
                    action.toggle( menuItem.state === "CHECKED" )
            }
        }
    }
}

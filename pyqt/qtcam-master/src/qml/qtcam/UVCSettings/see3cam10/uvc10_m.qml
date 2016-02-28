/*
 * uvc10_m.qml -- extension settings for 10cug mono cameras
 * Copyright © 2015  e-con Systems India Pvt. Limited
 *
 * This file is part of Qtcam.
 *
 * Qtcam is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * Qtcam is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Qtcam. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.1
import econ.camera.uvcsettings 1.0
import econ.camera.see3cam10Mono 1.0
import "../../JavaScriptFiles/tempValue.js" as JS
Item {
    width:268
    height:720
    id:see3cam10
    property bool masterMode
    property bool triggerMode

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Information
        onAccepted: {
            close()
        }
        Component.onCompleted: close()
    }

    Timer {
        id: masterModeTimer
        interval: 1000
        onTriggered: {
            masterModeCapture()
            stop()
        }
    }

    Action {
        id: masterModeAction
        onTriggered: {
            masterModeEnable()
        }
    }

    Action {
        id: triggerModeAction
        onTriggered: {
            triggerModeEnable()
        }
    }

    Action {
        id: firmwareVersion
        onTriggered: {
            firwareVersionDisplay()
        }
    }

    Button {
        id: mastermmode_selected10CUG
        x: 19
        y: 207
        opacity: 1
        action: masterModeAction
        activeFocusOnPress : true
        text: "Master Mode"
        tooltip: "Set camera in Master Mode"
        style: econ10CUG_MonoButtonStyle
        Keys.onReturnPressed: {
            masterModeEnable()
        }
    }

    Button {
        id: trigger_mode_selected10CUG
        x: 145
        y: 207
        opacity: 1
        focus: true
        action: triggerModeAction
        activeFocusOnPress : true
        text: "Trigger Mode"
        tooltip: "Set camera in Trigger Mode"
        style: econ10CUG_MonoButtonStyle
        Keys.onReturnPressed: {
            triggerModeEnable()
        }
    }

    Button {
        id: f_wversion_selected10CUG
        x: 85
        y: 280
        opacity: 1
        action: firmwareVersion
        activeFocusOnPress : true
        text: "Firmware Version"
        tooltip: "Click to see the firmware version of the camera"
        style: econ10CUG_MonoButtonStyle
        Keys.onReturnPressed: {
            firwareVersionDisplay()
        }
    }

    Component {
        id: econ10CUG_MonoButtonStyle
        ButtonStyle {
            background: Rectangle {
                implicitHeight: 38
                implicitWidth: 104
                border.width: control.activeFocus ? 3 :0
                color: "#e76943"
                border.color: control.activeFocus ? "#ffffff" : "#222021"
                radius: control.activeFocus ? 5 : 0
            }
            label: Text {
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Ubuntu"
                font.pointSize: 10
                text: control.text
            }
        }
    }

    function masterModeEnable() {
        masterModeCapture();
        masterMode = seecam10.enableMasterMode()
        if(masterMode) {
            masterModeTimer.start()
            JS.enableMasterMode_10cugM()
        }
        else {
            messageDialog.title = qsTr("Failure")
            messageDialog.text = qsTr("Master Mode enabling failed")
            messageDialog.open()
        }
    }

    function triggerModeEnable() {
        triggerModeCapture()
        triggerMode = seecam10.enableTriggerMode()
        if(triggerMode) {
            JS.enableTriggerMode_10cugM()
        }
        else {
            messageDialog.title = qsTr("Failure")
            messageDialog.text = qsTr("Trigger Mode enabling failed")
            messageDialog.open()
        }
    }

    function firwareVersionDisplay() {
        uvccamera.getFirmWareVersion()
    }

    See3Cam10Mono {
        id: seecam10
    }

    Uvccamera {
        id: uvccamera
        onTitleTextChanged: {
            messageDialog.title = _title.toString()
            messageDialog.text = _text.toString()
            messageDialog.open()
        }
    }
    Component.onCompleted: {
        uvccamera.initExtensionUnit("e-con's 1MP Monochrome Camera")
        mastermmode_selected10CUG.forceActiveFocus()
    }
    Component.onDestruction: {
        uvccamera.exitExtensionUnit()
    }
}

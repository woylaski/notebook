/*
 *  Copyright 2013 Ruediger Gad
 *
 *  This file is part of Q To-Do.
 *
 *  Q To-Do is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Q To-Do is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Q To-Do.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import SyncToImap 1.0

Item {
    id: imapAccountSettingsSheet

    property int authenticationTypeSetting
    property int currentAccountId: -1
    property string currentAccountName
    property bool editAccount: false
    property int encryptionSetting: -1
    property bool newAccount: false

    signal accepted()
    signal closed()
    signal closing()
    signal opened()
    signal opening()

    function finished() {
        console.log("finished")
        if(state === "closed"){
            enabled = false
            closed()
        }else{
            opened()
        }
    }

    function clearTextFields() {
        accountNameTextField.text = ""
        passwordTextField.text = ""
        userNameTextField.text = ""
        serverTextField.text = ""
        serverPortTextField.text = ""
    }

    function close() {
        closing()

        clearTextFields()

        state = "closed"
    }

    function open() {
        console.log("open")
        opening()

        enabled = true

        currentAccountId = -1
        editAccount = false
        newAccount = false
        accountListView.currentIndex = -1

        state = "open"
    }

    anchors.bottom: parent.bottom
    anchors.top: parent.bottom
    enabled: false
    width: parent.width
    visible: enabled
    z: 1

    ImapAccountListModel {
        id: imapAccountListModel
    }

    ImapAccountHelper {
        id: imapAccountHelper
    }

    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: focus = true
    }

    ConfirmationDialog {
        id: removeAccountConfirmationDialog

        titleText: "Remove account?"
        message: "Delete account " + currentAccountName + "?"

        onAccepted: {
            console.log("Removing account: " + currentAccountId + " - " + currentAccountName)
            imapAccountHelper.removeAccount(currentAccountId)
        }
    }

    onStateChanged: {
        console.log("Imap account settings state changed: " + state)
    }

    Rectangle {
        id: buttonBar
        anchors.top: parent.top
        height: rejectButton.height + 6
        width: parent.width
        z: 4

        color: "lightgray"

        CommonButton{
            id: rejectButton
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            text: "Cancel"
            onClicked: imapAccountSettingsSheet.close();
        }

        Text {id: entryLabel; text: "Accounts"; font.pointSize: primaryFontSize * 0.75
              font.capitalization: Font.SmallCaps; font.bold: true; anchors.centerIn: parent}

        CommonButton{
            id: acceptButton
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            width: rejectButton.width
            text: "OK"
            onClicked: {
                if (currentAccountId >= 0) {
                    imapAccountHelper.setSyncAccount(currentAccountId)
                }
                imapAccountSettingsSheet.close()
            }
        }
    }

    Rectangle {
        id: inputRectangle

        anchors {top: buttonBar.bottom; left: parent.left; right: parent.right; bottom: parent.bottom}
        color: "white"

        Item {
            id: contentItem

            anchors {top: parent.top; left: parent.left; leftMargin: primaryFontSize;
                     right: parent.right; rightMargin: primaryFontSize; bottom: parent.bottom}

            Text {
                id: accountsText
                anchors {top: parent.top; topMargin: primaryFontSize * 0.5; left: parent.left; right: parent.right}
                text: "Available Accounts"
                font.pointSize: primaryFontSize * 0.75
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle {
                id: accountListViewRectangle
                anchors {top: accountsText.bottom; topMargin: primaryFontSize * 0.25; horizontalCenter: parent.horizontalCenter}

                width: parent.width * 0.8
                height: parent.height * 0.15

                border.color: "gray"
                border.width: primaryFontSize * 0.1
//                radius: primaryFontSize * 0.25

                ListView {
                    id: accountListView

                    anchors.fill: parent

                    model: imapAccountListModel
                    clip: true
                    highlightFollowsCurrentItem: true

                    delegate: Text {
                        id: listDelegate
                        width: parent.width

                        text: accountName

                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WrapAnywhere

                        font.pointSize: primaryFontSize
                        color: "black"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("clicked: " + index)
                                accountListView.currentIndex = index

                                editAccount = false
                                newAccount = false

                                currentAccountId = accountId
                                console.log("Current account id: " + currentAccountId)

                                currentAccountName = accountName
                                accountNameTextField.text = currentAccountName

                                passwordTextField.text = imapAccountHelper.imapPassword(currentAccountId)
                                serverTextField.text = imapAccountHelper.imapServer(currentAccountId)
                                serverPortTextField.text = imapAccountHelper.imapPort(currentAccountId)
                                userNameTextField.text = imapAccountHelper.imapUserName(currentAccountId)

                                encryptionSetting = imapAccountHelper.encryptionSetting(currentAccountId)
                                authenticationTypeSetting = imapAccountHelper.imapAuthenticationType(currentAccountId)
                            }
                        }
                    }

                    highlight: Rectangle {
                        color: "gray"
                    }
                }
            }

            Row {
                id: actionButtonRow
                anchors {top: accountListViewRectangle.bottom; topMargin: primaryFontSize * 0.25; left: parent.left}
                height: newButton.height
                width: parent.width

                CommonButton {
                    id: newButton
                    text: "New"
                    width: parent.width / 4
                    onClicked: {
                        accountListView.currentIndex = -1
                        clearTextFields()
                        editAccount = true
                        newAccount = true
                        encryptionSetting = 1
                        serverPortTextField.text = 993
                        authenticationTypeSetting = 2
                    }
                }

                CommonButton {
                    id: editButton
                    text: "Edit"
                    width: parent.width / 4
                    enabled: accountListView.currentIndex > -1
                    onClicked: {
                        editAccount = true
                    }
                }

                CommonButton {
                    id: saveButton
                    text: "Save"
                    width: parent.width / 4
                    enabled: editAccount || newAccount
                    onClicked: {
                        imapAccountSettingsSheet.focus = true
                        if (newAccount) {
                            console.log("Creating new account...")
                            imapAccountHelper.addAccount(accountNameTextField.text, userNameTextField.text,
                                                         passwordTextField.text, serverTextField.text,
                                                         serverPortTextField.text, encryptionSetting,
                                                         authenticationTypeSetting)
                        } else if (editAccount) {
                            console.log("Updating account...")
                            imapAccountHelper.updateAccount(currentAccountId, userNameTextField.text,
                                                            passwordTextField.text, serverTextField.text,
                                                            serverPortTextField.text, encryptionSetting,
                                                            authenticationTypeSetting)
                        }
                    }
                }

                CommonButton {
                    id: deleteButton
                    text: "Del"
                    width: parent.width / 4
                    enabled: currentAccountId >= 0
                    onClicked: {
                        removeAccountConfirmationDialog.open()
                    }
                }
            }

            Flickable {
                id: inputFlickable

                anchors {top: actionButtonRow.bottom; topMargin: primaryFontSize * 0.5
                         left: parent.left; right: parent.right; bottom: parent.bottom}
                clip: true
                contentHeight: flickableContent.height * 2.05

                Column {
                    id: flickableContent

                    anchors {top: parent.top; horizontalCenter: parent.horizontalCenter}
                    spacing: primaryFontSize * 0.4
                    width: parent.width * 0.98


                    Row {
                        height: accountNameTextField.height
                        spacing: primaryBorderSize * 0.5
                        width: parent.width

                        Text {
                            id: accountNameText

                            font.pointSize: primaryFontSize * 0.75
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            text: "Account Name"
                            verticalAlignment: Text.AlignVCenter
                        }

                        CommonTextField {
                            id: accountNameTextField

                            enabled: newAccount
                            pointSize: primaryFontSize * 0.7
                            width: parent.width - parent.spacing - accountNameText.width
                        }
                    }

                    Row {
                        height: userNameTextField.height
                        spacing: primaryBorderSize * 0.5
                        width: parent.width

                        Text {
                            id: userNameText

                            font.pointSize: primaryFontSize * 0.75
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            text: "User Name"
                            verticalAlignment: Text.AlignVCenter
                        }

                        CommonTextField {
                            id: userNameTextField

                            enabled: editAccount
                            pointSize: primaryFontSize * 0.7
                            width: parent.width - parent.spacing - userNameText.width
                        }
                    }

                    Row {
                        height: passwordTextField.height
                        spacing: primaryBorderSize * 0.5
                        width: parent.width

                        Text {
                            id: passwordText

                            font.pointSize: primaryFontSize * 0.75
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            text: "Password"
                            verticalAlignment: Text.AlignVCenter
                        }

                        CommonTextField {
                            id: passwordTextField

                            echoMode: TextInput.Password
                            enabled: editAccount
                            pointSize: primaryFontSize * 0.7
                            width: parent.width - parent.spacing - passwordText.width
                        }
                    }

                    Row {
                        height: serverTextField.height
                        spacing: primaryBorderSize * 0.5
                        width: parent.width

                        Text {
                            id: serverText

                            font.pointSize: primaryFontSize * 0.75
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            text: "Server"
                            verticalAlignment: Text.AlignVCenter
                        }

                        CommonTextField {
                            id: serverTextField

                            enabled: editAccount
                            pointSize: primaryFontSize * 0.7
                            width: parent.width - parent.spacing - serverText.width
                        }
                    }

                    Row {
                        id: portRow

                        width: parent.width

                        Text {
                            id: serverPortText

                            font.pointSize: primaryFontSize * 0.75
                            height: portRow.height
                            horizontalAlignment: Text.AlignHLeft
                            text: "Port"
                            verticalAlignment: Text.AlignVCenter
                            width: parent.width / 6 - portSpacer.width
                        }

                        CommonTextField {
                            id: serverPortTextField

                            enabled: editAccount
                            pointSize: primaryFontSize * 0.7
                            width: parent.width / 6
                        }

                        Rectangle {
                            id: portSpacer

                            color: "transparent"
                            height: portRow.height
                            width: primaryBorderSize * 0.5
                        }

                        CommonButton {
                            id: sslButton

                            enabled: encryptionSetting != 1
                            text: "SSL"
                            width: parent.width / 6

                            onClicked: {
                                encryptionSetting = 1
                                serverPortTextField.text = 993
                            }
                        }

                        CommonButton {
                            id: startTlsButton

                            enabled: encryptionSetting != 2
                            text: "STARTTLS"
                            width: parent.width / 2

                            onClicked: {
                                encryptionSetting = 2
                                serverPortTextField.text = 143
                            }
                        }
                    }

                    Row {
                        id: authenticationTypeRow

                        width: parent.width

                        CommonButton {
                            id: authNoneButton

                            enabled: authenticationTypeSetting != 0
                            text: "None"
                            width: parent.width / 4

                            onClicked: {
                                authenticationTypeSetting = 0
                            }
                        }

                        CommonButton {
                            id: authLoginButton

                            enabled: authenticationTypeSetting != 1
                            text: "Login"
                            width: parent.width / 4

                            onClicked: {
                                authenticationTypeSetting = 1
                            }
                        }

                        CommonButton {
                            id: authPlainButton

                            enabled: authenticationTypeSetting != 2
                            text: "Plain"
                            width: parent.width / 4

                            onClicked: {
                                authenticationTypeSetting = 2
                            }
                        }

                        CommonButton {
                            id: authMd5Button

                            enabled: authenticationTypeSetting != 3
                            text: "MD5"
                            width: parent.width / 4

                            onClicked: {
                                authenticationTypeSetting = 3
                            }
                        }
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "open"
            AnchorChanges { target: imapAccountSettingsSheet; anchors.top: parent.top }
        },
        State {
            name: "closed"
            AnchorChanges { target: imapAccountSettingsSheet; anchors.top: parent.bottom }
        }
    ]

    transitions: Transition {
        SequentialAnimation {
            AnchorAnimation { duration: 250; easing.type: Easing.OutCubic }
            ScriptAction { script: imapAccountSettingsSheet.finished() }
        }
    }
}

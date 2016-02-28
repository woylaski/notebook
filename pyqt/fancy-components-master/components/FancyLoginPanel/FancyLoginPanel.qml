/****************************************************************************
**
**  FancyLoginPanel is a login screen that is used to authenticate the user.
**  This component has 2 custom made text input fields, based on TextInput component.
**  This fields are used to get both login and password from the user to perform logging procedure.
**  There are also 2 FancyMobileButton components and a text label.
**  Buttons are responsible for initializing logging and registering procedures.
**  Text label on the bottom is clickable.
**
**  Author:   Mateusz Drzazga
**  Date:     1.09.2015
**  E-mail    matt.drzazga@gmail.com
**
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    id: root

    /*  This property holds login that user typed.
    */
    property alias login: loginTextField.text
    /*  This property holds password that user typed.
    */
    property alias password: passwordTextField.text

    /*  This is alias to invalidDataLabel object.
    */
    property alias invalidDataLabel: invalidDataLabel

    /*  This is alias to busyIndicator object.
    */
    property alias busyIndicator: busyIndicator

    /*  This element is disabled when busyIndicator is running.
    */
    enabled: !busyIndicator.running

    width: 250
    height: 250

    /*  This signal is emitted when the user clicks on logInButton.
    */
    signal loginClicked()

    /*  This signal is emitted when the user clicks on signUpButton.
    */
    signal signUpClicked()

    /*  This signal is emitted when the user clicks on passwordForgotLabel.
    */
    signal passwordForgotClicked()

    /*  This Rectangle is used as a background.
        Setting 'color' property to black and 'opacity' to i.e 0.3 will give
        effect known from many mobile application login screens.
        It is extremely sexy for the eye when one puts nice Image on top and later uses
        FancyLoginPanel component with 'color' and 'opacity' properties set as above.
    */
    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Column {
        id: column
        width: 200
        height: column.implicitHeight

        anchors.centerIn: parent
        spacing: 5

        /*  This is custom text input component. It is used to get login from the user.
        */
        Rectangle {
            width: parent.width
            height: loginTextField.implicitHeight + 10

            // This is horizontal line.
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "green"}

            TextInput {
                id: loginTextField
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 5
                    rightMargin: 5
                }
                focus: true
                KeyNavigation.tab: passwordTextField
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                onTextChanged: invalidDataLabel.visible = false

                /*  This is placeholder component.
                    It displays "Login" text when there is no text in TextInput above.
                */
                Label {
                    text: "Login"
                    visible: loginTextField.text === ""? true : false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        /*  This is custom text input component. It is used to get password from the user.
        */
        Rectangle {
            width: parent.width
            height: passwordTextField.implicitHeight + 10

            // This is horizontal line
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "green"}

            TextInput {
                id: passwordTextField
                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: 5
                    rightMargin: 5
                }
                clip: true
                anchors.verticalCenter: parent.verticalCenter
                KeyNavigation.tab: logInButton

                echoMode: TextInput.Password
                onTextChanged: invalidDataLabel.visible = false

                /*  This is placeholder component.
                    It displays "Password" text when there is no text in TextInput above.
                */
                Label {
                    text: "Password"
                    visible: passwordTextField.text === ""? true : false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        /*  Text label to inform the user that he/she provided invalid data.
        */
        Label {
            id: invalidDataLabel
            width: parent.width
            text: "Invalid login or password"
            visible: false
        }

        /*  Button used to start Log In action
        */
        FancyMobileButton {
            id: logInButton
            width: parent.width
            height: 30
            color: "#00bb11"
            text: "Log In"
            KeyNavigation.tab: signUpButton
            onClicked: {
                busyIndicator.running = true
                invalidDataLabel.visible = false
                root.loginClicked()
            }
        }
        //  Spacer item.
        Item { height: 5; width: 1 }

        /*  Button used to start signUp action.
        */
        FancyMobileButton {
            id: signUpButton
            width: parent.width
            height: 30
            color: "#00bb11"
            text: "Sign Up"
            KeyNavigation.tab: loginTextField
            onClicked: root.signUpClicked()
        }

        //  Spacer item.
        Item { height: 5; width: 1 }

        /*  Simple horizontal line separator
        */
        Rectangle {
            id: separator
            width: parent.width
            height: 1
            color: "#03396c"
        }

        /*  This is a clickable text label to provide custom action when the user clicks on this component.
            This is particularly useful when the user forgets its password and wants to perform password recovery action.
            In that case, second window with form should be openned.
            This component emits passwordForgotClicked() signal whenever it's clicked.
        */
        Label {
            id: passwordForgotLabel
            text: "<a href=\"www.example.org\"><font color=\"FF00CC\">Forgot password?</font></a>"
            onLinkActivated: passwordForgotClicked()
            anchors.left: parent.left
        }
    }


    /*  Component used to inform the user that something is happening
        When this component is running, entire FancyLoginPanel is disabled
    */
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: false
    }
}

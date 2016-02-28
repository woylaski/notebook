/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: A little vertical menu, displaying 3 buttons
*/
import QtQuick 1.1

Item {
    //id: menuAck
    anchors.centerIn: parent

    Column {
        anchors.centerIn: parent
        spacing: parent.width / 12

        ButtonAck {
            id: buttonToggle
            label: "Toggle me"

            // Little function to change the state of the button
            function toggle()
            {
                if(state == "blue") {
                    state = "pink"
                } else {
                    state = "blue"
                }
            }

            state: "blue"
            states: [
                State {
                    name: "blue";
                    PropertyChanges{ target: buttonToggle;
                                     buttonColor: "#b4c8d7"}
                },
                State {
                    name: "pink";
                    PropertyChanges{ target: buttonToggle;
                                     buttonColor: "pink"}
                }
            ]

            onButtonClick: {
                buttonToggle.toggle()
            }

            // smooth color transition
            transitions: Transition {
                ColorAnimation {
                    duration: 300
                }
            }
        }

        ButtonAck {
            id: buttonPopUp
            label: "Show popup"

            onButtonClick: {
                Qt.createComponent("PopupAck.qml").createObject(mainScreen, {});
            }
        }

        ButtonAck {
            id: buttonHelloScreen
            label: "Hello World"


            onButtonClick: {
                handlerLoader("WindowHello.qml")
            }
        }
    }
}

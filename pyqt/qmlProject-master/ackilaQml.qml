/*
 * Date: 09MAR2013
 * Author: Alexandre BUJARD
 *
 * Description: qml exercise for ackila :

    3.	Create a qml welcome screen (800x600 resolution) that has 3 buttons
        that are stack vertically in the middle of the screen
    4.	Display “Welcome” text on the top right of the welcome screen
    5.	Button A – on click, toggle the color of the button
    6.	Button B – on click, open a popup menu (200x200) that has a close button
        (on click, clear the popup)
    7.	Button C – on click, open a hello world screen.
    a.	Create a hello world screen (800x600)
    b.	Create a button in the middle of the screen, on click, it goes back to
        welcome screen.
    c.	Create a text “Hello world” in the button but display the text as
        “Hello w…” in the middle of the screen in blue color. Hint,
        text box size and text elide mode

*/
import QtQuick 1.1

Item {
    id: mainScreen
    width: 800
    height: 600

    Loader{id:window}
    signal handlerLoader(string name)

    Loader {
         id:pageLoader
         source:"WindowWelcome.qml"
     }

    Connections {
        //target: pageLoader.item
        onHandlerLoader: {
            pageLoader.source = name;
        }
    }
}


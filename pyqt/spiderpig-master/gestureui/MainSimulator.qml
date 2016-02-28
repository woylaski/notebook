import QtQuick 1.0
import "simplemenuexample.js" as MenuModel

Rectangle {

    width: screen.width
    height: screen.height

    Component.onCompleted: {
        //console.log(MenuModel.menuTree[0][0].name);
        MenuModel.printNode(MenuModel.menuTree);
    }

    GestureSimulator {
        id: gestureProvider
    }

    Screen {
        id: screen
        phoneHandler: phoneHandler
        gestureProvider: gestureProvider
    }

    MockPhoneHandler {
        id: phoneHandler
    }

}

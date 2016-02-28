import QtQuick 2.1;
import QtQuick.Window 2.1;

Window {
    title: "Give'me";
    Component.onCompleted: {
        if (Qt.platform.os === "android" || Qt.platform.os === "ios") {
            visibility = Window.Maximized;
        }
        else {
            width = 540;
            height = 640;
            x = (Screen.desktopAvailableWidth  - width)  / 2;
            y = (Screen.desktopAvailableHeight - height) / 2;
            visibility = Window.Windowed;
        }
    }

    GiveMe { }
}

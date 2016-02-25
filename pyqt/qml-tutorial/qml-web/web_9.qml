import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
//import Ubuntu.Components 0.1


Window {
    id: main
    width: 640
    height: 480

    Rectangle {
        color: "lightgreen"
        anchors.fill: parent
        WebView {
            id: webView
            anchors.fill: parent
            experimental.transparentBackground: true
        }
    }

    Component.onCompleted: webView.loadHtml("<p>Hello world</p>");
}
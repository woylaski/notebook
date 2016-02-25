import QtQuick 2.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
Rectangle {
    width: 1024
    height: 768
    WebView{
        url: "http://localhost"
        anchors.fill: parent
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.onMessageReceived: {
            console.debug("get msg from javascript")
            experimental.postMessage("HELLO")
        }
    } // webview
} //
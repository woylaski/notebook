import QtQuick 2.2
import QtWebKit 3.0
import QtWebKit.experimental 1.0

Rectangle {
    width: 800
    height: 600

    WebView {
        url: "http://stackoverflow.com/"
        anchors.fill: parent

        // Enable communication between QML and WebKit
        experimental.preferences.navigatorQtObjectEnabled: true;

        // When the document loads, post the outerHTML back to the QML layer.
        onLoadingChanged: {
            if (loadRequest.status === WebView.LoadSucceededStatus) {
                experimental.evaluateJavaScript(
                    "navigator.qt.postMessage(document.documentElement.outerHTML)");
            }
        }

        // When we get the message, dump the string data to the console.
        experimental.onMessageReceived: {
            console.log(message.data);
        }
    }
}
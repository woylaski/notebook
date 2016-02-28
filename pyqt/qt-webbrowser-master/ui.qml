import QtQuick 2.4;
import QtWebEngine 1.0;
import QtQuick.Window 2.1;
import QtQuick.Layouts 1.1;
import QtQuick.Controls 1.2;

ApplicationWindow {
    id: window;
    width: 1280;
    height: 800;
    visible: true;
    toolBar: ToolBar {
        height: 48;

        RowLayout {
            spacing: 6;
            anchors {
                left: parent.left;
                right: parent.right;
                margins: 6;
                verticalCenter: parent.verticalCenter;
            }

            ToolButton {
                enabled: webview.canGoBack;
                opacity: (enabled ? 1.0 : 0.35);
                iconSource: "icons/previous.svg";
                implicitWidth: 36;
                implicitHeight: 36;
                onClicked: { webview.goBack (); }
            }
            ToolButton {
                enabled: webview.canGoForward;
                opacity: (enabled ? 1.0 : 0.35);
                iconSource: "icons/next.svg";
                implicitWidth: 36;
                implicitHeight: 36;
                onClicked: { webview.goForward (); }
            }
            TextField {
                id: inputUrl;
                placeholderText: qsTr ("URL");
                onAccepted: {
                    var found = false;
                    ["http://", "https://", "ftp://", "file://"].forEach (function (scheme) {
                        if (text.indexOf (scheme) === 0) {
                            found = true;
                        }
                    });
                    webview.url = (!found ? "http://" + text : text);
                }
                Layout.fillWidth: true;
            }
            TextField {
                placeholderText: qsTr ("Search...");
            }
            ToolButton {
                iconSource: (webview.loading ? "icons/stop.svg" : "icons/refresh.svg");
                implicitWidth: 36;
                implicitHeight: 36;
                onClicked: {
                    if (webview.loading) {
                        webview.stop ();
                    }
                    else {
                        webview.reload ();
                    }
                }
            }
        }
    }
    statusBar: StatusBar {
        height: 30;

        RowLayout {
            spacing: 6;
            anchors {
                left: parent.left;
                right: parent.right;
                margins: 6;
                verticalCenter: parent.verticalCenter;
            }

            Image {
                source: webview.icon;
                width: 16;
                height: 16;
                sourceSize: Qt.size (width, height);
            }
            Label {
                text: webview.title;
                Layout.fillWidth: true;
            }
            ProgressBar {
                value: webview.loadProgress;
                visible: webview.loading;
                minimumValue: 0;
                maximumValue: 100;
                Layout.fillWidth: true;
            }
        }
    }

    WebEngineView {
        id: webview;
        url: "http://www.google.com";
        anchors.fill: parent;
        onUrlChanged: { inputUrl.text = url.toString (); }
    }
}


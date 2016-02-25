import QtQuick 2.3
import QtQuick.Window 2.2
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import QtQuick.Controls 1.2

Window {
    id: mainWindow
    visible: true
    width: 360
    height: 360

    Rectangle{
        id: mainRect
        anchors.fill: parent

        WebView {
            id: webview

            url: "file:///index_6.html"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: parent.height-50

            interactive: false
            focus: true

            contentWidth: webview.width
            contentHeight: webview.height

            experimental.preferences.javascriptEnabled: true
        }

        Button{
            id: btn

            anchors.top: webview.bottom
            anchors.left:parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            text: "Push"
            height: 50

            onClicked: {
                webview.experimental.evaluateJavaScript("var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
                    var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    title: 'Hello World!'
                });");
            }

        }
    }
}

import QtQuick 1.1
import QtWebKit 1.0

Rectangle {
    width: 800
    height: 600
    WebView {
        anchors.centerIn: parent
        preferredWidth: 400
        preferredHeight: 400
        url: "http://www.vg.no"
    }
}

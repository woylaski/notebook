import QtQuick 2.4
import QtQuick.Window 2.2
import QtWebView 1.0
import QtQuick.Controls 1.3

Rectangle{
    id:webBase;
    width: 1200;
    height: 700;

    WebView {
       id: webVie1;
       anchors.fill: parent;
       url: ("https://www.baidu.com");
    }
}

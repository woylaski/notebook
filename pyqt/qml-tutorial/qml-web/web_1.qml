import QtQuick 2.0
import MuseScore 1.0
import QtWebKit 3.0
import FileIO 1.0
MuseScore {
    menuPath: "Plugins.ABC Web"
    onRun: {}
  FileIO {
        id: myFile
        source: tempPath() + "/my_file.xml"
        onError: console.log(msg)
    }
   WebView {
        javaScriptWindowObjects: QtObject {
            WebView.windowObjectName: "qml"
             function qmlCall(abc) {
                var doc = new XMLHttpRequest()
                var url = "http://abc2musicxml.appspot.com/abcrenderer?abc=" + encodeURIComponent(abc);
                doc.onreadystatechange = function() {
                    if (doc.readyState == XMLHttpRequest.DONE) {
                        var a = doc.responseText;
                        myFile.write(a);
                        readScore(myFile.source);
                        Qt.quit();
                    }
                }
                doc.open("GET", url);
                doc.send()
            }
        }
        preferredWidth: 490
        preferredHeight: 400
        settings.javascriptEnabled:true
        html: "<html><head></head><body>Enter your ABC below <br/><div><textarea id='content' name='content' rows='15' cols='60'></textarea></div><div><a href="http://ddzhj.com/topic/55653ad90fe39eaf0e67c5bd" onClick=\"window.qml.qmlCall(document.getElementById('content').value);\">Convert</a></div></body></html>"
    }
}
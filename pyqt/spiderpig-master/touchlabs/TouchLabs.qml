import QtQuick 1.1
import "touchlabs.js" as UrlHelper

Rectangle {
    id: touchLabs

    width: 800
    height: 480
    color: "white"

    property variant urlField : bar.urlField
    property string helpMessage : "T O U C H L A B S \
    \n\nEnter URL for image or qml file to load. \
    \n\nEg: http://intranet/~BigLebowkski/rug.png \
    \n\nShortcut: ~ will be substituted with http://rdintranet.rd.tandberg.com/~ \
    \n\nTouch inactive screen areas to show / hide url bar. \
    \n\nTo enable/disable: call touchlab:on or touchlab:off"

    property string infoMessage : helpMessage

    signal quit()
    signal updateKeyboard(bool showKeyboard)

    function loadResource(url) {
        urlField.text = url;
        url = urlField.text; // Strange hack to convert url to proper javascript string object if func is called from c++/qt
        url = url.trim();

        infoMessage = "";

        remoteQmlLoader.source = "";
        imageViewer.source = "";

        url = lookForAbbreviatedUrl(url);
        var type = url.split('.').pop().toLowerCase();
        console.log("type='" + type + "'");

        if (url.length < 1) {
            infoMessage = "Enter URL for qml file or image"
            return false;
        }
        else if (! UrlHelper.isFile(url)) {
            return showFolder(url);
        }
        else if (type == "jpg" || type == "jpeg" || type == "png" || type == "gif")
            return loadImage(url)
        else if (type == "qml")
            return loadQml(url);
        else
            return notSupportedType(url);
    }

    function showFolder(url) {
        console.log("show folder " + url);
        fileBrowser.openFolder(url);
        return true;
    }

    function loadQml(url) {
        //console.log("Load qml: " + url);
        remoteQmlLoader.source = url + randomParamToAvoidCaching();
        if (remoteQmlLoader.status == Loader.Error) {
            infoMessage = "Error loading QML file " + url;
            return false;
        }

        return true;
    }

    function loadImage(url) {
        //console.log("Load image: " + url);
        imageViewer.source = url + randomParamToAvoidCaching();
        if (imageViewer.status == Image.Error) {
            infoMessage = "Couldn't find image " + url;
            return false;
        }
        return true;
    }

    function lookForAbbreviatedUrl(url) {
        var homeFolderTilde = "~";
        if (url[0] == homeFolderTilde)
            url = "http://rdintranet.rd.tandberg.com/" + url;
        return url;
    }

    function notSupportedType(url) {
        infoMessage = "Sorry TouchLabs doesn't know how to handle" + url;
        return false;
    }

    function randomParamToAvoidCaching() {
        return "?" + Math.random() + "=1";
    }

    MouseArea {
        id: clickDetectorToToggleUrlbar
        anchors.fill: parent
        onClicked: {
            bar.visible = ! bar.visible;
            touchLabs.updateKeyboard(false);
        }
    }

    Browser {
        id: fileBrowser
        anchors.centerIn: parent
        visible: infoMessage.length < 1
        color: "#eeeeee"
        border {width: 1; color: "#bbbbbb"}
        width: 500
        height: 300
        onFileSelected: loadResource(folder + fileName)
        onFolderSelected: urlField.text = folder
    }

    Image {
        id: imageViewer
        anchors.fill: parent
        visible: infoMessage.length < 1
    }

    Loader {
        id: remoteQmlLoader
        anchors.centerIn: parent
        visible: infoMessage.length < 1
    }

    Rectangle {
        id: infoPanel
        anchors.centerIn: parent
        color: "#eeeeee"
        border {width: 1; color: "#bbbbbb"}
        width: info.width + 50
        height: info.height + 50
        visible: infoMessage.length > 0

        Text {
            id: info
            anchors.centerIn: parent
            text: infoMessage
        }
    }

    UrlBar {
        id: bar
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        onLoadUrl: {
            bar.visible = ! loadResource(url);
        }
        onQuit: {
            touchLabs.updateKeyboard(false);
            touchLabs.quit();
        }
        onUpdateKeyboard: touchLabs.updateKeyboard(updateKeyboard)
    }

    /*
    MouseArea {
        id: doubleClickDetectorToOpenUrlBar
        anchors.fill: parent
        onDoubleClicked: {
            //console.log("TouchLabs:Double click");
            bar.visible = ! bar.visible;
            mouse.accepted = false;
        }
        onClicked: mouse.accepted = false;
        onPressed: mouse.accepted = false;
    }*/
}

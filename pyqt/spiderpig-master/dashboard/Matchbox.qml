import QtQuick 1.1
import "webquery.js" as WebQuery


Rectangle {
    id: matchbox

    property Theme theme : Theme{}
    property int refreshSeconds: 30
    property int pad: theme.tilePad
    property bool allOk : true
    property string products: "endeavour, charlie, helmet, snoopy"

    width: theme.tileWidth
    height: theme.tileHeight
    color: allOk ? theme.themeColor : "red"

    AudioPlayer {id:audio}
    onAllOkChanged: {
        if (!allOk) audio.play("doh.wav");
    }

    function update() {
        var query = "matchbox status " + products
        WebQuery.getData(query, onDataReceived, serverDown);
    }

    function serverDown() {
        console.log("No reply from server");
        allOk = false;
        serverDownMessage.visible = true;
    }

    function onDataReceived(data) {
        //WebQuery.inspect(data);
        serverDownMessage.visible = false
        exampleModel.clear();
        var ok = true;
        for (var key in data) {
            exampleModel.append( {
                "name": key,
                "ok": (data[key] == "OK"),
                "pending": false // TODO-tbj implement!
            });
            if (data[key] != "OK")
                ok = false;
        }

        allOk = ok;
    }

    Timer {
        onTriggered: {update()}
        interval: refreshSeconds * 1000;
        repeat: true
        triggeredOnStart: true
        running: true
    }

    Image {
        id: thumbsStatusSymbol
        source: allOk ? "thumbs-up.png" : "thumbs-down.png"
        fillMode: Image.PreserveAspectFit
        width: 60
        anchors {top: parent.top; left: parent.left; margins: theme.tilePad}
    }

    Text {
        id: matchboxLabel
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: 15
        anchors {bottom: parent.bottom; left: parent.left; margins: theme.tilePad}
        color: theme.fontColor
        text: "Matchbox"
    }

    ListModel {
        id: exampleModel
        ListElement {name: "Endeavour"; ok: true; pending: false}
        ListElement {name: "Charlie"; ok: false; pending: true}
        ListElement {name: "Helmet"; ok: true; pending: true}
        ListElement {name: "Snoopy"; ok: true; pending: false}

    }

    Component {
        id: componentStatus
        Rectangle {
            height: 20
            width: parent.width
            color: matchbox.color
            Text {
                id: statusLabel
                text: name
                color: theme.fontColor
                font.family: theme.fontFamily
                opacity: pending ? 0.6 : 1.0
            }
            Text {
                x: parent.width - 35
                font.family: theme.fontFamily
                color: theme.fontColor
                opacity: statusLabel.opacity
                text: (ok ? "OK" : "FAIL")
            }
        }
    }

    Rectangle {
        id: statues
        anchors {right: parent.right; top: parent.top; margins: theme.tilePad; left: matchboxLabel.right; bottom: matchboxLabel.top}
        color: parent.color

        ListView {
            anchors.fill: parent
            model: exampleModel
            delegate: componentStatus
            visible: ! serverDownMessage.visible
        }
        Text {
            id: serverDownMessage
            anchors.fill: parent
            visible: false
            color: "white"
            text: "Server down?"
        }
    }

/*
    Text {
        id: stockId
        anchors {right: parent.right; top: parent.top; margins: pad}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeMedium-2
        text: "NASDAQ:CSCO"
    }

    Text {
        id: change
        anchors {right: parent.right; top: stockId.bottom; margins: pad}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: false
        font.pixelSize: theme.fontSizeSmall
        text: ""
    }

    Text {
        id: logo
        anchors {left: parent.left; bottom: parent.bottom; margins: pad}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeBig * 2
        text: "$"
    }

    Text {
        id: stockValue
        color: theme.fontColor
        anchors {right: parent.right; bottom: parent.bottom; margins: pad}
        font.family: theme.fontFamily
        text: ""
        font.pixelSize: theme.fontSizeBig
        font.bold: true
    }
*/
}

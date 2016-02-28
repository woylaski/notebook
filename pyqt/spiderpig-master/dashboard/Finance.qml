import QtQuick 1.0
import "finance.js" as Stocks

Rectangle {
    id: main

    property Theme theme : Theme{}
    property string ticker: "NASDAQ:CSCO"
    property int refreshSeconds: 600
    property int pad: theme.tilePad

    width: theme.tileWidth
    height: theme.tileHeight
    color: theme.themeColor

    function getStockData() {
        Stocks.getCiscoStock(setStockData, main.ticker);
    }
    function setStockData(data) {
        //console.log("Got stock data for " + main.ticker);
        stockValue.text = data.l
        stockId.text = data.e + ":" + data.t
        change.text = data.c + "/" + data.cp + "%"
    }

    Timer {
        onTriggered: {getStockData();}
        interval: refreshSeconds * 1000;
        repeat: true
        triggeredOnStart: true
        running: true
    }

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

}

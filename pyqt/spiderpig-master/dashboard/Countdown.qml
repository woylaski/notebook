import QtQuick 1.0

Rectangle {
    id: main

    property Theme theme : Theme{}
    property int refreshSeconds: 1
    property int pad: theme.tilePad

    property date countdownDateTime: now()
    property alias countdownImage: image

    width: theme.tileWidth
    height: theme.tileHeight
    color: theme.themeColor

    function refresh() {
        days.text = daysRemaining() + " days";
        hours.text = hoursRemaining() + " hours";
        minutes.text = minutesRemaining() + " minutes";
        seconds.text = secondsRemaining() + " seconds";
    }

    function now() {
        var weekMs = 1000*60*60*24*7;
        return new Date(new Date().getTime() + weekMs);
    }

    function daysRemaining() {
        var remaining = countdownDateTime.getTime() - new Date().getTime();
        var dayMs = 1000*60*60*24;
        return Math.floor(remaining / dayMs);
    }

    function hoursRemaining() {
        var remaining = countdownDateTime.getTime() - new Date().getTime();
        var hoursMs = 1000*60*60;
        return Math.floor(remaining / hoursMs);
    }

    function minutesRemaining() {
        var remaining = countdownDateTime.getTime() - new Date().getTime();
        var minutesMs = 1000*60;
        return Math.floor(remaining / minutesMs);
    }

    function secondsRemaining() {
        var remaining = countdownDateTime.getTime() - new Date().getTime();
        var secondsMs = 1000;
        return Math.floor(remaining / secondsMs);
    }

    Timer {
        onTriggered: {refresh();}
        interval: refreshSeconds * 1000;
        repeat: true
        triggeredOnStart: true
        running: true
    }

    Image {
        id: image
        anchors {top: parent.top; left:parent.left; right: parent.right; margins: 0}
    }

    Text {
        id: days
        anchors {left: parent.left; bottom: parent.bottom; margins: pad;}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeMedium-8
        text: "Days: " + daysRemaining();
    }

    Text {
        id: hours
        anchors {left: days.right; bottom: parent.bottom; margins: pad; leftMargin: 2}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeMedium-8
        text: "Hours: " + hoursRemaining();
    }

    Text {
        id: minutes
        anchors {left: hours.right; bottom: parent.bottom; margins: pad; leftMargin: 2}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeMedium-8
        text: "Min: " + minutesRemaining();
    }

    Text {
        id: seconds
        anchors {left: minutes.right; bottom: parent.bottom; margins: pad; leftMargin: 2}
        color: theme.fontColor
        font.family: theme.fontFamily
        font.bold: true
        font.pixelSize: theme.fontSizeMedium-8
        text: "Sec: " + secondsRemaining();
    }

}

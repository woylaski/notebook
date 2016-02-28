import QtQuick 1.1

Rectangle {

    property string yrPath : "Norway/Oslo/Oslo/Oslo"
    property string yrPlacePath : "http://www.yr.no/place/" +yrPath + "/meteogram.png"
    property Theme theme: Theme{}
    property real minutesBetweenUpdate: 60

    width: theme.tileWidth*2 + theme.tileSpacing
    height: theme.tileHeight
    color: theme.themeColor


    Image {
        source: yrPlacePath
        anchors.fill: parent
        smooth: true
        cache: false
    }

    Timer {
        running:true;
        interval: minutesBetweenUpdate*60*1000;
        repeat: true
        onTriggered: refreshImage()
    }

    function refreshImage() {
        var tmp = yrPlacePath
        yrPlacePath = "";
        yrPlacePath = tmp // hackish, but don't know any other way
    }
}

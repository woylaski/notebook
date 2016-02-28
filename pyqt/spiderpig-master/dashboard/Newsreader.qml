import QtQuick 1.0

Rectangle {
    id: main

    property color themeColor: "green"
    property color textColor: "white"
    property string fontType: "Helvetica"
    property int headingFontSize: main.headingFontSize
    property int subFontSize: 12

    property string urlLogo
    property variant xmlModel
    property real secondsPerArticle: 6
    property int scrollSpeed: 50

    width: 400
    height: 400
    color: themeColor
    clip: true

    Timer {
        interval: secondsPerArticle*1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            advanceList();
        }
    }

    function advanceList() {
        //console.log('count:' + newsList.currentIndex + "/" + newsList.count);
        if (newsList.count <= 0)
            return;

        if (newsList.currentIndex >= newsList.count-1)
        {
            scrollSpeed = scrollSpeed * 10; // scroll back quicker
            newsList.incrementCurrentIndex();
            xmlModel.reload();
            newsList.positionViewAtIndex(0, ListView.Beginning); // strangely, needed. qt bug?
            scrollSpeed = scrollSpeed / 10;
       }
       else {
           newsList.incrementCurrentIndex();
       }
    }

    ListView {
        id: newsList
        anchors {left: parent.left; right: logo.left; margins: theme.tilePad
                top: parent.top; bottom: parent.bottom}
        model: xmlModel
        delegate: newsLine
        highlightFollowsCurrentItem: true
        keyNavigationWraps: true
        highlightMoveSpeed: scrollSpeed
        clip: true
    }

    Image {
        id: logo
        width: 25;// height: 100
        fillMode: Image.PreserveAspectFit
        //smooth: true
        anchors.right: parent.right
        anchors.rightMargin: theme.tilePad
        anchors.bottom: parent.bottom
        anchors.bottomMargin: theme.tilePad

        source: urlLogo
    }

    Component {
        id: newsLine

        Rectangle {
            id: newsScroller
            width: newsList.width
            height: childrenRect.height;//newsList.height;
            color: main.themeColor

            Text {
                id: newsItem
                anchors.left: parent.left
                text: title
                width: parent.width
                color: textColor
                font.family: main.fontType
                font.pixelSize: subFontSize
                font.bold: true
                wrapMode: Text.Wrap
            }
            Text {
                id: newsText
                anchors {top: newsItem.bottom; topMargin: 5; left: newsItem.left; right: parent.right}
                width: parent.width
                color: newsItem.color
                font.pixelSize: subFontSize
                text: description
                font.family: main.fontType
                wrapMode: Text.Wrap
                visible: text.trim().length > 0
            }
        }

    }

}


/*
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>aftenposten.no - Aftenposten</title>
<link>http://www.aftenposten.no/</link>
<description>
Nyheter fra aftenposten.no
</description>
<atom:link href="http://www.aftenposten.no/rss" rel="self" type="application/rss+xml" />
<item>
<title>PST-sjefen taus om avgangen</title>
<description>Hverken avtroppende leder Janne Kristiansen eller noen andre i Politiets sikkerhetstjeneste (PST) ønsker foreløpig å kommentere avgangen etter etterretningsuttalelsene.
</description>
<dc:date>2012-01-19T12:53+01:00</dc:date>

<guid>http://www.aftenposten.no/nyheter/iriks/PST-sjefen-taus-om-avgangen-6745038.html</guid>
<pubTime>12:53:21</pubTime>
<link>http://www.aftenposten.no/nyheter/iriks/PST-sjefen-taus-om-avgangen-6745038.html#xtor=RSS-3</link>
</item>
<item>
<title>Savnet kvinne funnet omkommet i Ulsteinvik</title>
<description>Den savnede 85 år gamle kvinnen som politiet har lett etter i Ulsteinvik på Sunnmøre siden natt til torsdag, ble funnet omkommet i 12-tiden torsdag.
</description>
<dc:date>2012-01-19T12:52+01:00</dc:date>
<guid>http://www.aftenposten.no/nyheter/iriks/Savnet-kvinne-funnet-omkommet-i-Ulsteinvik-6745045.html</guid>
<pubTime>12:52:34</pubTime>

<link>http://www.aftenposten.no/nyheter/iriks/Savnet-kvinne-funnet-omkommet-i-Ulsteinvik-6745045.html#xtor=RSS-3</link>
</item>
<item>
<title>Hangeland anmeldte Solbakken til FIFA </title>
<description>Pengekrangel mellom Fulham-proffen og eks-agenten.
</description>
<dc:date>2012-01-19T12:37+01:00</dc:date>
<guid>http://fotball.aftenposten.no/england/article220526.ece</guid>
<pubTime>12:37:04</pubTime>
<link>http://fotball.aftenposten.no/england/article220526.ece#xtor=RSS-3</link>
.....
*/

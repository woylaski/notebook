import QtQuick 2.5
import "engine.js" as Engine

Item {
    id: container

    property var selectedtext
    property var textarray
    property int wordsPerMin: 300

    onSelectedtextChanged: parseText()

    function parseText()
    {
        if(selectedtext != "")
        {
            Engine.WPM = wordsPerMin
            console.debug("Parsing: " +selectedtext);
            textarray = Engine.getTextArray(1, selectedtext, 1);
            readTimer.interval = textarray[0].duration
        }
    }

    function play()
    {
        readTimer.start()
    }

    function nextWord()
    {
        if(textarray[readerView.currentIndex+1] != undefined)
        {
            readerView.currentIndex++
            readTimer.interval = textarray[readerView.currentIndex].duration
        }
        else
        {
            readTimer.stop()
        }
    }

    Timer {
        id: readTimer
        interval: 1000
        triggeredOnStart: false
        onTriggered: nextWord()
        repeat: true
    }

    ListView{
        id: readerView
        anchors.fill: parent
        model: textarray
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        highlightMoveDuration: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin:0
        preferredHighlightEnd: container.width

        delegate: Rectangle {
            width:container.width + 1
            height:container.height
            MouseArea {
                anchors.fill: parent
                onClicked: readTimer.running ? readTimer.stop() : readTimer.start()
            }
            Text{
                font.pointSize: 20
                width: paintedWidth
                height: paintedHeight
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: (container.width / 2) - txtMetric.tightBoundingRect.width
                text: modelData.text
            }
            TextMetrics{
                id: txtMetric
                font.pointSize: 20
                text: modelData.text.substring(0,modelData.optimalletterposition)
            }
        }
    }
}

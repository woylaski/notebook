import QtQuick 2.0

MouseArea {
    id: page;
    width: parent.pageWidth;
    height: parent.pageHeight;

    property color backgroundColor: prez.backgroundColor;
    property string backgroundImg: prez.backgroundImg;
    property Component transition;
    property string title: "";
    property int pageNumber: -1;
    property bool showPageNumber: prez.showPageNumber;


    Rectangle {
        anchors.fill: parent;
        color: backgroundColor;
    }

    Image {
        anchors.fill: parent;
        source: backgroundImg;
    }
    Text {
        anchors.centerIn: parent;
        anchors.verticalCenterOffset: -page.height * 0.3;
        text: title;
        font.pixelSize: page.height * 0.1;
    }

    Text {
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        anchors.margins: page.height * 0.1;
        text: pageNumber;
        font.pixelSize: page.height * 0.05;
        visible: showPageNumber && pageNumber !== -1;
    }

    signal pageClicked(var page);

    onClicked: pageClicked(page);
}



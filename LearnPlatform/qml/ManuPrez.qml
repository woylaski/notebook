import QtQuick 2.0;
import QtQuick.Window 2.1;
import "."

Window {
    id:prez;
    width: 100;
    height: 100;
    visible: true;
    visibility: fullscreen ? 5 : 2;

    property bool fullscreen: false;
    property list<ManuPrezPage> pages;
    property ManuPrezPage currentPage: null;
    property int gridColumns: 3;

    //property Theme  theme:           Theme {}
    property color  backgroundColor: Theme.backgroundColor;
    property string backgroundImg:   Theme.backgroundImg;
    property bool   showPageNumber:  Theme.showPageNumber;


    Item {
        id: prezItem;
        focus: true;

        Keys.onPressed: {
            if (event.key === Qt.Key_Escape) { prez.fullscreen = false; }
            if (event.key === Qt.Key_F5)     { prez.fullscreen = true; }
        }
    }

    ManuPrezPageView{
        anchors.fill: parent;
        fullscreen: prez.fullscreen;
        pages: prez.pages;
        currentPage: prez.currentPage;
    }
}


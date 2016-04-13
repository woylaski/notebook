import QtQuick 2.0

Item {
    id: pageView;
    property bool fullscreen: false;
    property list<ManuPrezPage> pages;
    property ManuPrezPage currentPage: null;

    function pageClicked(page) {
        console.debug(page, "clicked");
        var index;
        for (var i = 0; i < pages.length; i++) {
            if (pages[i] === page) { index = i; break; }
        }
        if (fullscreen) { currentPage = pages[(index + 1) % pages.length]; }
        else { currentPage = page }
    }

    function fullscreenChange() {
        if (fullscreen) {
            flickable.visible = false;
            for (var i = 0; i < pages.length; i++) {
                var page = pages[i];
                page.parent = fullscreenView;
                page.visible = false;
                page.x = 0;
                page.y = 0;
            }
            currentPage.visible = true;
            currentPage.z = 1000;
        }
        else {
            flickable.visible = true;
            for (var i = 0; i < pages.length; i++) {
                var page = pages[i];
                page.parent = gridView;
                page.visible = true;
            }
        }
    }

    function changeCurrentPage() {
        if (fullscreen) {
            var previousPage;
            for (var i = 0; i < pages.length; i++) {
                var page = pages[i];
                if (page.visible) { previousPage = page; break; }
            }
            if (currentPage.transition !== null) {
                currentPage.transition.createObject(pageView, {"previousPage":previousPage, "nextPage": currentPage, "container":fullscreenView})
            }
            else {
                previousPage.visible = false;
                currentPage.visible = true;
            }
        }
    }


    Rectangle {
        id: selection;
        parent: pageView.currentPage;
        anchors.fill: parent;
        color: "transparent";
        border.width: 5;
        border.color: "grey";
        visible: !pageView.fullscreen;
    }

    Item {
        id: fullscreenView;
        x: 0;
        y: 0;
        width: pageView.width;
        height: pageView.height;

        property int pageWidth: width;
        property int pageHeight: height;
    }

    Flickable {
        id: flickable;
        anchors.fill: parent;
        contentWidth: parent.width;
        contentHeight: gridView.height;

        Rectangle {
            id: back;
            x: 0;
            y: 0;
            width: parent.contentWidth;
            height: parent.contentHeight;
            color: pageView.fullscreen ? "black" : "#eeeeee";
        }

        Grid {
            id: gridView;
            x: spacing / 2;
            y: spacing / 2;
            width: parent.width;
            height: (pageHeight + spacing) * Math.floor(pages.length / columns + 1);
            columns: 3;
            spacing: 10;
            visible: !fullscreen;

            property int pageWidth: width / columns - spacing;
            property int pageHeight: pageView.height * pageWidth / width;
        }

    }

    onCurrentPageChanged: { changeCurrentPage() }
    onFullscreenChanged:  { fullscreenChange() }

    Component.onCompleted: {
        for (var i = 0; i < pages.length; i++) {
            var page = pages[i];
            page.parent = gridView;
            if (page.pageNumber === -1) {
                page.pageNumber = i + 1;
            }
            page.pageClicked.connect(function(page) { pageClicked(page) });
        }
        currentPage = pages[0]
    }
}


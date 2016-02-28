import QtQuick 2.1;
import QtQuick.Window 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;
import "pages";

Window {
    id: window;
    title: qsTr ("GIT UI Tool");
    color: Style.colorWindow;
    width: 1280;
    height: 640;
    minimumWidth: 1024;
    minimumHeight: 600;
    Component.onCompleted: { show (); }
    Component.onDestruction: { Qt.quit (); }
    onCurrentReposObjChanged: { timer.restart (); }

    readonly property color  fgColorNormal     : "#000000"; // black
    readonly property color  fgColorUrl        : "#113487"; // dark blue
    readonly property color  fgColorUnchanged  : "#1A1A1A"; // dark gray
    readonly property color  fgColorDeleted    : "#9F2727"; // dark red
    readonly property color  fgColorModified   : "#754400"; // dark yellow
    readonly property color  fgColorUntracked  : "#1F7A1F"; // dark green
    readonly property color  fgColorIgnored    : "#B3B3B3"; // medium gray
    readonly property color  fgColorSubChange  : "#113487"; // dark blue
    readonly property color  fgColorBase       : "#4B3621"; // dark coffee

    readonly property color  bgColorUrl        : "#FFFFFF"; // white
    readonly property color  bgColorUnchanged  : "#FCFDFF"; // light blue
    readonly property color  bgColorDeleted    : "#FED3D3"; // light red
    readonly property color  bgColorModified   : "#FFD774"; // light yellow
    readonly property color  bgColorUntracked  : "#C4F2C4"; // light green
    readonly property color  bgColorIgnored    : "#E6E6E6"; // light gray
    readonly property color  bgColorSubChange  : "#A7C1FF"; // light blue

    property Group      currentPageItem : (Shared.isReposOpened ? pageRepository : pageWelcome);
    property Repository currentReposObj : Shared.gitReposObj;

    function getGravatarImgUrl (email, size) {
        var hash = Qt.md5 ((email || "").trim ().toLowerCase ());
        return "http://www.gravatar.com/avatar/%1.jpg?s=%2".arg (hash).arg (size || 20);
    }

    Item {
        states: State {
            when: (Style !== null);

            PropertyChanges {
                target: Style;
                fontSizeSmall: 11;
                fontSizeNormal: 14;
                fontSizeBig: 18;
                fontSizeTitle: 18;
                colorSelection: "#46311B";
                colorHighlight: "#8F6336";
            }
        }
    }
    Timer {
        id: timer;
        repeat: false;
        running: false;
        interval: 500;
        onTriggered: {
            if (currentReposObj !== null) {
                currentReposObj.refreshRemotes          ();
                currentReposObj.refreshBranches         ();
                currentReposObj.refreshTags             ();
                currentReposObj.refreshCommits          ();
                currentReposObj.refreshWorkingDirectory ();
            }
        }
    }
    Connections {
        target: Shared;
        onMessage: {
            switch (level) {
                case SharedObject.Debug:   console.debug ("DEBUG :", msg); break;
                case SharedObject.Info:    console.log   ("INFO  :", msg); break;
                case SharedObject.Warning: console.warn  ("WARN  :", msg); break;
                case SharedObject.Error:   console.error ("ERROR :", msg); break;
            }
        }
    }
    ToolBar {
        id: toolbar;

        Image {
            id: imgLogo;
            source: "img/logo@2x.png";
            anchors.verticalCenter: parent.verticalCenter;
        }
        Line {
            height: imgLogo.height;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Column {
            anchors.verticalCenter: parent.verticalCenter;

            Image {
                source: "img/logo_libgit2.png";
            }
            TextLabel {
                text: Shared.getGitLibVersion ();
                color: Style.colorBorder;
                font.pixelSize: Style.fontSizeSmall;
                anchors.right: parent.right;
            }
        }
    }
    Item {
        id: containerPages;
        anchors.fill: parent;
        anchors.topMargin: toolbar.height;

        PageWelcome {
            id: pageWelcome;
            visible: (currentPageItem === pageWelcome);
            anchors.fill: parent;
        }
        PageRepository {
            id: pageRepository;
            visible: (currentPageItem === pageRepository);
            anchors.fill: parent;
        }
    }
    DialogSelectRepo { id: dialogSelectRepo; }
}

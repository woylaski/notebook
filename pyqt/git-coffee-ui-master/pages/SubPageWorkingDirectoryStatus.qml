import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    id: layoutWorkingDirectoryStatus;
    spacing: 12;
    anchors {
        fill: parent;
        margins: 12;
    }

    property bool creatingCommit : false;

    MimeIconsHelper {
        id: mimeHelper;
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;

        TextLabel {
            text: qsTr ("Status of the working directory :");
            style: Text.Sunken;
            styleColor: Style.colorEditable;
            font.pixelSize: Style.fontSizeTitle;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Item { implicitWidth: -1; }
        TextButton {
            text: qsTr ("Refresh the view");
            icon: Image { source: "../icons/refresh.svg"; }
            anchors.verticalCenter: parent.verticalCenter;
            onClicked: { currentReposObj.refreshWorkingDirectory (); }
        }
    }
    ScrollContainer {
        showBorder: true;
        implicitHeight: -1;

        Flickable {
            clip: true;
            contentWidth: width;
            contentHeight: layout.height;

            StretchColumnContainer {
                id: layout;
                ExtraAnchors.topDock: parent;

                Repeater {
                    model: (currentReposObj ? currentReposObj.workTreeModel : 0);
                    delegate: StretchColumnContainer {
                        id: delegateStatus;
                        enabled: (creatingCommit || statusEntry.type !== StatusEntry.File);
                        visible: (creatingCommit
                                  ? (statusEntry.type !== StatusEntry.Folder && !statusEntry.unchanged && !statusEntry.ignored)
                                  : statusEntry.shown);

                        readonly property StatusEntry statusEntry : model.qtObject;

                        readonly property string colorForStatus : {
                            if (statusEntry.type === StatusEntry.File) {
                                if (statusEntry.ignored) {
                                    return "Ignored";
                                }
                                else {
                                    if (statusEntry.untracked) {
                                        return "Untracked";
                                    }
                                    else {
                                        if (statusEntry.unchanged) {
                                            return "Unchanged";
                                        }
                                        else if (statusEntry.deleted) {
                                            return "Deleted";
                                        }
                                        else /*if (statusEntry.modified || statusEntry.chmoded || statusEntry.moved)*/ {
                                            return "Modified";
                                        }
                                    }
                                }
                            }
                            else {
                                return (statusEntry.modified ? "SubChange" : "Url");
                            }
                        }

                        MouseArea {
                            height: implicitHeight;
                            implicitHeight: 30;
                            onClicked: {
                                if (creatingCommit) {
                                    layoutDeltas.opened = !layoutDeltas.opened;
                                    if (layoutDeltas.opened) {
                                        currentReposObj.loadDiffToHeadForStatus (delegateStatus.statusEntry);
                                    }
                                }
                                else {
                                    if (statusEntry.type === StatusEntry.Folder) {
                                        var currOpened     = statusEntry.opened;
                                        var currentSubPath = statusEntry.path;
                                        var currentNestLvl = statusEntry.nesting;
                                        for (var idx = 0; idx < currentReposObj.workTreeModel.count; idx++) {
                                            if (idx !== model.index) {
                                                var item = currentReposObj.workTreeModel.get (idx);
                                                if (currOpened) {
                                                    // close the folder, hide all children
                                                    if (item ["path"].indexOf (currentSubPath) === 0 && item ["nesting"] > currentNestLvl) {
                                                        item ["shown"]  = false;
                                                        item ["opened"] = false;
                                                    }
                                                }
                                                else {
                                                    // open the folder, show all first sub level children
                                                    if (item ["path"].indexOf (currentSubPath) === 0 && item ["nesting"] === currentNestLvl +1) {
                                                        item ["shown"]  = true;
                                                        item ["opened"] = false;
                                                    }
                                                }
                                            }
                                        }
                                        statusEntry.opened = !currOpened;
                                    }
                                }
                            }
                            onDoubleClicked: {
                                if (statusEntry.type === StatusEntry.SubModule) {
                                    var tmp = (currentReposObj.workingDirPath + statusEntry.path);
                                    console.log ("Launching external instance :", tmp);
                                    Shared.launchInAnotherInstance (tmp);
                                }
                            }

                            Rectangle {
                                color: window ["bgColor" + delegateStatus.colorForStatus];
                                opacity: (creatingCommit ? 0.65 : 1.0);
                                anchors.fill: parent;
                            }
                            Item {
                                id: spacer;
                                width: (creatingCommit ? height + 36 : statusEntry.nesting * 24);
                                height: 18;
                                anchors {
                                    left: parent.left;
                                    margins: 6;
                                    verticalCenter: parent.verticalCenter;
                                }

                                RegularPolygon {
                                    sides: 3;
                                    diameter: 12;
                                    angle: (layoutDeltas.visible ? 90 : 0);
                                    fillColor: "black";
                                    strokeSize: 0;
                                    visible: creatingCommit;
                                    anchors {
                                        verticalCenter: parent.verticalCenter;
                                        horizontalCenter: parent.left;
                                        horizontalCenterOffset: +15;
                                    }
                                }
                                CheckableBox {
                                    visible: creatingCommit;
                                    anchors {
                                        top: parent.top;
                                        right: parent.right;
                                        bottom: parent.bottom;
                                        rightMargin: 6;
                                    }
                                }
                            }
                            Rectangle {
                                color: "lightgray";
                                visible: creatingCommit;
                                width: Style.lineSize;
                                anchors {
                                    top: parent.top;
                                    left: spacer.right;
                                    bottom: parent.bottom;
                                }
                            }
                            Image {
                                id: imgIcon;
                                source: (statusEntry.type === StatusEntry.Folder
                                         ? (statusEntry.opened
                                            ? "../icons/open.svg"
                                            : "../icons/folder.svg")
                                         : (statusEntry.type === StatusEntry.SubModule
                                            ? "../icons/repos.svg"
                                            : "image://icon-theme/%1".arg (mimeHelper.getIconNameForUrl (uri))));
                                width: size;
                                height: size;
                                fillMode: Image.Stretch;
                                antialiasing: true;
                                anchors {
                                    left: spacer.right;
                                    margins: (creatingCommit ? 6 : 0);
                                    verticalCenter: parent.verticalCenter;
                                }

                                readonly property int  size : (Style.fontSizeNormal * 2);
                                readonly property url  uri  : Qt.resolvedUrl ("file://" +
                                                                              currentReposObj.workingDirPath +
                                                                              "/" +
                                                                              delegateStatus.statusEntry.path);
                            }
                            TextLabel {
                                text: statusEntry.path;
                                color: window ["fgColor" + delegateStatus.colorForStatus];
                                font.weight: ((statusEntry.type === StatusEntry.File
                                               ? !statusEntry.ignored && !statusEntry.unchanged
                                               : statusEntry.modified)
                                              ? Font.Bold
                                              : Font.Light);
                                anchors {
                                    left: imgIcon.right;
                                    right: parent.right;
                                    margins: 6;
                                    verticalCenter: parent.verticalCenter;
                                }
                            }
                        }
                        StretchColumnContainer {
                            id: layoutDeltas;
                            visible: (opened && creatingCommit);

                            property bool opened : false;

                            Repeater {
                                model: (layoutDeltas.visible ? delegateStatus.statusEntry.diffFromHead.deltaModel : 0);
                                delegate: StretchColumnContainer {
                                    id: delegateDelta;

                                    readonly property DeltaEntry deltaEntry : model.qtObject;

                                    Repeater {
                                        model: delegateDelta.deltaEntry.hunksModel;
                                        delegate: DelegateDeltaHunkEntry {
                                            deltaEntry: delegateDelta.deltaEntry;
                                            hunkEntry: model.qtObject;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    TextLabel {
        text: qsTr ("Message for the commit :");
        visible: creatingCommit;
        style: Text.Sunken;
        styleColor: Style.colorEditable;
        font.pixelSize: Style.fontSizeTitle;
    }
    MultiLineTextBox {
        visible: creatingCommit;
        padding: Style.spacingBig;
        textHolder: ("Type-in here a descriptive message for the commit...");
        implicitHeight: -1;
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: creatingCommit;

        Image {
            source: getGravatarImgUrl (Shared.getConfigValue ("user.email"), width);
            width: 24;
            height: width;
            anchors.verticalCenter: parent.verticalCenter;

            Rectangle {
                z: -1;
                color: "lightgray";
                anchors.fill: parent;
            }
        }
        TextLabel {
            text: Shared.getConfigValue ("user.name");
            color: fgColorBase;
            font.underline: true;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Item { implicitWidth: -1; }
        GridContainer {
            cols: capacity;
            capacity: 2;
            colSpacing: Style.spacingNormal;
            anchors.verticalCenter: parent.verticalCenter;

            TextButton {
                text: qsTr ("Cancel commit");
                icon: Image { source: "../icons/close.svg"; }
                onClicked: { creatingCommit = false; }
            }
            TextButton {
                text: qsTr ("Commit selection");
                icon: Image { source: "../icons/apply.svg"; }
            }
        }
    }
}

import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    spacing: Style.spacingBig;
    anchors {
        fill: parent;
        margins: Style.spacingBig;
    }
    onCurrentCommitEntryChanged: {
        if (currentCommitEntry) {
            currentReposObj.loadDetailsForCommit (currentCommitEntry);
        }
    }

    property bool        pullingCommits     : false;
    property bool        pushingCommits     : false;
    property CommitEntry currentCommitEntry : null;

    readonly property real avatarSize  : (Style.fontSizeNormal * 2);
    readonly property real titleSize   : (Style.fontSizeNormal);
    readonly property real summarySize : (Style.fontSizeNormal);
    readonly property real paddingSize : (Style.spacingNormal);
    readonly property real spacingSize : (Style.spacingSmall);

    readonly property real itemSize    : (Math.max (avatarSize, titleSize) + summarySize + spacingSize + paddingSize * 2);

    StretchRowContainer {
        spacing: Style.spacingBig;
        visible: (pullingCommits || pushingCommits);

        TextLabel {
            text: (pullingCommits
                   ? qsTr ("New commits incoming from remote :")
                   : (pushingCommits
                      ? qsTr ("Local commits outgoing to remote :")
                      : ""));
            visible: (pullingCommits || pushingCommits);
            style: Text.Sunken;
            styleColor: Style.colorEditable;
            font.pixelSize: Style.fontSizeTitle;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Stretcher { }
        TextButton {
            text: qsTr ("Don't merge yet");
            icon: Image { source: "../icons/close.svg"; }
            anchors.verticalCenter: parent.verticalCenter;
            onClicked: {
                pullingCommits = false;
                pushingCommits = false;
            }
        }
        TextButton {
            text: qsTr ("Merge with local branch");
            icon: Image { source: "../icons/apply.svg"; }
            anchors.verticalCenter: parent.verticalCenter;
        }
    }
    ScrollContainer {
        id: viewIncomingCommits;
        visible: (pullingCommits || pushingCommits);
        showBorder: true;
        implicitHeight: -1;

        ListView { }
    }
    StretchRowContainer {
        visible: viewCommitLog.visible;

        TextLabel {
            text: qsTr ("Local commits in the repository :");
            style: Text.Sunken;
            styleColor: Style.colorEditable;
            font.pixelSize: Style.fontSizeTitle;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Stretcher { }
        TextButton {
            text: qsTr ("Refresh the view");
            icon: Image { source: "../icons/refresh.svg"; }
            anchors.verticalCenter: parent.verticalCenter;
            onClicked: { currentReposObj.refreshCommits (); }
        }
    }
    ScrollContainer {
        id: viewCommitLog;
        visible: !viewDeltasDetails.visible;
        showBorder: true;
        implicitHeight: -1;

        ListView {
            model: (currentReposObj ? currentReposObj.commitsModel : 0);
            delegate: MouseArea {
                id: delegateCommit;
                height: itemSize;
                ExtraAnchors.horizontalFill: parent;
                onClicked: { currentCommitEntry = commitEntry; }

                readonly property bool        isCurrent   : (commitEntry === currentCommitEntry);
                readonly property CommitEntry commitEntry : model.qtObject;

                Rectangle {
                    color: (delegateCommit.isCurrent || delegateCommit.pressed
                            ? Style.colorHighlight
                            : (model.index % 2 ? Style.colorSecondary : Style.colorEditable));
                    opacity: 0.15;
                    anchors.fill: parent;
                }
                StretchColumnContainer {
                    id: layoutCommitInfo;
                    spacing: spacingSize;
                    anchors.margins: paddingSize;
                    ExtraAnchors.topDock: parent;

                    StretchRowContainer {
                        spacing: Style.spacingNormal;

                        Rectangle {
                            id: frame;
                            color: Style.colorSecondary;
                            width: implicitWidth;
                            height: implicitHeight;
                            implicitWidth: avatarSize;
                            implicitHeight: avatarSize;
                            anchors.verticalCenter: parent.verticalCenter;

                            Image {
                                source: getGravatarImgUrl (delegateCommit.commitEntry ? delegateCommit.commitEntry.authorMail : "", avatarSize);
                                anchors.fill: parent;
                            }
                        }
                        TextLabel {
                            text: (delegateCommit.commitEntry ? delegateCommit.commitEntry.authorName : "");
                            color: fgColorBase;
                            font.underline: true;
                            font.pixelSize: titleSize;
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                        TextLabel {
                            text: (delegateCommit.commitEntry ? Qt.formatDateTime (delegateCommit.commitEntry.authorWhen, "ddd dd MMM yyyy, hh:mm:ss") : "");
                            color: Style.colorBorder;
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                        Stretcher { }
                        TextLabel {
                            text: (delegateCommit.commitEntry ? delegateCommit.commitEntry.objectId : "");
                            color: Style.colorBorder;
                            elide: Text.ElideMiddle;
                            font.weight: Font.Bold;
                            font.pixelSize: Style.fontSizeSmall;
                            anchors.verticalCenter: parent.verticalCenter;

                            Rectangle {
                                z: -1;
                                color: Style.colorWindow;
                                radius: 3;
                                opacity: 0.65;
                                antialiasing: true;
                                anchors {
                                    fill: parent;
                                    margins: -radius;
                                }
                            }
                        }
                    }
                    TextLabel {
                        text: (delegateCommit.commitEntry ? delegateCommit.commitEntry.messageSummary : "");
                        elide: Text.ElideRight;
                        wrapMode: Text.NoWrap;
                        font.pixelSize: summarySize;
                    }
                }
            }
        }
    }
    StretchRowContainer {
        visible: viewDeltasDetails.visible;
        implicitHeight: -1;

        TextLabel {
            text: qsTr ("Details of the selected commit :");
            style: Text.Sunken;
            styleColor: Style.colorEditable;
            font.pixelSize: Style.fontSizeTitle;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Stretcher { }
        TextButton {
            text: qsTr ("Return to the list");
            icon: Image { source: "../icons/close.svg"; }
            anchors.verticalCenter: parent.verticalCenter;
            onClicked: { currentCommitEntry = null; }
        }
    }
    ScrollContainer {
        id: viewDeltasDetails;
        visible: currentCommitEntry;
        showBorder: true;
        implicitHeight: -1;

        Flickable {
            clip: true;
            contentWidth: width;
            contentHeight: (layoutDeltas.height + layoutDeltas.anchors.margins);

            StretchColumnContainer {
                id: layoutDeltas;
                ExtraAnchors.topDock: parent;

                Stretcher { implicitHeight: Style.spacingBig; }
                StretchRowContainer {
                    id: layoutParents;

                    Stretcher { implicitWidth: Style.spacingNormal; }
                    StretchColumnContainer {
                        spacing: Style.spacingBig;

                        StretchRowContainer {
                            spacing: Style.spacingBig;

                            TextLabel {
                                text: qsTr ("Object ID :");
                            }
                            TextLabel {
                                text: (currentCommitEntry ? currentCommitEntry.objectId : "");
                                color: Style.colorBorder;
                                font.weight: Font.Bold;

                                Rectangle {
                                    z: -1;
                                    color: Style.colorWindow;
                                    radius: Style.roundness;
                                    opacity: 0.65;
                                    antialiasing: radius;
                                    anchors {
                                        fill: parent;
                                        margins: -radius;
                                    }
                                }
                            }
                        }
                        StretchRowContainer {
                            spacing: Style.spacingBig;

                            TextLabel {
                                text: qsTr ("Parent commit(s) :");
                            }
                            StretchRowContainer {
                                spacing: Style.spacingBig;

                                TextLabel {
                                    text: qsTr ("none");
                                    color: Style.colorBorder;
                                    visible: (repeaterParents.count === 0);
                                    font.weight: Font.Bold;
                                }
                                Repeater {
                                    id: repeaterParents;
                                    model: (currentCommitEntry ? currentCommitEntry.parentsIds : 0);
                                    delegate: TextLabel {
                                        text: modelData;
                                        color: Style.colorBorder;
                                        font.weight: Font.Bold;

                                        Rectangle {
                                            z: -1;
                                            color: Style.colorWindow;
                                            radius: Style.roundness;
                                            opacity: 0.65;
                                            antialiasing: radius;
                                            anchors {
                                                fill: parent;
                                                margins: -radius;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        StretchRowContainer {
                            spacing: Style.spacingBig;

                            TextLabel {
                                text: qsTr ("Message body :");
                            }
                            TextLabel {
                                text: (currentCommitEntry ? currentCommitEntry.messageBody.trim () : "");
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                            }
                        }
                    }
                    Stretcher { implicitWidth: Style.spacingSmall; }
                }
                Stretcher { implicitHeight: Style.spacingBig; }
                Line { }
                Repeater {
                    model: (currentCommitEntry ? currentCommitEntry.diffFromParents.deltaModel : 0);
                    delegate: StretchColumnContainer {
                        id: delegateDelta;

                        property bool expanded : false;

                        readonly property DeltaEntry deltaEntry : model.qtObject;

                        MouseArea {
                            implicitHeight: (Style.fontSizeNormal + Style.spacingNormal * 2);
                            onClicked: { delegateDelta.expanded = !delegateDelta.expanded; }

                            Rectangle {
                                color: Style.colorHighlight;
                                opacity: 0.35;
                                anchors.fill: parent;
                            }
                            Rectangle {
                                id: rectDeltaMargin;
                                color: Style.colorWindow;
                                width: height;
                                ExtraAnchors.leftDock: parent;

                                RegularPolygon {
                                    sides: 3;
                                    diameter: Style.fontSizeNormal;
                                    angle: (delegateDelta.expanded ? 0 : 90);
                                    fillColor: Style.colorForeground;
                                    strokeSize: 0;
                                    anchors {
                                        verticalCenter: parent.verticalCenter;
                                        horizontalCenter: parent.right;
                                        horizontalCenterOffset: -15;
                                    }
                                }
                            }
                            TextLabel {
                                text: (delegateDelta.deltaEntry.oldFilePath !== delegateDelta.deltaEntry.newFilePath
                                       ? delegateDelta.deltaEntry.oldFilePath + " -> " + delegateDelta.deltaEntry.newFilePath
                                       : delegateDelta.deltaEntry.newFilePath);
                                color: fgColorUnchanged;
                                font .weight: Font.Bold;
                                anchors {
                                    left: rectDeltaMargin.right;
                                    margins: Style.spacingSmall;
                                    verticalCenter: parent.verticalCenter;
                                }
                            }
                            Row {
                                spacing: Style.spacingBig;
                                anchors {
                                    right: parent.right;
                                    margins: Style.spacingSmall;
                                    verticalCenter: parent.verticalCenter;
                                }

                                TextLabel {
                                    text: ("+" + delegateDelta.deltaEntry.addedCount);
                                    color: Style.colorValid;
                                }
                                TextLabel {
                                    text: "|";
                                    color: Style.colorBorder;
                                }
                                TextLabel {
                                    text: ("-" + delegateDelta.deltaEntry.removedCount);
                                    color: Style.colorError;
                                }
                                TextLabel {
                                    text: {
                                        switch (delegateDelta.deltaEntry.status) {
                                        case DeltaEntry.UnModified:  return qsTr ("(Unmodified)");
                                        case DeltaEntry.Added:       return qsTr ("(Added)");
                                        case DeltaEntry.Deleted:     return qsTr ("(Deleted)");
                                        case DeltaEntry.Modified:    return qsTr ("(Modified)");
                                        case DeltaEntry.Renamed:     return qsTr ("(Renamed)");
                                        case DeltaEntry.Copied:      return qsTr ("(Copied)");
                                        case DeltaEntry.Ignored:     return qsTr ("(Ignored)");
                                        case DeltaEntry.UnTracked:   return qsTr ("(Untracked)");
                                        case DeltaEntry.TypeChanged: return qsTr ("(Filemode changed)");
                                        default:                     return qsTr ("(Unknown status)");
                                        }
                                    }
                                    color: fgColorUnchanged;
                                }
                            }
                        }
                        StretchColumnContainer {
                            id: layoutHunks;
                            visible: delegateDelta.expanded;

                            Repeater {
                                model: (delegateDelta.expanded ? delegateDelta.deltaEntry.hunksModel : 0);
                                delegate: DelegateDeltaHunkEntry {
                                    hunkEntry: model.qtObject;
                                    deltaEntry: delegateDelta.deltaEntry;
                                }
                            }
                        }
                        Line { visible: !delegateDelta.expanded; }
                    }
                }
            }
        }
    }
}

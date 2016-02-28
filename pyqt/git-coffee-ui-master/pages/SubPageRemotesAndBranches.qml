import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    spacing: Style.spacingBig;
    anchors {
        fill: parent;
        margins: Style.spacingBig;
    }

    StretchRowContainer {
        spacing: layoutBranches.spacing;

        Stretcher {
            height: implicitHeight;
            implicitHeight: lblLocales.contentHeight;
            anchors.verticalCenter: parent.verticalCenter;

            TextLabel {
                id: lblLocales;
                text: qsTr ("Local branches");
                style: Text.Sunken;
                styleColor: Style.colorEditable;
                font.pixelSize: Style.fontSizeTitle;
                anchors.centerIn: parent;
            }
        }
        Stretcher {
            height: implicitHeight;
            implicitHeight: btnRefreshBranches.implicitHeight;
            anchors.verticalCenter: parent.verticalCenter;

            TextButton {
                id: btnRefreshBranches;
                text: qsTr ("Refresh the branches");
                icon: Image { source: "../icons/refresh.svg"; }
                anchors.centerIn: parent;
                onClicked: {
                    currentReposObj.refreshRemotes ();
                    currentReposObj.refreshBranches ();
                }
            }
        }
        Stretcher {
            height: implicitHeight;
            implicitHeight: lblRemotes.contentHeight;
            anchors.verticalCenter: parent.verticalCenter;

            TextLabel {
                id: lblRemotes;
                text: qsTr ("Remote branches");
                style: Text.Sunken;
                styleColor: Style.colorEditable;
                font.pixelSize: Style.fontSizeTitle;
                anchors.centerIn: parent;
            }
        }
    }
    ScrollContainer {
        showBorder: true;
        implicitHeight: -1;

        Flickable {
            clip: true;
            contentWidth: width;
            contentHeight: layoutBranches.height;
            flickableDirection: Flickable.VerticalFlick;

            Item {
                id: layoutBranches;
                anchors.margins: Style.spacingBig;
                ExtraAnchors.topDock: parent;
                onIndexOfBranchesChanged: {
                    if (currentReposObj !== null) {
                        var localBranches  = [];
                        var remoteBranches = [];
                        var remotesList = currentReposObj.remotesModel.toVarArray ();
                        for (var remoteIdx = 0; remoteIdx < remotesList.length; remoteIdx++) {
                            var remoteEntry = remotesList [remoteIdx];
                            remoteBranches.push (remoteEntry ["name"]);
                        }
                        var branchesList = currentReposObj.branchesModel.toVarArray ();
                        for (var branchIdx = 0; branchIdx < branchesList.length; branchIdx++) {
                            var branchEntry = branchesList [branchIdx];
                            if (branchEntry !== null) {
                                if (branchEntry ["isLocal"]) {
                                    localBranches.push (branchEntry ["name"]);
                                }
                                else {
                                    remoteBranches.push (branchEntry ["name"]);
                                }
                            }
                        }
                        localBranches.sort  ();
                        remoteBranches.sort ();
                        localBranches.forEach (function (name, idx) {
                            var item = getBranchDelegateByName (name);
                            if (item !== null) {
                                item ["y"] = (idx * (itemHeight + spacing));
                            }
                        });
                        remoteBranches.forEach (function (name, idx) {
                            var item = getBranchDelegateByName (name);
                            if (item !== null) {
                                item ["y"] = (idx * (itemHeight + spacing));
                            }
                        });
                        var nb = Math.max (localBranches.length, remoteBranches.length);
                        height = (nb >= 1 ? (nb * itemHeight) + ((nb -1) * spacing) : 0);
                    }
                }

                readonly property int  spacing    : Style.spacingBig;
                readonly property real itemWidth  : (width - spacing * 2) / 3;
                readonly property real itemHeight : (Style.fontSizeNormal + Style.spacingNormal * 2);

                property var indexOfBranches : ({});

                function getBranchDelegateByName (name) {
                    return (indexOfBranches [name] || null);
                }

                function setBranchDelegateForName (name, item) {
                    indexOfBranches [name] = (item || null);
                    indexOfBranches = indexOfBranches;
                }

                Repeater {
                    id: repeaterRemotes;
                    model: (currentReposObj ? currentReposObj.remotesModel : 0);
                    delegate: MouseArea {
                        id: remoteDelegate;
                        width: layoutBranches.itemWidth;
                        height: layoutBranches.itemHeight;
                        anchors.right: layoutBranches.right;
                        onClicked: { }
                        Component.onCompleted: { layoutBranches.setBranchDelegateForName (remoteEntry.name, remoteDelegate); }

                        readonly property RemoteEntry remoteEntry : model.qtObject;

                        Rectangle {
                            color: Style.colorWindow;
                            anchors.fill: parent;
                        }
                        TextLabel {
                            text: remoteDelegate.remoteEntry.name;
                            font.weight: Font.Bold;
                            verticalAlignment: Text.AlignVCenter;
                            horizontalAlignment: Text.AlignHCenter;
                            anchors {
                                margins: Style.spacingNormal;
                                verticalCenter: parent.verticalCenter;
                            }
                            ExtraAnchors.horizontalFill: parent;
                        }
                    }
                }
                Repeater {
                    id: repeaterBranches;
                    model: (currentReposObj ? currentReposObj.branchesModel : 0);
                    delegate: MouseArea {
                        id: branchDelegate;
                        width: layoutBranches.itemWidth;
                        height: layoutBranches.itemHeight;
                        states: [
                            State {
                                when: (branchDelegate.branchEntry && branchDelegate.branchEntry.isLocal);

                                AnchorChanges {
                                    target: branchDelegate;
                                    anchors.left: layoutBranches.left;
                                }
                            },
                            State {
                                when: (branchDelegate.branchEntry && !branchDelegate.branchEntry.isLocal);

                                AnchorChanges {
                                    target: branchDelegate;
                                    anchors.right: layoutBranches.right;
                                }
                            }
                        ]
                        onClicked: { }
                        Component.onCompleted: { layoutBranches.setBranchDelegateForName (branchEntry.name, branchDelegate); }

                        readonly property BranchEntry branchEntry : model.qtObject;

                        TextLabel {
                            text: branchDelegate.branchEntry.name;
                            color: (branchDelegate.branchEntry.isHead ? Style.colorSelection : Style.colorForeground);
                            verticalAlignment: Text.AlignVCenter;
                            horizontalAlignment: (branchDelegate.branchEntry.isLocal ? Text.AlignRight : Text.AlignLeft);
                            font.bold: branchDelegate.branchEntry.isHead;
                            anchors {
                                margins: Style.spacingNormal;
                                verticalCenter: parent.verticalCenter;
                            }
                            ExtraAnchors.horizontalFill: parent;
                        }
                    }
                }
                Repeater {
                    model: (currentReposObj ? currentReposObj.branchesModel : 0);
                    delegate: Polygon {
                        id: line;
                        color: Style.colorNone;
                        border: (Style.lineSize * 1.5);
                        closed: false;
                        stroke: Style.colorForeground;
                        visible: (srcObj && dstObj);
                        antialiasing: true;
                        points: [
                            Qt.point ((srcObj ? srcObj.x + srcObj.width      : 0),
                                      (srcObj ? srcObj.y + srcObj.height / 2 : 0)),
                            Qt.point ((dstObj ? dstObj.x                     : 0),
                                      (dstObj ? dstObj.y + dstObj.height / 2 : 0)),
                        ];

                        readonly property BranchEntry branchEntry : model.qtObject;

                        readonly property Item srcObj : (branchEntry && branchEntry.isLocal
                                                         ? layoutBranches.getBranchDelegateByName (branchEntry.name)
                                                         : null);

                        readonly property Item dstObj : (branchEntry && branchEntry.hasRemote
                                                         ? layoutBranches.getBranchDelegateByName (branchEntry.upstreamName)
                                                         : null);
                    }
                }
            }
        }
    }
}

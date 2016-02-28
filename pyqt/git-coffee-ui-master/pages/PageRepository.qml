import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

Group {
    id: pageRepository;

    readonly property Item currentWorkspaceContentItem : {
        switch (accordion.currentTab) {
        case groupReposManagement:        return layoutReposManagement;
        case groupWorkingDirectoryStatus: return layoutWorkingDirectoryStatus;
        case groupRemotesAndBranches:     return layoutRemotesAndBranches;
        case groupCommitLog:              return layoutCommitLog;
        case groupConfig:                 return layoutConfig;
        default:                          return null;
        }
    }

    Rectangle  {
        color: window.color;
        anchors.fill: parent;
    }
    Rectangle {
        id: sidebarLeft;
        width: 200;
        color: Qt.darker (window.color, 1.15);
        ExtraAnchors.leftDock: parent;

        Accordion {
            id: accordion;
            anchors.fill: parent;

            Group {
                id: groupReposManagement;
                title: qsTr ("Repository");
            }
            Group {
                id: groupWorkingDirectoryStatus;
                title: qsTr ("Working directory");

                StretchColumnContainer {
                    spacing: Style.spacingNormal;
                    anchors.fill: parent;
                    anchors.margins: Style.spacingNormal;

                    TextButton {
                        text: qsTr ("Create a new commit");
                        visible: !layoutWorkingDirectoryStatus.creatingCommit;
                        onClicked: { layoutWorkingDirectoryStatus.creatingCommit = true; }
                    }
                    Balloon {
                        title: qsTr ("Creating a new commit");
                        content: qsTr ("Choose the changesets you want to include in the commit, by moving them from the working directory to the staging area.");
                        visible: layoutWorkingDirectoryStatus.creatingCommit;
                    }
                    TextButton {
                        text: qsTr ("Clean working directory");
                        visible: !layoutWorkingDirectoryStatus.creatingCommit;
                    }
                }
            }
            Group {
                id: groupRemotesAndBranches;
                title: qsTr ("Branches & Remotes");
            }
            Group {
                id: groupCommitLog;
                title: qsTr ("History");

                StretchColumnContainer {
                    spacing: Style.spacingNormal;
                    anchors.fill: parent;
                    anchors.margins: Style.spacingNormal;

                    TextButton {
                        text: qsTr ("Pull incoming commits");
                        visible: (!layoutCommitLog.pullingCommits && !layoutCommitLog.pushingCommits);
                        onClicked: { layoutCommitLog.pullingCommits = true; }
                    }
                    Balloon {
                        title: qsTr ("Pulling incoming commits");
                        content: qsTr ("Fetch all new commits from the upstream remote, and show the list. Then you can choose if you want to merge them locally or not...");
                        visible: layoutCommitLog.pullingCommits;
                    }
                    TextButton {
                        text: qsTr ("Push outgoing commits");
                        visible: (!layoutCommitLog.pullingCommits && !layoutCommitLog.pushingCommits);
                        onClicked: { layoutCommitLog.pushingCommits = true; }
                    }
                    Balloon {
                        title: qsTr ("Pushing outgoing commits");
                        content: qsTr ("List all the local commits that aren't upstream. Then you can choose if you want to push them to make them public or not...");
                        visible: layoutCommitLog.pushingCommits;
                    }
                }
            }
            Group {
                id: groupConfig;
                title: qsTr ("Configuration");
            }
        }
        Line { ExtraAnchors.rightDock: parent; }
    }
    Item {
        id: workspace;
        anchors {
            left: sidebarLeft.right;
            right: sidebarRight.left;
        }
        ExtraAnchors.verticalFill: parent;

        SubPageRemotesAndBranches {
            id: layoutRemotesAndBranches;
            visible: (currentWorkspaceContentItem === layoutRemotesAndBranches);
        }
        SubPageCommitLogAndGraph {
            id: layoutCommitLog;
            visible: (currentWorkspaceContentItem === layoutCommitLog);
        }
        SubPageConfiguration {
            id: layoutConfig;
            visible: (currentWorkspaceContentItem === layoutConfig);
        }
        SubPageGeneralRepositoryInfo {
            id: layoutReposManagement;
            visible: (currentWorkspaceContentItem === layoutReposManagement);
        }
        SubPageWorkingDirectoryStatus {
            id: layoutWorkingDirectoryStatus;
            visible: (currentWorkspaceContentItem === layoutWorkingDirectoryStatus);
        }
    }
    Rectangle {
        id: sidebarRight
        width: 240;
        color: Qt.darker (window.color, 1.15);
        ExtraAnchors.rightDock: parent;

        Line { ExtraAnchors.leftDock: parent; }
    }
}

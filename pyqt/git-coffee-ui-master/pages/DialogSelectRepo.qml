import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import Qt.labs.folderlistmodel 2.1;

FocusScope {
    id: dialogSelectRepo;
    visible: false;
    enabled: visible;
    anchors.fill: parent;

    function show () {
        currentSelectedPath = "file:///home/";
        visible = true;
    }
    function hide () {
        visible = false;
        acceptCallback = undefined;
        rejectCallback = undefined;
        mustSelectExistingDir = false;
    }

    property bool  mustSelectExistingDir : false;
    property var   acceptCallback        : undefined;
    property var   rejectCallback        : undefined;
    property alias currentSelectedPath   : modelFs.folder;

    MimeIconsHelper {
        id: mimeHelper;
    }
    MouseArea {
        anchors.fill: parent;
        onClicked: { }
    }
    Rectangle {
        color: "black";
        opacity: 0.85;
        anchors.fill: parent;
    }
    Rectangle {
        id: frame;
        width: 640;
        height: 480;
        radius: 6;
        antialiasing: true;
        color: window.color;
        border {
            width: 2;
            color: Qt.darker (color);
        }
        anchors.centerIn: parent;

        StretchColumnContainer {
            spacing: 12;
            anchors {
                fill: parent;
                margins: 24;
            }

            TextLabel {
                text: qsTr ("Select the directory for the GIT repository :");
                font.pixelSize: Style.fontSizeTitle;
            }
            Rectangle {
                color: "darkgray";
                implicitHeight: Style.lineSize;
            }
            Flow {
                spacing: 6;

                TextLabel {
                    text: qsTr ("Current path :");
                    font.pixelSize: Style.fontSizeSmall;
                    color: "#595959";
                }
                Repeater {
                    model: {
                        var ret = [];
                        var path = "file:///";
                        ret.push ({ "name" : path, "url" : path });
                        var tmp = modelFs.folder.toString ().replace ("file:///", "").split ("/");
                        for (var idx = 0; idx < tmp.length; idx++) {
                            var name = tmp [idx] + "/";
                            if (name !== "/") {
                                path += name;
                                ret.push ({ "name" : name, "url" : path });
                            }
                        }
                        return ret;
                    }
                    delegate: Row {
                        spacing: 6;

                        property bool isCurrent : Positioner.isLastItem;

                        Rectangle {
                            width: 3;
                            height: width;
                            color: "gray";
                            rotation: 45;
                            visible: (model.index > 0);
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                        TextLabel {
                            text: modelData ["name"];
                            font.weight: (isCurrent ? Font.Bold : Font.Normal);
                            font.pixelSize: Style.fontSizeSmall;
                            font.underline: hoverDetector.containsMouse;
                            color: fgColorUrl;
                            anchors.verticalCenter: parent.verticalCenter;

                            MouseArea {
                                id: hoverDetector;
                                enabled: !isCurrent;
                                hoverEnabled: true;
                                anchors.fill: parent;
                                onClicked: { modelFs.folder = modelData ["url"]; }
                            }
                        }
                    }
                }
            }
            ScrollContainer {
                showBorder: true;
                implicitHeight: -1;

                ListView {
                    model: FolderListModel {
                        id: modelFs;
                        showDirs: true;
                        showFiles: true;
                        showHidden: false;
                        showDirsFirst: true;
                        showDotAndDotDot: false;
                        showOnlyReadable: false;
                        sortField: FolderListModel.Name;
                    }
                    delegate: MouseArea {
                        height: 30;
                        enabled: model.fileIsDir;
                        opacity: (model.fileName [0] === "." ? 0.65 : 1.0);
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onDoubleClicked: { modelFs.folder = model.fileURL; }

                        property bool containsRepos : (model.fileIsDir ? Shared.containsGitRepository (model.filePath) : false);

                        Rectangle {
                            color: (model.index % 2 ? "lightgray" : "darkgray");
                            opacity: 0.15;
                            anchors.fill: parent;
                        }
                        Image {
                            id: imgIcon;
                            source: (model.fileIsDir
                                     ? ("../icons/" +  (containsRepos ? "repos" : "folder") + ".svg")
                                     : "image://icon-theme/%1".arg (mimeHelper.getIconNameForUrl (model.fileURL)));
                            width: size;
                            height: size;
                            fillMode: Image.Stretch;
                            antialiasing: true;
                            asynchronous: true;
                            anchors {
                                left: parent.left;
                                margins: (parent.height - height);
                                verticalCenter: parent.verticalCenter;
                            }

                            readonly property int size : (Style.fontSizeNormal * 2);
                        }
                        TextLabel {
                            text: model.fileName;
                            anchors {
                                left: imgIcon.right;
                                right: parent.right;
                                margins: 6;
                                verticalCenter: parent.verticalCenter;
                            }
                        }
                    }
                }
            }
            StretchRowContainer {
                spacing: 12;

                TextButton {
                    text: qsTr ("Create new folder");
                    enabled: !mustSelectExistingDir;
                    icon: Image { source: "../icons/add.svg"; }
                }
                Item { implicitWidth: -1; }
                TextButton {
                    text: qsTr ("Reject");
                    icon: Image { source: "../icons/delete.svg"; }
                    onClicked: {
                        if (typeof (rejectCallback) === "function") {
                            rejectCallback ();
                        }
                        hide ();
                    }
                }
                TextButton {
                    text: qsTr ("Accept");
                    icon: Image { source: "../icons/apply.svg"; }
                    onClicked: {
                        if (typeof (acceptCallback) === "function") {
                            acceptCallback (modelFs.folder.toString ().replace ("file://", ""));
                        }
                        hide ();
                    }
                }
            }
        }
    }
}

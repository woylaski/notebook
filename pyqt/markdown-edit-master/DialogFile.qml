import QtQuick 2.3;
import QtQuick.Layouts 1.1;
import QtQuick.Controls 1.2;
import QtQuick.Controls.Styles 1.2;
import Qt.labs.folderlistmodel 2.1;

FocusScope {
    id: dialogSelectRepo;
    visible: false;
    enabled: visible;
    anchors.fill: parent;

    function hide () {
        enabled = false;
        visible = false;
        currentFilePath = "";
    }

    property var    acceptCallback        : undefined;
    property var    rejectCallback        : undefined;
    property string currentFilePath       : "";
    property alias  currentDirPath        : modelFs.folder;

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
        color: "lightgray";
        border {
            width: 2;
            color: Qt.darker (color);
        }
        anchors.centerIn: parent;

        ColumnLayout {
            spacing: 12;
            anchors {
                fill: parent;
                margins: 24;
            }

            Label {
                text: qsTr ("Select a MarkDown file :");
                font.weight: Font.Normal;
                font.family: fontName;
                font.pixelSize: fontSizeNormal;
                color: "#595959";
            }
            Rectangle {
                color: "darkgray";
                Layout.fillWidth: true;
                Layout.minimumHeight: 1;
                Layout.maximumHeight: 1;
            }
            Flow {
                spacing: 6;
                Layout.fillWidth: true;

                Label {
                    text: qsTr ("Current path :");
                    font.weight: Font.Normal;
                    font.family: fontName;
                    font.pixelSize: fontSizeSmall;
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
                        Label {
                            text: model.modelData ["name"];
                            font.weight: (isCurrent ? Font.Bold : Font.Normal);
                            font.family: fontName;
                            font.pixelSize: fontSizeSmall;
                            font.underline: hoverDetector.containsMouse;
                            color: "darkblue";
                            anchors.verticalCenter: parent.verticalCenter;

                            MouseArea {
                                id: hoverDetector;
                                enabled: !isCurrent;
                                hoverEnabled: true;
                                anchors.fill: parent;
                                onClicked: { modelFs.folder = model.modelData ["url"]; }
                            }
                        }
                    }
                }
            }
            ScrollView {
                style: styleScrollView;
                frameVisible: true;
                Layout.fillWidth: true;
                Layout.fillHeight: true;

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
                        opacity: (model.fileName [0] === "." ? 0.65 : 1.0);
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onClicked: {
                             if (!model.fileIsDir) {
                                currentFilePath = model.filePath;
                            }
                        }
                        onDoubleClicked: {
                            if (model.fileIsDir) {
                                modelFs.folder = model.fileURL;
                            }
                        }

                        property bool isCurrent : (currentFilePath === model.filePath);

                        Rectangle {
                            color: (parent.isCurrent ? "steelblue" : (model.index % 2 ? "lightgray" : "darkgray"));
                            opacity: 0.15;
                            anchors.fill: parent;
                        }
                        Image {
                            id: imgIcon;
                            source: "../icons/%1.svg".arg (model.fileIsDir ? "folder" : "file");
                            anchors {
                                left: parent.left;
                                margins: (parent.height - height);
                                verticalCenter: parent.verticalCenter;
                            }
                        }
                        Label {
                            text: model.fileName;
                            font.weight: Font.Light;
                            font.family: fontName;
                            font.pixelSize: fontSizeNormal;
                            color: "black";
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
            RowLayout {
                spacing: 12;
                Layout.fillWidth: true;

                Item { Layout.fillWidth: true; }
                Button {
                    text: qsTr ("Reject");
                    style: styleButtonIconText;
                    iconSource: "../icons/delete.svg";
                    onClicked: {
                        if (typeof (rejectCallback) === "function") {
                            rejectCallback ();
                        }
                        hide ();
                    }
                }
                Button {
                    text: qsTr ("Accept");
                    style: styleButtonIconText;
                    iconSource: "../icons/apply.svg";
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

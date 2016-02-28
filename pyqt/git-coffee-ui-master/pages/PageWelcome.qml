import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;

Group {
    id: pageWelcome;

    Rectangle  {
        color: window.color;
        anchors.fill: parent;
    }
    GridContainer {
        cols: capacity;
        capacity: 2;
        colSpacing: Style.spacingBig;
        anchors {
            fill: parent;
            margins: 48;
        }

        StretchColumnContainer {
            spacing: Style.spacingBig;

            TextLabel {
                text: qsTr ("Latest repositories used");
                style: Text.Sunken;
                styleColor: Style.colorEditable;
                font.pixelSize: Style.fontSizeTitle;
            }
            Line { }
            ScrollContainer {
                showBorder: true;
                implicitHeight: -1;

                ListView {
                    model: Shared.lastRepositoriesModel;
                    delegate: MouseArea {
                        height: (lbl.height + lbl.anchors.margins * 2);
                        hoverEnabled: true;
                        ExtraAnchors.horizontalFill: parent;
                        onClicked: { Shared.tryOpenGitRepository (model.qtVariant.toString ()); }

                        Rectangle {
                            color: (model.index % 2 ? Style.colorWindow : Style.colorSecondary);
                            opacity: 0.15;
                            anchors.fill: parent;
                        }
                        TextLabel {
                            id: lbl;
                            text: model.qtVariant;
                            color: (parent.containsMouse ? Qt.darker (fgColorUrl, 1.25) : fgColorUrl);
                            font.underline: parent.containsMouse;
                            anchors {
                                margins: Style.spacingBig;
                                verticalCenter: parent.verticalCenter;
                            }
                            ExtraAnchors.horizontalFill: parent;
                        }
                    }
                }
            }
        }
        StretchColumnContainer {
            spacing: Style.spacingBig;

            TextLabel {
                text: qsTr ("Other Actions");
                style: Text.Sunken;
                styleColor: Style.colorEditable;
                font.pixelSize: Style.fontSizeTitle;
            }
            Line { }
            StretchColumnContainer {
                spacing: Style.spacingNormal;

                TextButton {
                    text: qsTr ("Create a new repository");
                    icon: Image { source: "../icons/add.svg"; }
                    onClicked: {
                        dialogSelectRepo.mustSelectExistingDir = false;
                        dialogSelectRepo.acceptCallback = function (path) {
                            console.log ("accepted=", path);
                        }
                        dialogSelectRepo.rejectCallback = function () {
                            console.log ("rejected");
                        }
                        dialogSelectRepo.show ();
                    }
                }
                TextButton {
                    text: qsTr ("Find a local repository");
                    icon: Image { source: "../icons/open.svg"; }
                    onClicked: {
                        dialogSelectRepo.mustSelectExistingDir = true;
                        dialogSelectRepo.acceptCallback = function (path) {
                            console.log ("accepted=", path);
                            Shared.tryOpenGitRepository (path);
                        }
                        dialogSelectRepo.rejectCallback = function () {
                            console.log ("rejected");
                        }
                        dialogSelectRepo.show ();
                    }
                }
                TextButton {
                    text: qsTr ("Clone a remote repository");
                    icon: Image { source: "../icons/save.svg"; }
                    onClicked: {
                        dialogSelectRepo.mustSelectExistingDir = false;
                        dialogSelectRepo.acceptCallback = function (path) {
                            console.log ("accepted=", path);
                        }
                        dialogSelectRepo.rejectCallback = function () {
                            console.log ("rejected");
                        }
                        dialogSelectRepo.show ();
                    }
                }
            }
            Item { implicitHeight: -1; }
        }
    }
}

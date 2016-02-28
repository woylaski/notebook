import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    spacing: Style.spacingBig;
    anchors {
        fill: parent;
        margins: Style.spacingBig;
    }

    TextLabel {
        text: qsTr ("General information about the repository");
        style: Text.Sunken;
        styleColor: Style.colorEditable;
        font.pixelSize: Style.fontSizeTitle;
    }
    Line { }
    StretchRowContainer {
        spacing: Style.spacingNormal;

        TextLabel {
            text: qsTr ("Repository type :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj
                   ? (currentReposObj.isBareRepository
                      ? qsTr ("Bare repository (no working directory)")
                      : qsTr ("Normal repository clone (with working directory)"))
                   : "");
        }
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;

        TextLabel {
            text: qsTr ("Repository path :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.repositoryPath : "");
            color: Style.colorLink;
            font.underline: true;
        }
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: (currentReposObj && !currentReposObj.isBareRepository);

        TextLabel {
            text: qsTr ("Working directory path :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.workingDirPath : "");
            color: Style.colorLink;
            font.underline: true;
        }
    }
    TextLabel {
        text: qsTr ("Statistics");
        style: Text.Sunken;
        styleColor: Style.colorEditable;
        font.pixelSize: Style.fontSizeTitle;
    }
    Line { }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: (currentReposObj && !currentReposObj.isBareRepository);

        TextLabel {
            text: qsTr ("Number of commits :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.commitsModel.count : "0");
        }
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: (currentReposObj && !currentReposObj.isBareRepository);

        TextLabel {
            text: qsTr ("Number of remotes :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.remotesModel.count : "0");
        }
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: (currentReposObj && !currentReposObj.isBareRepository);

        TextLabel {
            text: qsTr ("Number of branches :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.branchesModel.count : "0");
        }
    }
    StretchRowContainer {
        spacing: Style.spacingNormal;
        visible: (currentReposObj && !currentReposObj.isBareRepository);

        TextLabel {
            text: qsTr ("Number of tags :");
            font.weight: Font.Bold;
        }
        TextLabel {
            text: (currentReposObj ? currentReposObj.tagsModel.count : "0");
        }
    }
    Stretcher { }
}

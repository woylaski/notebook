import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

Item {
    id: base;
    implicitHeight: 18;

    property DeltaEntry deltaEntry : null;
    property HunkEntry  hunkEntry  : null;
    property LineEntry  lineEntry  : null;

    Rectangle {
        color: (lineEntry.added ? bgColorUntracked : (lineEntry.removed ? bgColorDeleted : bgColorUnchanged));
        opacity: (model.index % 2 ? 0.85 : 0.65);
        anchors.fill: parent;
    }
    Rectangle {
        id: rectLineMargin;
        width: 90;
        color: Style.colorWindow;
        ExtraAnchors.leftDock: parent;

        Item {
            width: 60;
            ExtraAnchors.rightDock: parent;

            TextLabel {
                text: (lineEntry.oldLineNum >= 0 ? lineEntry.oldLineNum : "++");
                color: Style.colorBorder;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignHCenter;
                font.pixelSize: Style.fontSizeSmall;
                anchors.right: parent.horizontalCenter;
                ExtraAnchors.leftDock: parent;
            }
            Line {
                anchors.horizontalCenter: parent.horizontalCenter;
                ExtraAnchors.verticalFill: parent;
            }
            TextLabel {
                text: (lineEntry.newLineNum >= 0 ? lineEntry.newLineNum : "--");
                color: Style.colorBorder;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignHCenter;
                font.pixelSize: Style.fontSizeSmall;
                anchors.left: parent.horizontalCenter;
                ExtraAnchors.rightDock: parent;
            }
            Line { ExtraAnchors.rightDock: parent; }
        }
    }
    TextLabel {
        text: lineEntry.content.replace (/[\r\n]/gi, "\u23CE").replace (/\s/gi, "\u00b7");
        color: fgColorUnchanged;
        textFormat: Text.PlainText;
        font.family: Style.fontFixedName;
        anchors {
            left: rectLineMargin.right;
            margins: Style.spacingSmall;
            verticalCenter: parent.verticalCenter;
        }
    }
}

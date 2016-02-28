import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    id: base;

    property bool expanded : false;

    property DeltaEntry deltaEntry : null;
    property HunkEntry  hunkEntry  : null;

    MouseArea {
        implicitHeight: 24;
        onClicked: { expanded = !expanded; }

        Rectangle {
            color: Style.colorSecondary;
            opacity: 0.65;
            anchors.fill: parent;
        }
        Rectangle {
            id: rectHunkMargin;
            color: Style.colorWindow;
            width: 60;
            ExtraAnchors.leftDock: parent;

            RegularPolygon {
                sides: 3;
                diameter: Style.fontSizeNormal;
                angle: (expanded ? 90 : 0);
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
            text: hunkEntry.header;
            color: fgColorUrl;
            font.underline: true;
            anchors {
                left: rectHunkMargin.right;
                margins: Style.spacingSmall;
                verticalCenter: parent.verticalCenter;
            }
        }
    }
    StretchColumnContainer {
        visible: expanded;

        Repeater {
            model: (expanded ? hunkEntry.linesModel : 0);
            delegate: DelegateDeltaLineEntry {
                lineEntry: model.qtObject;
                hunkEntry: base.hunkEntry;
                deltaEntry: base.deltaEntry;
            }
        }
    }
    Line { }
}

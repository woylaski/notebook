import QtQuick 2.0

Item {
    id: base;
    height: 30;

    property alias text          : lbl.text;
    property alias isBold        : lbl.font.bold;
    property alias isItalic      : lbl.font.italic;
    property alias hasBackground : back.visible;
    property alias hasSelection  : highlight.visible;

    signal clicked ();

    Rectangle {
        id: back;
        color: "#F2EFD3";
        visible: false;
        anchors.fill: parent;
    }
    Rectangle {
        id: highlight
        color: "#F0E798";
        visible: false;
        anchors.fill: parent;
    }
    Text {
        id: lbl;
        color: (base.enabled ? "#414141" : "gray");
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        font {
            family: fontName;
            pixelSize: fontSize;
            weight: Font.Light;
        }
        anchors {
            left: parent.left;
            right: parent.right;
            margins: 5;
            verticalCenter: parent.verticalCenter;
        }
    }
    MouseArea {
        anchors.fill: parent;
        onClicked: { base.clicked (); }
    }

}


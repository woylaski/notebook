import QtQuick 2.0

Item {
    id: base;
    height: 30;
    anchors {
        left: parent.left;
        right: parent.right;
    }

    property alias text     : lbl.text;

    Text {
        id: lbl;
        color: "#406698";
        verticalAlignment: Text.AlignVCenter;
        elide: Text.ElideRight;
        font {
            family: fontName;
            pixelSize: fontSize * 1.25;
            weight: Font.Bold;
            capitalization: Font.SmallCaps;
        }
        anchors {
            left: parent.left;
            right: parent.right;
            margins: 5;
            verticalCenter: parent.verticalCenter;
        }
    }

}


import QtQuick 2.1;
import QtQuick.Window 2.1;

Window {
    id: window;
    title: qsTr ("Disk Usage analyzer");
    color: "lightgray";
    width: 1280;
    height: 800;
    visible: true;
    onCurrentIdxChanged: { highlight.requestPaint (); }

    property int currentIdx : -1;

    readonly property real kib : (1024);
    readonly property real mib : (kib * 1024);
    readonly property real gib : (mib * 1024);
    readonly property real tib : (gib * 1024);

    readonly property int centerX : (width / 2);
    readonly property int centerY : (height / 2);
    readonly property int size : Math.min (centerX, centerY) - 50;

    readonly property bool valid : (Walker.tree && currentIdx > -1 && currentIdx < Walker.tree.length);

    readonly property var rootItem : { "name" : Walker.title, "size" : Walker.total, "isDir" : true };

    Connections {
        target: Walker;
        onTreeChanged: {
            completer.visible = false;
            chart.requestPaint ();
            highlight.requestPaint ();
        }
    }
    Canvas {
        id: chart;
        visible: Walker.tree;
        contextType: "2d";
        antialiasing: true;
        anchors.fill: parent;
        onPaint: {
            if (context && Walker.tree) {
                context.reset ();
                Walker.tree.forEach (function (item) {
                    context.beginPath ();
                    context.moveTo (centerX, centerY);
                    context.arc (centerX, centerY, size, item ["startAngle"], item ["endAngle"]);
                    context.closePath ();
                    context.fillStyle = item ["color"];
                    context.fill ();
                });
            }
        }
    }
    Canvas {
        id: highlight;
        visible: Walker.tree;
        contextType: "2d";
        antialiasing: true;
        anchors.fill: parent;
        onPaint: {
            if (context && Walker.tree) {
                context.reset ();
                if (valid) {
                    var item = Walker.tree [currentIdx];
                    context.beginPath ();
                    context.moveTo (centerX, centerY);
                    context.arc (centerX, centerY, size, item ["startAngle"], item ["endAngle"]);
                    context.closePath ();
                    context.lineWidth = 2;
                    context.stroke ();
                }
            }
        }
    }
    MouseArea {
        id: clicker;
        enabled: Walker.tree;
        hoverEnabled: true;
        anchors.fill: parent;
        onPositionChanged: {
            var deltaX = (mouseX - centerX);
            var deltaY = (mouseY - centerY);
            var angle = Math.atan2 (deltaY, deltaX);
            if (angle < 0) {
                angle += (2 * Math.PI);
            }
            var distance = Math.sqrt (deltaX * deltaX + deltaY * deltaY);
            if (distance < size && distance > size / 2) {
                currentIdx = Walker.getItemIndexForAngle (angle);
            }
            else {
                currentIdx = -1;
            }
        }
        onClicked: {
            if (valid) {
                var item = Walker.tree [currentIdx];
                if (item ["isDir"]) {
                    Walker.changeTreePath (item ["path"]);
                }
            }
            else {
                completer.visible = false;
            }
        }
    }
    Rectangle {
        color: window.color;
        width: size;
        height: size;
        radius: (size / 2);
        visible: !Walker.working;
        anchors.centerIn: parent;

        Text {
            color: (valid ? "black" : "gray");
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            minimumPixelSize: 12;
            fontSizeMode: Text.Fit;
            text: {
                var ret = "";
                if (Walker.tree) {
                    var item = (valid ? Walker.tree [currentIdx] : rootItem);
                    var label = (item ["name"] || "___");
                    if (item ["isDir"]) {
                        ret += "<b>%1/</b>".arg (label);
                    }
                    else {
                        ret += "<i>%1</i>".arg (label);
                    }
                    ret += "<br />";
                    var size = (item ["size"] || 0);
                    if (size < kib) {
                        ret += "(%1 bytes)".arg (size.toFixed (0));
                    }
                    else if (size < mib) {
                        ret += "(%1 KiB)".arg ((size / kib).toFixed (1));
                    }
                    else if (size < gib) {
                        ret += "(%1 MiB)".arg ((size / mib).toFixed (2));
                    }
                    else if (size < tib) {
                        ret += "(%1 GiB)".arg ((size / gib).toFixed (3));
                    }
                    else {
                        ret += "(%1 TiB)".arg ((size / tib).toFixed (4));
                    }
                    if (!valid) {
                        ret += "<br />%1 items".arg (Walker.count);
                    }
                }
                return ret;
            }
            font {
                pixelSize: 48;
            }
            anchors {
                fill: parent;
                margins: 20;
            }
        }
    }
    Row {
        spacing: 6;
        visible: !Walker.working;
        anchors {
            top: parent.top;
            margins: 12;
            horizontalCenter: parent.horizontalCenter;
        }

        Repeater {
            model: {
                var url = "";
                var ret = [];
                var tmp = Walker.place.split ("/");
                tmp.forEach (function (name) {
                    url += (url !== "/" ? "/" + name : name);
                    name += "/";
                    ret.push ({ "name" : name, "url" : url });
                });
                return ret;
            }
            delegate: Text {
                text: (modelData ["name"] || "");
                color: (enabled ? "black" : "gray");
                enabled: (modelData ["url"].indexOf (Walker.base) > -1);
                font {
                    pixelSize: 18;
                    underline: (modelData ["url"] !== Walker.place);
                }

                MouseArea {
                    anchors.fill: parent;
                    onClicked: { Walker.changeTreePath (modelData ["url"] || ""); }
                }
            }
        }
        Text {
            text: "+";
            color: "darkblue";
            font {
                bold: true;
                pixelSize: 20;
            }

            MouseArea {
                anchors.fill: parent;
                onClicked: { completer.visible = true; }
            }
        }
    }
    Rectangle {
        id: completer;
        color: "darkgray";
        width: (parent.width / 2);
        height: (parent.height / 2);
        radius: 6;
        visible: false;
        antialiasing: true;
        anchors.centerIn: parent;

        Flow {
            spacing: 20;
            anchors {
                fill: parent;
                margins: 12;
            }

            Repeater {
                model: Walker.list.sort ();
                delegate: Text {
                    text: (modelData || "");
                    color: "darkblue";
                    font {
                        pixelSize: 14;
                        underline: true;
                    }

                    MouseArea {
                        anchors.fill: parent;
                        onClicked: { Walker.changeTreePath (Walker.place + "/" + parent.text); }
                    }
                }
            }
        }
    }
    Text {
        text: qsTr ("%1 nodes walked in %2 secs").arg (Walker.nodes.toFixed ()).arg (Walker.time.toFixed (3));
        color: "gray";
        font.italic: true;
        font.pixelSize: 18;
        anchors {
            left: parent.left;
            bottom: parent.bottom;
            margins: 8;
        }
    }
    Text {
        text: qsTr ("Please wait...");
        color: "gray";
        font.pixelSize: 42;
        visible: Walker.working;
        anchors.centerIn: parent;
    }
}

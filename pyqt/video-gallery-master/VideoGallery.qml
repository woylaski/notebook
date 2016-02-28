import QtQuick 2.0;
import QtMultimedia 5.0;
import Qt.labs.folderlistmodel 2.0;
import "Helpers.js" as Helpers;

Item {
    anchors.fill: parent;

    property string fontName : "sans-serif";

    property var specialPaths : [{ "label" : qsTr ("Root"), "uri" : "file:///" }];

    property int fontSize : 16;
    property int controlSize : 80;

    property int colWidth : 200;
    property int lineWidth : 1;

    property int padding : 10;
    property int rounding : 0;

    property color textColor : "white";
    property color borderColor : Qt.rgba (1, 1, 1, 0.35);
    property color buttonColor : Qt.rgba(0x22/255,0x22/255,0x22/255, 0.85);
    property color pressedColor : Qt.rgba(0x22/255,0x22/255,0x22/255, 0.65);

    readonly property bool isPlaying : player.visible;

    Video {
        id: thumbnailer;
        volume: 0;
        muted: true;
        width: 400;
        height: 300;
        opacity: 0.01;
        autoLoad: true;
        autoPlay: true;
        fillMode: VideoOutput.PreserveAspectCrop;
        anchors.bottom: parent.top;

        property var queue : [];

        property Image destItem : null;

        function enqueue (url, destItem) {
            if (!Shared.hasThumbnailForUrl (url)) {
                //console.log ("THUMBNAILER", "enqueue", url, destItem);
                queue.unshift ({ "url" : url, "destItem" : destItem });
                if (!timer.running) {
                    timer.start ();
                }
            }
            else {
                //console.log ("THUMBNAILER", "has thumbnail already", url, destItem);
                if (destItem !== null) {
                    destItem.source = Shared.getUrlFromLocalPath (Shared.getLocalFileForUrl (url));
                }
            }
        }

        Timer {
            id: timer;
            repeat: true;
            running: false;
            interval: 10;
            onTriggered: {
                //console.log ("THUMBNAILER", "triggered", thumbnailer.position, "/", thumbnailer.duration, thumbnailer.playbackState, thumbnailer.source);
                //if (currentStep) {
                //    console.log (">>>", Qt.formatTime (new Date, "hh:mm:ss.zzz"));
                //}
                if (!wait) {
                    if (elapsed > 5000 && currentStep !== stepWaiting) {
                        currentStep = stepWaiting;
                        thumbnailer.stop ();
                        elapsed = 0;
                        wait = 10;
                        //console.log ("THUMBNAILER", "abort");
                    }
                    else {
                        var pos = Math.floor (thumbnailer.duration / 2);
                        switch (currentStep) {
                        case stepWaiting:
                            if (thumbnailer.playbackState === MediaPlayer.StoppedState) {
                                if (thumbnailer.queue.length > 0) {
                                    currentStep = stepLoading;
                                    var tmp = thumbnailer.queue.pop ();
                                    thumbnailer.destItem  = tmp ["destItem"];
                                    thumbnailer.source    = tmp ["url"];
                                    elapsed = 0;
                                    wait = 0;
                                    //console.log ("THUMBNAILER", "processing");
                                }
                                else {
                                    timer.stop ();
                                }
                            }
                            break;
                        case stepLoading:
                            if (thumbnailer.playbackState === MediaPlayer.PlayingState) {
                                if (thumbnailer.duration > 0) {
                                    currentStep = stepSeeking;
                                    thumbnailer.pause ();
                                    thumbnailer.seek (pos);
                                    thumbnailer.play ();
                                    //console.log ("THUMBNAILER", "seeking position", pos);
                                }
                            }
                            break;
                        case stepSeeking:
                            if (thumbnailer.playbackState === MediaPlayer.PlayingState) {
                                if (thumbnailer.position >= pos + 100) {
                                    currentStep = stepPausing;
                                    thumbnailer.pause ();
                                    //console.log ("THUMBNAILER", "pausing");
                                }
                            }
                            break;
                        case stepPausing:
                            if (thumbnailer.playbackState === MediaPlayer.PausedState) {
                                currentStep = stepGrabing;
                                thumbnailer.grabToImage (function (result) {
                                    //console.log ("THUMBNAILER", "thumbnail grabbed", result.url);
                                    var localPath = Shared.getLocalFileForUrl (thumbnailer.source);
                                    //console.log ("THUMBNAILER", "local path", localPath);
                                    var localUrl = Shared.getUrlFromLocalPath (localPath);
                                    //console.log ("THUMBNAILER", "local url", localUrl);
                                    var done = result.saveToFile (localPath);
                                    //console.log ("THUMBNAILER", "saved", done);
                                    if (thumbnailer.destItem !== null) {
                                        thumbnailer.destItem.source = localUrl;
                                        thumbnailer.destItem = null;
                                    }
                                    thumbnailer.stop ();
                                    currentStep = stepWaiting;
                                    elapsed = 0;
                                    wait = 10;
                                    //console.log ("THUMBNAILER", "stopping");
                                });
                                //console.log ("THUMBNAILER", "grabbing thumbnail");
                            }
                            break;
                        case stepGrabing:
                            // NOTE : already grabbing, do nothing, just wait...
                            break;
                        default: break;
                        }
                    }
                }
                else {
                    wait--;
                }
                elapsed += interval;
            }

            property int wait : 0;

            property int elapsed : 0;

            property int currentStep : 0;

            readonly property int stepWaiting : 0; // wait for something to process
            readonly property int stepLoading : 1; // wait for video loaded and playing
            readonly property int stepSeeking : 2; // wait for video positionned
            readonly property int stepPausing : 3; // wait for streaming paused
            readonly property int stepGrabing : 4; // wait for image grabbed
        }
    }
    Flickable {
        id: flicker;
        contentHeight: layout.height;
        anchors.fill: parent;

        Column {
            id: layout;
            spacing: padding;
            anchors {
                top: parent.top;
                left: parent.left;
                right: parent.right;
                margins: padding;
            }

            Grid {
                id: gridDirs;
                columns: Math.floor (width / colWidth);
                spacing: padding;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }

                Repeater {
                    model: specialPaths;
                    delegate: Component {
                        MouseArea {
                            id: btn;
                            width: ((gridDirs.width - ((gridDirs.columns - 1) * padding)) / gridDirs.columns);
                            height: (width * 1 / 4);
                            onClicked: {
                                list.folder = Qt.resolvedUrl (modelData ["uri"]);
                            }

                            Rectangle {
                                id: rect;
                                color: (btn.pressed || list.folder.toString() === modelData ["uri"] ? pressedColor : buttonColor);
                                radius: rounding;
                                antialiasing: true;
                                border {
                                    width: lineWidth;
                                    color: borderColor;
                                }
                                anchors.fill: parent;
                            }
                            Text {
                                id: txt;
                                text: modelData ["label"]
                                color: textColor;
                                elide: Text.ElideRight;
                                height: (width * 1 / 4);
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                                maximumLineCount: 2;
                                verticalAlignment: Text.AlignVCenter;
                                horizontalAlignment: Text.AlignHCenter;
                                font {
                                    bold: true;
                                    family: fontName;
                                    pixelSize: fontSize;
                                }
                                anchors {
                                    fill: rect;
                                    margins: padding;
                                }
                            }
                        }
                    }
                }
                Repeater {
                    model: FolderListModel {
                        id: list;
                        folder: HomePath;
                        sortField: FolderListModel.Name;
                        sortReversed: false;
                        showDirsFirst: true;
                        showOnlyReadable: true;
                        showDotAndDotDot: true;
                        nameFilters: Helpers.extensions.map (function (val) {
                            return ("*." + val);
                        });
                    }
                    delegate: Component {
                        MouseArea {
                            id: btn;
                            width: ((gridDirs.width - ((gridDirs.columns - 1) * padding)) / gridDirs.columns);
                            height: (width * 1 / 4);
                            visible: (model.fileName !== "." && model.fileIsDir);
                            onClicked: {
                                if (model.fileIsDir) {
                                    list.folder = model.fileURL;
                                }
                            }

                            Rectangle {
                                id: rect;
                                color: (btn.pressed ? pressedColor : buttonColor);
                                radius: rounding;
                                antialiasing: true;
                                border {
                                    width: lineWidth;
                                    color: borderColor;
                                }
                                anchors.fill: parent;
                            }
                            Text {
                                id: txt;
                                text: model.fileName;
                                color: textColor;
                                elide: Text.ElideRight;
                                height: (width * 1 / 4);
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                                maximumLineCount: 2;
                                verticalAlignment: Text.AlignVCenter;
                                horizontalAlignment: Text.AlignHCenter;
                                font {
                                    family: fontName;
                                    pixelSize: fontSize;
                                }
                                anchors {
                                    fill: rect;
                                    margins: padding;
                                }
                            }
                        }
                    }
                }
            }
            Grid {
                id: gridFiles;
                spacing: padding;
                columns: Math.floor (width / colWidth);
                anchors {
                    left: parent.left;
                    right: parent.right;
                }

                Repeater {
                    model: FolderListModel {
                        folder: list.folder;
                        Component.onCompleted: {
                            sortField        = list.sortField;
                            sortReversed     = list.sortReversed;
                            showDirsFirst    = list.showDirsFirst;
                            showOnlyReadable = list.showOnlyReadable;
                            showDotAndDotDot = list.showDotAndDotDot;
                            nameFilters      = list.nameFilters;
                        }
                    }
                    delegate: Component {
                        MouseArea {
                            id: btn;
                            width: ((gridDirs.width - ((gridDirs.columns - 1) * padding)) / gridDirs.columns);
                            height: width;
                            visible: (model.fileName !== "." && !model.fileIsDir);
                            onClicked: {
                                if (!model.fileIsDir) {
                                    player.source = model.fileURL;
                                    Shared.updateChapters (model.fileURL);
                                }
                            }
                            Component.onCompleted: {
                                if (!model.fileIsDir && Helpers.extensions.contains (model.fileSuffix)) {
                                    thumbnailer.enqueue (model.fileURL.toString (), img);
                                }
                            }

                            Rectangle {
                                id: rect;
                                color: (btn.pressed ? pressedColor : buttonColor);
                                radius: rounding;
                                antialiasing: true;
                                border {
                                    width: lineWidth;
                                    color: borderColor;
                                }
                                anchors.fill: parent;
                            }
                            Image {
                                id: img;
                                height: (width * 3 / 4);
                                fillMode: Image.PreserveAspectCrop;
                                verticalAlignment: Image.AlignVCenter;
                                horizontalAlignment: Image.AlignHCenter;
                                anchors {
                                    top: rect.top;
                                    left: rect.left;
                                    right: rect.right;
                                    margins: rect.border.width;
                                }
                            }
                            Text {
                                id: txt;
                                text: model.fileBaseName;
                                color: textColor;
                                elide: Text.ElideRight;
                                height: (width * 1 / 4);
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                                maximumLineCount: 2;
                                verticalAlignment: Text.AlignVCenter;
                                horizontalAlignment: Text.AlignHCenter;
                                font {
                                    family: fontName;
                                    pixelSize: fontSize;
                                }
                                anchors {
                                    left: rect.left;
                                    right: rect.right;
                                    bottom: rect.bottom;
                                    margins: padding;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Item {
        id: scrollbar;
        width: 4;
        anchors {
            top: parent.top;
            right: parent.right;
            bottom: parent.bottom;
        }

        Rectangle {
            y: (scrollbar.height * flicker.visibleArea.yPosition);
            color: textColor;
            height: (scrollbar.height * flicker.visibleArea.heightRatio);
            visible: flicker.moving;
            opacity: 0.85;
            anchors {
                left: parent.left;
                right: parent.right;
            }
        }
    }
    Video {
        id: player;
        scale: (status !== MediaPlayer.NoMedia ? 1.0 : 0.0);
        visible: (scale > 0);
        autoLoad: true;
        autoPlay: true;
        fillMode: VideoOutput.PreserveAspectFit;
        anchors.fill: parent;

        Behavior on scale {
            NumberAnimation {
                duration: 150;
            }
        }
        Rectangle {
            z: -1;
            color: "black";
            anchors.fill: parent;
        }
        MouseArea {
            anchors.fill: parent;
            onWheel: { }
            onClicked: { toolbar.visible = !toolbar.visible; }
            onDoubleClicked: {
                /*window.visibility = (window.visibility !== Window.FullScreen
                                     ? Window.FullScreen
                                     : Window.Windowed);*/
            }
        }
        Column {
            id: toolbar;
            visible: false;
            spacing: 40;
            anchors {
                centerIn: parent;
                verticalCenterOffset: (parent.height / 4);
            }

            Item {
                width: 600;
                height: 10;
                anchors.horizontalCenter: parent.horizontalCenter;

                Rectangle {
                    color: "gray";
                    radius: 8;
                    opacity: 0.85;
                    anchors.fill: parent;
                    anchors.margins: -5;
                }
                Rectangle {
                    width: (player.position && player.duration
                            ? parent.width * player.position / player.duration
                            : 0);
                    color: textColor;
                    radius: 4;
                    border {
                        width: 2;
                        color: "black";
                    }
                    anchors {
                        top: parent.top;
                        left: parent.left;
                        bottom: parent.bottom;
                    }

                    Text {
                        text: Helpers.formatMsecs (player.position);
                        color: textColor;
                        style: Text.Outline;
                        styleColor: "black";
                        font.family: fontName;
                        font.pixelSize: fontSize;
                        anchors {
                            bottom: parent.top;
                            margins: 10;
                            horizontalCenter: parent.right;
                        }
                    }
                }
            }
            Row {
                spacing: (padding * 2);
                anchors.horizontalCenter: parent.horizontalCenter;

                MouseArea {
                    id: btnPlayPause;
                    width: controlSize;
                    height: controlSize;
                    onClicked: {
                        if (player.playbackState !== MediaPlayer.PlayingState) {
                            player.play ();
                        }
                        else {
                            player.pause ();
                        }
                    }

                    Rectangle {
                        color: "gray";
                        radius: 8;
                        opacity: 0.85;
                        anchors.fill: parent;
                    }
                    Rectangle {
                        width: 12;
                        height: 30;
                        color: textColor;
                        radius: 4;
                        visible: (player.playbackState === MediaPlayer.PlayingState);
                        border {
                            width: 2;
                            color: "black";
                        }
                        anchors.centerIn: parent;
                        anchors.horizontalCenterOffset: -8;
                    }
                    Rectangle {
                        width: 12;
                        height: 30;
                        color: textColor;
                        radius: 4;
                        visible: (player.playbackState === MediaPlayer.PlayingState);
                        border {
                            width: 2;
                            color: "black";
                        }
                        anchors.centerIn: parent;
                        anchors.horizontalCenterOffset: +8;
                    }
                    Item {
                        clip: true;
                        width: (height / 2);
                        height: 40;
                        visible: (player.playbackState !== MediaPlayer.PlayingState);
                        anchors.centerIn: parent;

                        Rectangle {
                            width: Math.sqrt (Math.pow (parent.height, 2) / 2);
                            height: width;
                            rotation: 45;
                            color: textColor;
                            border {
                                width: 2;
                                color: "black";
                            }
                            anchors {
                                verticalCenter: parent.verticalCenter;
                                horizontalCenter: parent.left;
                            }
                        }
                        Rectangle {
                            width: 2;
                            color: "black";
                            anchors {
                                top: parent.top;
                                left: parent.left;
                                bottom: parent.bottom;
                                topMargin: 2;
                                bottomMargin: 2;
                            }
                        }
                    }
                }
                MouseArea {
                    id: btnStop;
                    width: controlSize;
                    height: controlSize;
                    onClicked: {
                        player.stop ();
                        player.source = "";
                        Shared.updateChapters ();
                    }

                    Rectangle {
                        color: "gray";
                        radius: 8;
                        opacity: 0.85;
                        anchors.fill: parent;
                    }
                    Rectangle {
                        width: 30;
                        height: 30;
                        color: textColor;
                        radius: 4;
                        border {
                            width: 2;
                            color: "black";
                        }
                        anchors.centerIn: parent;
                    }
                }
                MouseArea {
                    width: controlSize;
                    height: controlSize;
                    onClicked: {
                        player.pause ();
                        if (Shared.modelChapters.length) {
                            for (var idx = Shared.modelChapters.length -1; idx > 0; idx--) {
                                var tmp = Shared.modelChapters [idx]["marker"];
                                if (tmp < player.position -1000) {
                                    player.seek (tmp);
                                    break;
                                }
                            }
                        }
                        else {
                            player.seek (Math.max (player.position -30000, 0));
                        }
                        player.play ();
                    }

                    Rectangle {
                        color: "gray";
                        radius: 8;
                        opacity: 0.85;
                        anchors.fill: parent;
                    }
                    Text {
                        text: (Shared.modelChapters.length ? "|<" : "<<");
                        color: textColor;
                        style: Text.Outline;
                        styleColor: "black";
                        font.pixelSize: 30;
                        anchors.centerIn: parent;
                    }
                }
                MouseArea {
                    width: controlSize;
                    height: controlSize;
                    visible: (Shared.modelChapters.length > 0);
                    onClicked: { menu.visible = true; }

                    Rectangle {
                        color: "gray";
                        radius: 8;
                        opacity: 0.85;
                        anchors.fill: parent;
                    }
                    Text {
                        text: "=";
                        color: textColor;
                        style: Text.Outline;
                        styleColor: "black";
                        font.pixelSize: 30;
                        anchors.centerIn: parent;
                    }
                }
                MouseArea {
                    width: controlSize;
                    height: controlSize;
                    onClicked: {
                        player.pause ();
                        if (Shared.modelChapters.length) {
                            for (var idx = 0; idx < Shared.modelChapters.length; idx++) {
                                var tmp = Shared.modelChapters [idx]["marker"];
                                if (tmp > player.position +1000) {
                                    player.seek (tmp);
                                    break;
                                }
                            }
                        }
                        else {
                            player.seek (Math.min (player.position +30000, player.duration));
                        }
                        player.play ();
                    }

                    Rectangle {
                        color: "gray";
                        radius: 8;
                        opacity: 0.85;
                        anchors.fill: parent;
                    }
                    Text {
                        text: (Shared.modelChapters.length ? ">|" : ">>");
                        color: textColor;
                        style: Text.Outline;
                        styleColor: "black";
                        font.pixelSize: 30;
                        anchors.centerIn: parent;
                    }
                }
            }
        }
        Rectangle {
            color: "black";
            opacity: 0.85;
            visible: menu.visible;
            anchors.fill: parent;
        }
        ListView {
            id: menu;
            visible: false;
            spacing: 20;
            model: Shared.modelChapters;
            delegate: Text {
                text: (modelData ["title"] || "");
                color: textColor;
                font.family: fontName;
                font.pixelSize: fontSize;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }

                MouseArea {
                    anchors {
                        fill: parent;
                        margins: -10;
                    }
                    onClicked: {
                        player.pause ();
                        var tmp = modelData ["marker"];
                        console.log ("seeking", tmp, modelData ["title"]);
                        player.seek (tmp);
                        menu.visible = false;
                        player.play ();
                    }
                }
            }
            anchors {
                fill: parent;
                margins: 20;
            }
        }
        Item {
            id: indicator;
            visible: (menu.visible && menu.moving);
            width: 4;
            anchors {
                top: parent.top;
                right: parent.right;
                bottom: parent.bottom;
            }

            Rectangle {
                y: (indicator.height * menu.visibleArea.yPosition);
                color: textColor;
                height: (indicator.height * menu.visibleArea.heightRatio);
                opacity: 0.85;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }
            }
        }
    }
}

import QtQuick 2.1;
import QtQmlTricks 1.0;
import QtLyricsChords 1.0;

Item {
    id: editor;

    property bool      useNightMode     : false;
    property bool      useNamedChords   : false;
    property int       currentCursorPos : -1;
    property string    currentFileName  : "";
    property QtObject  currentAutoFocus : null;
    property GroupItem currentGroup     : null;
    property LineItem  currentLine      : null;
    property ChordItem currentChord     : null;

    readonly property int animDelay : 350;

    readonly property string fontName : {
        var ret = "sans-serif";
        var list = Qt.fontFamilies ();
        var hints = [
                    "Sail Sans Pro",
                    "Source Sans Pro",
                    "Ubuntu",
                    "Roboto",
                    "Droid Sans",
                    "Liberation Sans",
                    "Trebuchet MS",
                ];
        for (var idx = 0; idx < hints.length; idx++) {
            if (list.indexOf (hints [idx]) >= 0) {
                ret = hints [idx];
                break;
            }
        }
        return ret;
    }

    function getFileUrlFromName (name) {
        return ("file://" + Shared.basePath + "/" + name + ".json");
    }

    ScrollContainer {
        id: workspace;
        background: (useNightMode ? "black" : "white");
        showBorder: false;
        anchors {
            top: toolbar.bottom;
            left: dialog.right;
            right: sidebar.left;
            bottom: parent.bottom;
        }

        Flickable {
            id: flicker;
            contentWidth: Math.max (width, list.width + list.anchors.margins * 2);
            contentHeight: (list.height + list.anchors.margins * 2);
            flickableDirection: Flickable.HorizontalAndVerticalFlick;

            function ensureVisible (item) {
                if (canvas.arrowFormState) {
                    var delta = 0;
                    delta += list.y;
                    var ancestor = item.parent;
                    while (ancestor !== list) {
                        delta += ancestor.y;
                        ancestor = ancestor.parent;
                    }
                    delta += item.y;
                    delta += (item.height / 2);
                    delta -= (flicker.height / 2);
                    compoFlick.createObject (flicker, { "to" : delta });
                }
            }

            Component {
                id: compoFlick;

                SmoothedAnimation {
                    target: flicker;
                    property: "contentY";
                    velocity: 450;
                    loops: 1;
                    running: true;
                    alwaysRunToEnd: true;
                    onStopped: { destroy (); }
                }
            }

            Column {
                id: list;
                spacing: 72;
                enabled: canvas.arrowFormState;
                anchors {
                    top: parent.top;
                    margins: 24;
                    horizontalCenter: parent.horizontalCenter;
                }

                Item {
                    width: 1;
                    height: (workspace.height / 2);
                    visible: canvas.arrowFormState;
                }
                TextInput {
                    id: inputTitle;
                    text: Shared.currentSongItem.title;
                    color: (useNightMode ? "white" : "black");
                    selectByMouse: true;
                    selectionColor: "steelblue";
                    selectedTextColor: "white";
                    activeFocusOnPress: true;
                    font.family: fontName;
                    font.pixelSize: 24.
                    font.underline: true;
                    onTextChanged: {
                        if (activeFocus) {
                            Shared.currentSongItem.title = text;
                            flicker.ensureVisible (inputTitle);
                        }
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {
                            currentGroup = null;
                            currentLine  = null;
                            currentChord = null;
                            flicker.ensureVisible (inputTitle);
                        }
                    }
                    anchors.horizontalCenter: parent.horizontalCenter;

                    Rectangle {
                        color: "transparent";
                        radius: 6;
                        visible: (inputTitle.activeFocus && enabled);
                        antialiasing: true;
                        border {
                            width: 1;
                            color: "steelblue";
                        }
                        anchors {
                            fill: inputTitle;
                            margins: -4;
                        }
                    }
                }
                Repeater {
                    model: Shared.currentSongItem.modelGroups;
                    delegate: Column {
                        id: delegateGroup;
                        spacing: 36;
                        anchors.horizontalCenter: list.horizontalCenter;
                        onYChanged: { tryRepositionate (); }
                        onHeightChanged: { tryRepositionate (); }
                        onMustSeeChanged: { tryRepositionate (); }
                        onIsCurrentChanged: { tryRepositionate (); }

                        readonly property bool      isCurrent : (currentGroup === groupItem);
                        readonly property bool      mustSee   : (groupItem === currentAutoFocus);
                        readonly property GroupItem groupItem : model.qtObject;

                        function tryRepositionate () {
                            if (isCurrent && y >= 0 && height >= 0) {
                                if (mustSee) {
                                    inputGroup.forceActiveFocus ();
                                    inputGroup.selectAll ();
                                    currentAutoFocus = null;
                                }
                                flicker.ensureVisible (delegateGroup);
                            }
                        }

                        TextInput {
                            id: inputGroup;
                            text: delegateGroup.groupItem.group;
                            color: (useNightMode ? "white" : "black");
                            selectByMouse: true;
                            selectionColor: "steelblue";
                            selectedTextColor: "white";
                            activeFocusOnPress: true;
                            font.family: fontName;
                            font.italic: true;
                            font.pixelSize: 16;
                            anchors.horizontalCenter: delegateGroup.horizontalCenter;
                            onTextChanged: {
                                if (delegateGroup.isCurrent) {
                                    delegateGroup.groupItem.group = text;
                                }
                            }

                            Rectangle {
                                height: 2;
                                color: "steelblue";
                                visible: (delegateGroup.isCurrent && enabled);
                                anchors {
                                    left: inputGroup.left;
                                    right: inputGroup.right;
                                    bottom: inputGroup.bottom;
                                    margins: -4;
                                }
                            }
                            MouseArea {
                                visible: !delegateGroup.isCurrent;
                                anchors.fill: parent;
                                onClicked: {
                                    currentGroup = delegateGroup.groupItem;
                                    currentLine  = null;
                                    currentChord = null;
                                    inputGroup.forceActiveFocus ();
                                    inputGroup.cursorPosition = inputGroup.positionAt (mouse.x, mouse.y, TextInput.CursorOnCharacter);
                                }
                            }
                        }
                        Repeater {
                            model: delegateGroup.groupItem.modelLines;
                            delegate: TextInput {
                                id: delegateLyric;
                                text:  delegateLyric.lineItem.lyrics;
                                color: (useNightMode ? "white" : "black");
                                selectByMouse: true;
                                selectionColor: "steelblue";
                                selectedTextColor: "white";
                                activeFocusOnPress: true;
                                font.family: fontName;
                                font.pixelSize: 20;
                                anchors.horizontalCenter: delegateGroup.horizontalCenter;
                                onCursorPositionChanged: {
                                    if (isCurrent) {
                                        currentCursorPos = cursorPosition;
                                        currentChord = null;
                                    }
                                }
                                onTextChanged: {
                                    if (isCurrent) {
                                        var delta = (text.length - delegateLyric.lineItem.lyrics.length);
                                        var pos = (cursorPosition - delta);
                                        for (var idx = 0; idx < delegateLyric.lineItem.modelChords.count; idx++) {
                                            var chord = delegateLyric.lineItem.modelChords.get (idx);
                                            if (chord ["position"] >= pos) {
                                                chord ["position"] += delta;
                                            }
                                        }
                                        delegateLyric.lineItem.lyrics = text;
                                    }
                                }
                                onYChanged: { tryRepositionate (); }
                                onHeightChanged: { tryRepositionate (); }
                                onMustSeeChanged: { tryRepositionate (); }
                                onIsCurrentChanged: { tryRepositionate (); }

                                readonly property bool     isCurrent : (lineItem === currentLine);
                                readonly property bool     mustSee   : (lineItem === currentAutoFocus);
                                readonly property LineItem lineItem  : model.qtObject;

                                function tryRepositionate () {
                                    if (isCurrent && y >= 0 && height >= 0) {
                                        if (mustSee) {
                                            forceActiveFocus ();
                                            selectAll ();
                                            currentAutoFocus = null;
                                        }
                                        flicker.ensureVisible (delegateLyric);
                                    }
                                }

                                MouseArea {
                                    visible: !delegateLyric.isCurrent;
                                    anchors.fill: parent;
                                    onClicked: {
                                        currentGroup = delegateGroup.groupItem;
                                        currentLine  = delegateLyric.lineItem;
                                        currentChord = null;
                                        delegateLyric.forceActiveFocus ();
                                        delegateLyric.cursorPosition = delegateLyric.positionAt (mouse.x, mouse.y, TextInput.CursorOnCharacter);
                                        currentCursorPos = delegateLyric.cursorPosition;
                                    }
                                }
                                Rectangle {
                                    color: "transparent";
                                    radius: 6;
                                    visible: (delegateLyric.isCurrent && enabled);
                                    antialiasing: true;
                                    border {
                                        width: 1;
                                        color: "steelblue";
                                    }
                                    anchors {
                                        fill: delegateLyric;
                                        margins: -4;
                                    }
                                }
                                Repeater {
                                    model: delegateLyric.lineItem.modelChords;
                                    delegate: Text {
                                        id: delegateChord;
                                        text: Shared.getChordNotation (delegateChord.chordItem.type,
                                                                       delegateChord.chordItem.variant,
                                                                       delegateChord.chordItem.extra,
                                                                       useNamedChords);
                                        color: (delegateChord.isCurrent && enabled
                                                ? (useNightMode ? "skyblue" : "steelblue")
                                                : (useNightMode ? "white" : "black"));
                                        textFormat: Text.PlainText;
                                        font.bold: true;
                                        font.family: fontName;
                                        font.pixelSize: 18;
                                        anchors {
                                            bottom: delegateLyric.top;
                                            margins: 4;
                                        }

                                        readonly property bool      isCurrent : (currentChord === chordItem);
                                        readonly property ChordItem chordItem : model.qtObject;

                                        Binding on x {
                                            value: (delegateLyric.length && delegateLyric.contentWidth
                                                    ? delegateLyric.positionToRectangle (delegateChord.chordItem.position).x
                                                    : 0);
                                        }
                                        MouseArea {
                                            anchors {
                                                fill: delegateChord;
                                                margins: -4;
                                            }
                                            onClicked: {
                                                currentGroup = delegateGroup.groupItem;
                                                currentLine  = delegateLyric.lineItem;
                                                delegateLyric.forceActiveFocus ();
                                                delegateLyric.cursorPosition = delegateChord.chordItem.position;
                                                currentChord = delegateChord.chordItem;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Item {
                    width: 1;
                    height: (workspace.height / 2);
                    visible: canvas.arrowFormState;
                }
            }
        }
    }
    Rectangle {
        id: toolbar;
        color: "darkslategray";
        height: 86;
        anchors {
            top: parent.top;
            left: parent.left;
            right: parent.right;
        }

        Canvas {
            id: canvas;
            width: toolbar.height;
            rotation: 180;
            contextType: "2d";
            renderTarget: Canvas.FramebufferObject;
            renderStrategy: Canvas.Cooperative;
            states: State {
                when: canvas.arrowFormState;

                PropertyChanges {
                    target: canvas;
                    angle: 180;
                }
                PropertyChanges {
                    target: canvas;
                    morphProgress: 1;
                }
            }
            transitions: Transition {
                RotationAnimation {
                    property: "angle";
                    direction: RotationAnimation.Clockwise;
                    easing.type: Easing.InOutCubic;
                    duration: animDelay;
                }
                NumberAnimation {
                    property: "morphProgress";
                    easing.type: Easing.InOutCubic;
                    duration: animDelay;
                }
            }
            anchors {
                top: toolbar.top;
                right: toolbar.right;
                bottom: toolbar.bottom;
            }
            onAngleChanged: { requestPaint (); }
            onMorphProgressChanged: { requestPaint (); }
            onPaint: {
                // The context keeps its state between paint calls, reset the transform
                context.resetTransform ();

                context.fillStyle = "darkcyan";
                context.fillRect (0, 0, width, height);

                // Rotate from the center
                context.translate (width / 2, height / 2);
                context.rotate (angle * Math.PI / 180);
                context.translate (-width / 2, -height / 2);

                var left = width * 0.25;
                var right = width * 0.75;
                var vCenter = height * 0.5;
                var vDelta = height / 6;

                // Use our cubic-interpolated morphProgress to extract other animation parameter values
                var vArrowEndDelta = interpolate (vDelta, vDelta * 1.25, morphProgress);
                var vArrowTipDelta = interpolate (vDelta, 0, morphProgress);
                var arrowEndX = interpolate (left, right - vArrowEndDelta, morphProgress);

                context.lineCap = "square";
                context.lineWidth = (vDelta * 0.45);
                context.strokeStyle = "white";
                var lineCapAdjustment = interpolate (0, context.lineWidth / 2, morphProgress);

                context.beginPath();
                context.moveTo (arrowEndX, vCenter - vArrowEndDelta);
                context.lineTo (right, vCenter - vArrowTipDelta);
                context.moveTo (left + lineCapAdjustment, vCenter);
                context.lineTo (right - lineCapAdjustment, vCenter);
                context.moveTo (arrowEndX, vCenter + vArrowEndDelta);
                context.lineTo (right, vCenter + vArrowTipDelta);
                context.stroke ();
            }

            property bool arrowFormState : false;
            property real angle          : 0;
            property real morphProgress  : 0;

            function interpolate (first, second, ratio) {
                return first + (second - first) * ratio;
            }

            function toggle () {
                arrowFormState = !arrowFormState;
            }

            MouseArea {
                onClicked: { canvas.toggle (); }
                anchors.fill: parent;
            }
        }
        WrapLeftRightContainer {
            spacing: 12;
            dontWrap: true;
            leftItems: [
                IconTextButton {
                    label: (toolbar.width >= 940 ? qsTr ("Create new") : "");
                    iconName: "new";
                    backColor: (pressed ? "turquoise" : "darkcyan");
                    labelColor: (pressed ? "black" : "white");
                    labelFont.family: fontName;
                    onClicked: {
                        currentFileName = "";
                        currentCursorPos = -1;
                        currentGroup = null;
                        currentLine  = null;
                        currentChord = null;
                        Shared.currentSongItem.title = "[new untitled song]";
                        Shared.currentSongItem.modelGroups.clear ();
                        dialog.open = false;
                    }
                },
                IconTextButton {
                    label: (toolbar.width >= 940 ? qsTr ("Open JSON") : "");
                    iconName: "open";
                    backColor: (pressed ? "turquoise" : "darkcyan");
                    labelColor: (pressed ? "black" : "white");
                    labelFont.family: fontName;
                    onClicked: {
                        dialog.open = true;
                    }
                },
                IconTextButton {
                    label: (toolbar.width >= 940 ? qsTr ("Save to JSON") : "");
                    iconName: "save";
                    backColor: (pressed ? "turquoise" : "darkcyan");
                    labelColor: (pressed ? "black" : "white");
                    labelFont.family: fontName;
                    onClicked: {
                        if (currentFileName === "") {
                            currentFileName = Shared.currentSongItem.title;
                            currentFileName = currentFileName.replace (/[^aàbcçdeéèêëfghiîïjklmnoôöpqrstuùûüvwxyz0123456789_-\s\.]/gi, "");
                            currentFileName = currentFileName.replace (/\s+/g, " ");
                        }
                        var path = getFileUrlFromName (currentFileName);
                        var json = Shared.currentSongItem.exportToJson ();
                        Shared.writeTextFile (Qt.resolvedUrl (path), json);
                    }
                }
            ]
            rightItems: [
                IconTextButton {
                    label: (useNamedChords ? qsTr ("Named chords") : qsTr ("Lettered chords"));
                    backColor: (pressed ? "turquoise" : "darkcyan");
                    labelColor: (pressed ? "black" : "white");
                    labelFont.family: fontName;
                    onClicked: { useNamedChords = !useNamedChords; }
                },
                IconTextButton {
                    label: (toolbar.width >= 940 ? (useNightMode ? qsTr ("Night mode") : qsTr ("Day mode")) : "");
                    iconName: (useNightMode ? "moon" : "sun");
                    backColor: (pressed ? "turquoise" : "darkcyan");
                    labelColor: (pressed ? "black" : "white");
                    labelFont.family: fontName;
                    onClicked: { useNightMode = !useNightMode; }
                }
            ]
            anchors {
                left: parent.left;
                right: canvas.left;
                margins: 24;
                verticalCenter: parent.verticalCenter;
            }
        }
    }
    ScrollContainer {
        id: sidebar;
        width: 380;
        showBorder: false;
        background: "silver";
        anchors {
            top: toolbar.bottom;
            right: parent.right;
            bottom: parent.bottom;
            rightMargin: (canvas.arrowFormState ? 0 : -width);
        }

        Behavior on anchors.rightMargin {
            NumberAnimation {
                easing.type: Easing.InOutCubic;
                duration: animDelay;
            }
        }

        Flickable {
            contentHeight: (layout.implicitHeight + layout.anchors.margins * 2);
            flickableDirection: Flickable.VerticalFlick;

            Column {
                id: layout;
                spacing: 12;
                anchors {
                    top: parent.top;
                    left: parent.left;
                    right: parent.right;
                    margins: 18;
                }

                Column {
                    visible: currentChord;
                    spacing: 6;
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }

                    Text {
                        text: qsTr ("Chord");
                        horizontalAlignment: Text.AlignHCenter;
                        font {
                            weight: Font.Light;
                            family: fontName;
                            pixelSize: 24;
                        }
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                    }
                    GridContainer {
                        cols: 6;
                        rows: 2;
                        colSpacing: 1;
                        rowSpacing: 1;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        Repeater {
                            id: repeaterKeys;
                            model: [
                                ChordKey.A,  ChordKey.Bb, ChordKey.B,
                                ChordKey.C,  ChordKey.Db, ChordKey.D,
                                ChordKey.Eb, ChordKey.E,  ChordKey.F,
                                ChordKey.Gb, ChordKey.G,  ChordKey.Ab,
                            ];
                            delegate: Item {
                                implicitWidth: btn.implicitWidth;
                                implicitHeight: btn.implicitHeight;

                                IconTextButton {
                                    id: btn;
                                    label: (modelData !== undefined ? Shared.getChordNotation (modelData,
                                                                                               ChordVariant.Major,
                                                                                               ChordExtra.None,
                                                                                               false) : "");
                                    rounding: 0;
                                    visible: (label !== "");
                                    backColor: (isCurrent ? "steelblue" : "lightgray");
                                    labelColor: (isCurrent ? "white" : "black");
                                    labelFont.family: fontName;
                                    anchors.fill: parent;
                                    onClicked: { currentChord.type = (isCurrent ? ChordKey.Unknown : modelData); }

                                    readonly property bool isCurrent : (currentChord && currentChord.type === modelData);
                                }
                            }
                        }
                    }
                    GridContainer {
                        cols: 6;
                        colSpacing: 1;
                        visible: (currentChord && currentChord.type > ChordKey.Unknown);
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        Repeater {
                            id: repeaterVariants;
                            model: [
                                ChordVariant.Minor,
                                ChordVariant.Sus2,
                                ChordVariant.Sus4,
                                ChordVariant.Dim,
                                ChordVariant.Aug,
                            ];
                            delegate: IconTextButton {
                                label: Shared.getChordNotation (ChordKey.A, modelData, ChordExtra.None, false).slice (1);
                                rounding: 0;
                                backColor: (isCurrent ? "steelblue" : "lightgray");
                                labelColor: (isCurrent ? "white" : "black");
                                labelFont.family: fontName;
                                onClicked: { currentChord.variant = (isCurrent ? ChordVariant.Major : modelData); }

                                readonly property bool isCurrent : (currentChord && currentChord.variant === modelData);
                            }
                        }
                    }
                    GridContainer {
                        cols: 6;
                        colSpacing: 1;
                        visible: (currentChord && currentChord.type > ChordKey.Unknown);
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        Repeater {
                            id: repeaterExtras;
                            model: [
                                ChordExtra.Dom6th,
                                ChordExtra.Dom7th,
                                ChordExtra.Dom8th,
                            ];
                            delegate: IconTextButton {
                                label: Shared.getChordNotation (ChordKey.A, ChordVariant.Major, modelData, false).slice (1);
                                rounding: 0;
                                backColor: (isCurrent ? "steelblue" : "lightgray");
                                labelColor: (isCurrent ? "white" : "black");
                                labelFont.family: fontName;
                                onClicked: { currentChord.extra = (isCurrent ? ChordExtra.None : modelData); }

                                readonly property bool isCurrent : (currentChord && currentChord.extra === modelData);
                            }
                        }
                    }
                    Rectangle {
                        id: piano;
                        clip: true;
                        color: "darkgray";
                        height: whiteKeysHeight;
                        visible: (currentChord && currentChord.type > ChordKey.Unknown);
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        readonly property real whiteKeysWidth  : (width / 7);
                        readonly property real whiteKeysHeight : (whiteKeysWidth * 4);
                        readonly property real whiteKeysRadius : (whiteKeysWidth / 10);

                        readonly property real blackKeysWidth  : (whiteKeysWidth * 2 / 3);
                        readonly property real blackKeysHeight : (whiteKeysHeight * 2 / 3);
                        readonly property real blackKeysRadius : (blackKeysWidth / 4);

                        function getKey (base, offset) {
                            return ((base + offset) % 12);
                        }

                        readonly property var currentKeys : {
                            var ret = [];
                            if (currentChord) {
                                var baseKey = currentChord.type;
                                if (baseKey !== ChordKey.Unknown) {
                                    ret.push (baseKey);
                                    switch (currentChord.variant) {
                                    case ChordVariant.Major:
                                        ret.push (getKey (baseKey, 4    ));
                                        ret.push (getKey (baseKey, 4 + 3));
                                        break;
                                    case ChordVariant.Minor:
                                        ret.push (getKey (baseKey, 3    ));
                                        ret.push (getKey (baseKey, 3 + 4));
                                        break;
                                    case ChordVariant.Sus4:
                                        ret.push (getKey (baseKey, 5    ));
                                        ret.push (getKey (baseKey, 5 + 2));
                                        break;
                                    case ChordVariant.Sus2:
                                        ret.push (getKey (baseKey, 2    ));
                                        ret.push (getKey (baseKey, 2 + 5));
                                        break;
                                    case ChordVariant.Dim:
                                        ret.push (getKey (baseKey, 3    ));
                                        ret.push (getKey (baseKey, 3 + 3));
                                        break;
                                    case ChordVariant.Aug:
                                        ret.push (getKey (baseKey, 4    ));
                                        ret.push (getKey (baseKey, 4 + 4));
                                        break;
                                    default:
                                        break;
                                    }
                                    switch (currentChord.extra) {
                                    case ChordExtra.Dom6th:
                                        ret.push (getKey (baseKey, 9));
                                        break;
                                    case ChordExtra.Dom7th:
                                        ret.push (getKey (baseKey, 10));
                                        break;
                                    case ChordExtra.Dom8th:
                                        ret.push (getKey (baseKey, 11));
                                        break;
                                    default:
                                        break;
                                    }
                                }
                            }
                            return ret;
                        }

                        Repeater {
                            model: [
                                { "num" : ChordKey.C,  "type" : "white", "position" : 0, "offset" :  0.00 },
                                { "num" : ChordKey.Db, "type" : "black", "position" : 1, "offset" : -0.65 },
                                { "num" : ChordKey.D,  "type" : "white", "position" : 1, "offset" :  0.00 },
                                { "num" : ChordKey.Eb, "type" : "black", "position" : 2, "offset" : -0.35 },
                                { "num" : ChordKey.E,  "type" : "white", "position" : 2, "offset" :  0.00 },
                                { "num" : ChordKey.F,  "type" : "white", "position" : 3, "offset" :  0.00 },
                                { "num" : ChordKey.Gb, "type" : "black", "position" : 4, "offset" : -0.65 },
                                { "num" : ChordKey.G,  "type" : "white", "position" : 4, "offset" :  0.00 },
                                { "num" : ChordKey.Ab, "type" : "black", "position" : 5, "offset" : -0.50 },
                                { "num" : ChordKey.A,  "type" : "white", "position" : 5, "offset" :  0.00 },
                                { "num" : ChordKey.Bb, "type" : "black", "position" : 6, "offset" : -0.35 },
                                { "num" : ChordKey.B,  "type" : "white", "position" : 6, "offset" :  0.00 },
                            ];
                            delegate: Rectangle {
                                id: key;
                                x: (piano.whiteKeysWidth * modelData ["position"] + width * modelData ["offset"]);
                                border {
                                    width: 1;
                                    color: "gray";
                                }
                                anchors {
                                    top: parent.top;
                                    topMargin: -radius;
                                }
                                state: (modelData ["type"] || "");
                                states: [
                                    State {
                                        name: "white";

                                        PropertyChanges {
                                            target: key;
                                            z: (100 + model.index);
                                            color: (key.isSelected ? "lightblue" : "white");
                                            width: piano.whiteKeysWidth;
                                            height: piano.whiteKeysHeight;
                                            radius: piano.whiteKeysRadius;
                                        }
                                    },
                                    State {
                                        name: "black";

                                        PropertyChanges {
                                            target: key;
                                            z: (200 + model.index);
                                            color: (key.isSelected ? "steelblue" : "black");
                                            width: piano.blackKeysWidth;
                                            height: piano.blackKeysHeight;
                                            radius: piano.blackKeysRadius;
                                        }
                                    }
                                ]

                                readonly property bool isSelected : (piano.currentKeys.indexOf (modelData ["num"]) >= 0);

                                Text {
                                    text: (piano.currentKeys.indexOf (modelData ["num"]) +1).toString ();
                                    color: "black";
                                    visible: (text !== "0");
                                    font {
                                        weight: Font.Light;
                                        family: fontName;
                                        pixelSize: 16;
                                    }
                                    anchors {
                                        bottom: parent.bottom;
                                        margins: 8;
                                        horizontalCenter: parent.horizontalCenter;
                                    }
                                }
                            }
                        }
                        Rectangle {
                            z: 300;
                            color: "darkcyan";
                            height: 12;
                            anchors {
                                top: parent.top;
                                left: parent.left;
                                right: parent.right;
                            }
                        }
                    }
                    GridContainer {
                        cols: 3;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Left");
                            iconName: "left";
                            labelFont.family: fontName;
                            onClicked: { currentLine.moveChordLeft (currentChord) }
                        }
                        Item {
                            Text {
                                text: qsTr ("Move");
                                font {
                                    weight: Font.Light;
                                    family: fontName;
                                    pixelSize: 18;
                                }
                                anchors.centerIn: parent;
                            }
                        }
                        IconTextButton {
                            label: qsTr ("Right");
                            iconName: "right";
                            labelFont.family: fontName;
                            onClicked: { currentLine.moveChordRight (currentChord) }
                        }
                    }
                    IconTextButton {
                        label: qsTr ("Remove current chord");
                        iconName: "remove";
                        labelColor: "darkred";
                        labelFont.family: fontName;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onClicked: {
                            currentLine.removeChord (currentChord);
                            currentChord = null;
                        }
                    }
                }
                Column {
                    visible: currentLine;
                    spacing: 6;
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }

                    Text {
                        text: qsTr ("Lyrics line");
                        horizontalAlignment: Text.AlignHCenter;
                        font {
                            weight: Font.Light;
                            family: fontName;
                            pixelSize: 24;
                        }
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                    }
                    IconTextButton {
                        label: qsTr ("Add new chord at position");
                        iconName: "add";
                        labelFont.family: fontName;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onClicked: {
                            currentAutoFocus = currentLine.addNewChord (currentCursorPos);
                            currentChord = currentAutoFocus;
                        }
                    }
                    GridContainer {
                        cols: 3;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Up");
                            iconName: "up";
                            labelFont.family: fontName;
                            onClicked: { currentGroup.moveLineUp (currentLine); }
                        }
                        Item {
                            Text {
                                text: qsTr ("Move");
                                font {
                                    weight: Font.Light;
                                    family: fontName;
                                    pixelSize: 18;
                                }
                                anchors.centerIn: parent;
                            }
                        }
                        IconTextButton {
                            label: qsTr ("Down");
                            iconName: "down";
                            labelFont.family: fontName;
                            onClicked: { currentGroup.moveLineDown (currentLine); }
                        }
                    }
                    GridContainer {
                        cols: 2;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Duplicate");
                            iconName: "copy";
                            labelFont.family: fontName;
                            onClicked: { currentGroup.duplicateLine (currentLine); }
                        }
                        IconTextButton {
                            label: qsTr ("Delete");
                            iconName: "remove";
                            labelColor: "darkred";
                            labelFont.family: fontName;
                            onClicked: {
                                currentGroup.removeLine (currentLine);
                                currentLine  = null;
                                currentChord = null;
                            }
                        }
                    }
                }
                Column {
                    visible: currentGroup;
                    spacing: 6;
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }

                    Text {
                        text: qsTr ("Lines group");
                        horizontalAlignment: Text.AlignHCenter;
                        font {
                            weight: Font.Light;
                            family: fontName;
                            pixelSize: 24;
                        }
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                    }
                    IconTextButton {
                        label: qsTr ("Add new line");
                        iconName: "add";
                        labelFont.family: fontName;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onClicked: {
                            var pos = (currentLine && currentGroup.modelLines.contains (currentLine)
                                       ? (currentGroup.modelLines.indexOf (currentLine) +1)
                                       : (!currentGroup.modelLines.isEmpty ()
                                          ? currentGroup.modelLines.count
                                          : 0));
                            currentAutoFocus = currentGroup.addNewLine (pos);
                            currentLine  = currentAutoFocus;
                            currentChord = null;
                        }
                    }
                    GridContainer {
                        cols: 3;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Low");
                            iconName: "remove";
                            labelFont.family: fontName;
                            onClicked: { currentGroup.transposeLow (); }
                        }
                        Item {
                            Text {
                                text: qsTr ("Transpose");
                                font {
                                    weight: Font.Light;
                                    family: fontName;
                                    pixelSize: 18;
                                }
                                anchors.centerIn: parent;
                            }
                        }
                        IconTextButton {
                            label: qsTr ("High");
                            iconName: "add";
                            labelFont.family: fontName;
                            onClicked: { currentGroup.transposeHigh (); }
                        }
                    }
                    GridContainer {
                        cols: 3;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Up");
                            iconName: "up";
                            labelFont.family: fontName;
                            onClicked: { Shared.currentSongItem.moveGroupUp (currentGroup); }
                        }
                        Item {
                            Text {
                                text: qsTr ("Move");
                                font {
                                    weight: Font.Light;
                                    family: fontName;
                                    pixelSize: 18;
                                }
                                anchors.centerIn: parent;
                            }
                        }
                        IconTextButton {
                            label: qsTr ("Down");
                            iconName: "down";
                            labelFont.family: fontName;
                            onClicked: { Shared.currentSongItem.moveGroupDown (currentGroup); }
                        }
                    }
                    GridContainer {
                        cols: 2;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Duplicate");
                            iconName: "copy";
                            labelFont.family: fontName;
                            onClicked: { Shared.currentSongItem.duplicateGroup (currentGroup); }
                        }
                        IconTextButton {
                            label: qsTr ("Delete");
                            iconName: "remove";
                            labelColor: "darkred";
                            labelFont.family: fontName;
                            onClicked: {
                                Shared.currentSongItem.removeGroup (currentGroup);
                                currentGroup = null;
                                currentLine  = null;
                                currentChord = null;
                            }
                        }
                    }
                }
                Column {
                    spacing: 6;
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }

                    Text {
                        text: qsTr ("Song");
                        horizontalAlignment: Text.AlignHCenter;
                        font {
                            weight: Font.Light;
                            family: fontName;
                            pixelSize: 24;
                        }
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                    }
                    IconTextButton {
                        label: qsTr ("Add new group");
                        iconName: "add";
                        labelFont.family: fontName;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }
                        onClicked: {
                            var pos = (currentGroup && Shared.currentSongItem.modelGroups.contains (currentGroup)
                                       ? (Shared.currentSongItem.modelGroups.indexOf (currentGroup) +1)
                                       : (!Shared.currentSongItem.modelGroups.isEmpty ()
                                          ? Shared.currentSongItem.modelGroups.count
                                          : 0));
                            currentAutoFocus = Shared.currentSongItem.addNewGroup (pos);
                            currentGroup = currentAutoFocus;
                            currentLine  = null;
                            currentChord = null;
                        }
                    }
                    GridContainer {
                        cols: 3;
                        colSpacing: 6;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        IconTextButton {
                            label: qsTr ("Low");
                            iconName: "remove";
                            labelFont.family: fontName;
                            onClicked: { Shared.currentSongItem.transposeLow (); }
                        }
                        Item {
                            Text {
                                text: qsTr ("Transpose");
                                font {
                                    weight: Font.Light;
                                    family: fontName;
                                    pixelSize: 18;
                                }
                                anchors.centerIn: parent;
                            }
                        }
                        IconTextButton {
                            label: qsTr ("High");
                            iconName: "add";
                            labelFont.family: fontName;
                            onClicked: { Shared.currentSongItem.transposeHigh (); }
                        }
                    }
                }
            }
        }
    }
    ScrollContainer {
        id: dialog;
        width: 360;
        background: "#303030";
        showBorder: false;
        anchors {
            top: toolbar.bottom;
            left: parent.left;
            bottom: parent.bottom;
            leftMargin: (dialog.open ? 0 : -dialog.width);
        }

        property bool open : false;

        Behavior on anchors.leftMargin {
            NumberAnimation {
                easing.type: Easing.InOutCubic;
                duration: animDelay;
            }
        }
        ListView {
            model: Shared.modelFiles;
            flickableDirection: Flickable.VerticalFlick;
            header: Item {
                height: 64;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }

                IconTextButton {
                    label: qsTr ("Cancel");
                    backColor: "darkslategray";
                    labelColor: "white";
                    labelFont.family: fontName;
                    anchors.centerIn: parent;
                    onClicked: { dialog.open = false; }
                }
            }
            delegate: MouseArea {
                height: 42;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }
                onClicked: {
                    currentFileName = model.fileName;
                    var path = getFileUrlFromName (currentFileName);
                    var json = Shared.readTextFile (path);
                    Shared.currentSongItem.importFromJson (json);
                    dialog.open = false;
                }

                Rectangle {
                    color: (model.index % 2 ? "white" : "black");
                    opacity: 0.05;
                    anchors.fill: parent;
                }
                Text {
                    text: model.fileName;
                    color: (model.fileName === currentFileName ? "lightblue" : "white");
                    fontSizeMode: Text.HorizontalFit;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignLeft;
                    font {
                        weight: Font.Light;
                        family: fontName;
                        pixelSize: 18;
                    }
                    anchors {
                        left: parent.left;
                        right: parent.right;
                        margins: 12;
                        verticalCenter: parent.verticalCenter;
                    }
                }
            }
        }
    }
}

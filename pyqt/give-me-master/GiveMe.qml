import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import GiveMe 1.0;

Rectangle {
    id: win;
    color: Style.colorBlack;
    anchors.fill: parent;
    Component.onCompleted: {
        Style.spacingNormal  = 10;
        Style.fontSizeNormal = 16;
        Style.spacingSmall   = (Style.spacingNormal / 2);
        Style.spacingBig     = (Style.spacingNormal * 2);
        Style.fontSizeSmall  = (Style.fontSizeNormal * 0.85);
        Style.fontSizeBig    = (Style.fontSizeNormal * 1.15);
    }
    Component.onDestruction: { Qt.quit (); }

    property bool showSelector : false;

    Flipable {
        id: fliper;
        transform: Rotation {
            id: rotation;
            angle: (showSelector ? 180 : 0); // the default angle
            origin {
                x: (fliper.width  / 2);
                y: (fliper.height / 2);
            }
            axis {
                x: 0;
                y: 1; // set axis.y to 1 to rotate around y-axis
                z: 0;
            }

            Behavior on angle {
                NumberAnimation {
                    duration: 250;
                }
            }
        }
        front: Rectangle {
            color: Style.colorLightGray;
            enabled: (fliper.side === Flipable.Front);
            anchors.fill: parent;

            Rectangle {
                id: titlebar;
                height: (layoutHeader.height + layoutHeader.anchors.margins * 2);
                gradient: Style.gradientIdle ();
                ExtraAnchors.topDock: parent;

                Column {
                    id: layoutHeader;
                    spacing: Style.spacingNormal;
                    anchors {
                        margins: Style.spacingBig;
                        verticalCenter: parent.verticalCenter;
                    }
                    ExtraAnchors.horizontalFill: titlebar;

                    StretchRowContainer {
                        spacing: Style.spacingBig;
                        ExtraAnchors.horizontalFill: layoutHeader;

                        Item {
                            implicitWidth: (Style.fontSizeBig * 2);
                            implicitHeight: (Style.fontSizeBig * 2);
                            anchors.verticalCenter: parent.verticalCenter;

                            Image {
                                source: "image://icon-theme/%1".arg (SharedObject.localMachineType);
                                fillMode: Image.Stretch;
                                anchors.fill: parent;
                                anchors.margins: Style.lineSize;
                            }
                        }
                        ComboList {
                            model: ListModel { }
                            anchors.verticalCenter: parent.verticalCenter;
                            onCurrentKeyChanged: {
                                var tmp = (currentKey || "").trim ();
                                if (tmp !== "") {
                                    SharedObject.localMachineType = tmp;
                                }
                            }
                            Component.onCompleted: {
                                itemsList.forEach (function (item, idx) {
                                    model.append (item);
                                    if (item ["key"] === SharedObject.localMachineType) {
                                        currentIdx = idx;
                                    }
                                });
                            }

                            readonly property var itemsList : [
                                { "key" : "computer",    "value" : "Desktop PC" },
                                { "key" : "laptop",      "value" : "Laptop"     },
                                { "key" : "tablet",      "value" : "Tablet"     },
                                { "key" : "smartphone",  "value" : "Smartphone" },
                            ];
                        }
                        TextLabel {
                            text: SharedObject.localHostName;
                            font.pixelSize: Style.fontSizeBig;
                            font.underline: true;
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                    }
                    StretchRowContainer {
                        spacing: Style.spacingBig;
                        ExtraAnchors.horizontalFill: layoutHeader;

                        Item {
                            implicitWidth: (Style.fontSizeBig * 2);
                            implicitHeight: (Style.fontSizeBig * 2);
                            anchors.verticalCenter: parent.verticalCenter;

                            Image {
                                source: "image://icon-theme/avatar-default";
                                fillMode: Image.Stretch;
                                anchors.fill: parent;
                            }
                        }
                        TextBox {
                            id: inputUserName;
                            textHolder: "User name";
                            implicitWidth: -1;
                            textFont.weight: Font.Normal;
                            anchors.verticalCenter: parent.verticalCenter;
                            onAccepted: { btnValidate.click (); }

                            Binding on text { value: SharedObject.localUserName; }
                        }
                        TextButton {
                            id: btnValidate;
                            text: "OK";
                            enabled: (inputUserName.text !== SharedObject.localUserName && inputUserName.text !== "");
                            anchors.verticalCenter: parent.verticalCenter;
                            onClicked: {
                                inputUserName.focus = false;
                                SharedObject.localUserName = inputUserName.text.trim ();
                                inputUserName.text = SharedObject.localUserName;
                            }
                        }
                    }
                }
            }
            ScrollContainer {
                headerItem: Item {
                    height: (label.height + label.anchors.margins * 2);

                    TextLabel {
                        id: label;
                        text: "Peers detected";
                        font.pixelSize: Style.fontSizeBig;
                        anchors.margins: Style.spacingSmall;
                        anchors.centerIn: parent;
                    }
                }
                anchors {
                    top: titlebar.bottom;
                    bottom: scrollerLog.top;
                }
                ExtraAnchors.horizontalFill: parent;

                ListView {
                    model: SharedObject.modelUsers;
                    delegate: MouseArea {
                        id: clicker;
                        height: (layout.height + layout.anchors.margins * 2);
                        enabled: (model.type !== UserModelItem.Local);
                        ExtraAnchors.horizontalFill: parent;
                        onClicked: {
                            selector.referer = model.qtObject;
                            showSelector = true;
                        }

                        Rectangle {
                            visible: clicker.pressed;
                            opacity: 0.35;
                            gradient: Style.gradientPressed ();
                            anchors.fill: parent;
                        }
                        Rectangle {
                            color: Style.colorLightGray;
                            height: Style.lineSize;
                            ExtraAnchors.bottomDock: parent;
                        }
                        Column {
                            id: layout;
                            spacing: Style.spacingNormal;
                            anchors {
                                margins: Style.spacingBig;
                                verticalCenter: parent.verticalCenter;
                            }
                            ExtraAnchors.horizontalFill: parent;

                            StretchRowContainer {
                                spacing: Style.spacingNormal;
                                ExtraAnchors.horizontalFill: layout;

                                Item {
                                    implicitWidth: (Style.fontSizeBig * 2);
                                    implicitHeight: (Style.fontSizeBig * 2);
                                    anchors.verticalCenter: parent.verticalCenter;

                                    Image {
                                        source: "image://icon-theme/%1".arg (model.machineType);
                                        fillMode: Image.PreserveAspectCrop;
                                        verticalAlignment: Image.AlignVCenter;
                                        horizontalAlignment: Image.AlignHCenter;
                                        anchors.fill: parent;
                                    }
                                }
                                TextLabel {
                                    id: identifier;
                                    text: ("<b>" + model.userName + "</b>"
                                           + " @ " + model.hostName);
                                    color: (model.type === UserModelItem.Local
                                            ? Style.colorGray
                                            : Style.colorBlack);
                                    font.pixelSize: Style.fontSizeBig;
                                    anchors.verticalCenter: parent.verticalCenter;
                                }
                                Item { implicitWidth: -1; }
                                TextLabel {
                                    text: "(self)";
                                    color: Style.colorSteelBlue;
                                    visible: (model.type === UserModelItem.Local);
                                    anchors.baseline: identifier.baseline;
                                }
                            }
                            Repeater {
                                model: modelTransfers;
                                delegate: Column {
                                    spacing: Style.spacingSmall;
                                    ExtraAnchors.horizontalFill: layout;

                                    Row {
                                        id: info;
                                        spacing: Style.spacingNormal;

                                        TextLabel {
                                            text: (model.mode === TransfersModelItem.Receiving
                                                   ? "Receiving"
                                                   : (model.mode === TransfersModelItem.Sending
                                                      ? "Sending"
                                                      : ""));
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                        Image {
                                            source: (model.mimeIcon !== ""
                                                     ? "image://icon-theme/%1".arg (model.mimeIcon)
                                                     : "");
                                            width: size;
                                            height: size;
                                            fillMode: Image.Stretch;
                                            anchors.verticalCenter: parent.verticalCenter;

                                            readonly property int size : (Style.fontSizeNormal * 2);
                                        }
                                        TextLabel {
                                            text: model.fileName;
                                            font.bold: true;
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                        TextLabel {
                                            text: ("(waiting...)");
                                            visible: (model.status === TransfersModelItem.Pending);
                                            font.italic: true;
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                        TextLabel {
                                            text: ("(asked...)");
                                            visible: (model.status === TransfersModelItem.Asked &&
                                                      model.mode === TransfersModelItem.Sending);
                                            font.italic: true;
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                        TextLabel {
                                            visible: (model.status === TransfersModelItem.Started);
                                            text: "(%1/s)".arg (SharedObject.formatSize (model.speed));
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                    }
                                    Row {
                                        id: choice;
                                        spacing: Style.spacingNormal;
                                        visible: (model.status === TransfersModelItem.Asked &&
                                                  model.mode === TransfersModelItem.Receiving);

                                        TextLabel {
                                            text: "Accept ?";
                                            anchors.verticalCenter: parent.verticalCenter;
                                        }
                                        GridContainer {
                                            cols: 2;
                                            capacity: 2;
                                            colSpacing: Style.spacingNormal;
                                            anchors.verticalCenter: parent.verticalCenter;

                                            TextButton {
                                                text: "Yes";
                                                backColor: "green";
                                                textColor: Style.colorWhite;
                                                icon: Image { source: "image://icon-theme/dialog-yes"; }
                                                onClicked: { qtObject.accept (); }
                                            }
                                            TextButton {
                                                text: "No";
                                                backColor: "red";
                                                textColor: Style.colorWhite;
                                                icon: Image { source: "image://icon-theme/dialog-no"; }
                                                onClicked: { qtObject.refuse (); }
                                            }
                                        }
                                    }
                                    Item {
                                        id: progressbar;
                                        height: Style.spacingNormal;
                                        visible: (model.status === TransfersModelItem.Started);
                                        ExtraAnchors.horizontalFill: parent;

                                        Rectangle {
                                            radius: (Style.roundness + Style.lineSize * 2);
                                            antialiasing: true;
                                            gradient: Style.gradientEditable ();
                                            border {
                                                width: Style.lineSize;
                                                color: Style.colorSteelBlue;
                                            }
                                            anchors {
                                                fill: parent;
                                                margins: -Style.lineSize;
                                            }
                                        }
                                        Rectangle {
                                            width: (model.totalSize > 0
                                                    ? model.currentSize * layout.width / model.totalSize
                                                    : 0);
                                            visible: (model.totalSize > 0);
                                            gradient: Style.gradientChecked ();
                                            radius: Style.roundness;
                                            antialiasing: true;
                                            ExtraAnchors.bottomDock: parent;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            ScrollContainer {
                id: scrollerLog;
                height: (win.height / 4);
                headerItem: Item {
                    height: (label.height + label.anchors.margins * 2);

                    TextLabel {
                        id: label;
                        text: "Transfers log";
                        font.pixelSize: Style.fontSizeBig;
                        anchors {
                            margins: Style.spacingSmall;
                            centerIn: parent;
                        }
                    }
                }
                ExtraAnchors.bottomDock: parent;

                ListView {
                    model: SharedObject.modelTransfers;
                    delegate: Item {
                        height: (layout.height + layout.anchors.margins * 2);
                        enabled: (TransfersModelItem.Finished);
                        ExtraAnchors.horizontalFill: parent;

                        StretchRowContainer {
                            id: layout;
                            spacing: Style.spacingSmall;
                            anchors {
                                margins: Style.spacingSmall;
                                verticalCenter: parent.verticalCenter;
                            }
                            ExtraAnchors.horizontalFill: parent;

                            Item {
                                width: implicitWidth;
                                height: implicitHeight;
                                implicitWidth: size;
                                implicitHeight: size;
                                anchors.verticalCenter: parent.verticalCenter;

                                readonly property int size : (Style.fontSizeNormal * 2);

                                Image {
                                    source: (model.mimeIcon !== ""
                                             ? "image://icon-theme/%1".arg (model.mimeIcon)
                                             : "");
                                    fillMode: Image.Stretch;
                                    anchors.fill: parent;
                                }
                            }
                            Item {
                                height: implicitHeight;
                                implicitWidth: -1;
                                implicitHeight: col.height;
                                anchors.verticalCenter: parent.verticalCenter;

                                Column {
                                    id: col;
                                    ExtraAnchors.horizontalFill: parent;

                                    Row {
                                        spacing: Style.spacingSmall;

                                        TextLabel {
                                            text: model.fileName;
                                            font.bold: true;
                                            font.pixelSize: Style.fontSizeSmall;
                                        }
                                        TextLabel {
                                            text: ("(failed)");
                                            color: "darkred";
                                            visible: (model.status === TransfersModelItem.Failed);
                                            font.italic: true;
                                            font.pixelSize: Style.fontSizeSmall;
                                        }
                                        TextLabel {
                                            text: ("(suceeded)");
                                            color: "darkgreen";
                                            visible: (model.status === TransfersModelItem.Finished);
                                            font.italic: true;
                                            font.pixelSize: Style.fontSizeSmall;
                                        }
                                    }
                                    Row {
                                        spacing: Style.spacingSmall;

                                        TextLabel {
                                            text: (model.mode === TransfersModelItem.Receiving
                                                   ? "received from"
                                                   : (model.mode === TransfersModelItem.Sending
                                                      ? "sent to"
                                                      : ""));
                                            font.pixelSize: Style.fontSizeSmall;
                                        }
                                        TextLabel {
                                            text: (model.peer.userName + "@" + model.peer.hostName);
                                            font.italic: true;
                                            font.pixelSize: Style.fontSizeSmall;
                                        }
                                    }
                                }
                            }
                            TextButton {
                                icon: Image {
                                    width: (Style.fontSizeSmall * 2);
                                    height: (Style.fontSizeSmall * 2);
                                    source: "image://icon-theme/document-open";
                                }
                                padding: Style.spacingSmall;
                                anchors.verticalCenter: parent.verticalCenter;
                                onClicked: { Qt.openUrlExternally (model.fileUrl); }
                            }
                            TextButton {
                                icon: Image {
                                    width: (Style.fontSizeSmall * 2);
                                    height: (Style.fontSizeSmall * 2);
                                    source: "image://icon-theme/edit-clear";
                                }
                                padding: Style.spacingSmall;
                                anchors.verticalCenter: parent.verticalCenter;
                                onClicked: { SharedObject.modelTransfers.remove (model.qtObject); }
                            }
                        }
                    }
                }
            }
        }
        back: Rectangle {
            color: Style.colorLightGray;
            enabled: (fliper.side === Flipable.Back);
            anchors.fill: parent;

            FileSelector {
                id: selector;
                title: "Choose a file to send";
                anchors.fill: parent;
                onSelected: {
                    if (referer !== null) {
                        SharedObject.sendFile (fileUrl, referer);
                    }
                    showSelector = false;
                }
                onCanceled: {
                    showSelector = false;
                }

                property UserModelItem referer : null;
            }
        }
        anchors.fill: parent;
    }
}

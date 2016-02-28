import QtQuick        2.1;
import QtQuick.Window 2.1;
import QtIrc          1.0;
import "components";

Window {
    id: window;
    color: "white";
    title: qsTr ("GIT UI Tool");
    width: 800;
    height: 480;
    visible: true;
    visibility: Window.Windowed;
    minimumWidth: 800;
    minimumHeight: 480;
    Component.onCompleted: {
        SharedObject.addNewServer ("chat.freenode.net", 6667);
        var freenode = SharedObject.servers.first ();
        freenode.connected.connect (function () {
            freenode.nicknameChanged.connect (function () {
                var list = ["test"];
                for (var tmp in list) {
                    freenode.sendMessage ("/join #%1".arg (list [tmp]));
                }
            });
            freenode.sendMessage ("/nick unnamed");
        });
    }

    property QtIrcChannel currentChannel  : null;
    property QtIrcServer  currentServer   : null;

    readonly property int    fontSize : 12;
    readonly property string fontName : "Ubuntu";

    Item {
        id: panelSide;
        width: 200;
        anchors {
            top: parent.top;
            left: parent.left;
            bottom: parent.bottom;
        }

        Rectangle {
            color: "#F7F5E4";
            anchors.fill: parent;
        }
        LabelTitle {
            id: titleRooms;
            text: qsTr ("Rooms");
            anchors {
                top: parent.top;
                left: parent.left;
                right: parent.right;
            }
        }
        Flickable {
            id: flickSideTop;
            clip: true;
            contentWidth: width;
            contentHeight: layoutServers.height;
            anchors {
                top: titleRooms.bottom;
                left: parent.left;
                right: parent.right;
                bottom: separator.top;
            }

            Column {
                id: layoutServers;
                anchors {
                    left: parent.left;
                    right: parent.right;
                }

                Repeater {
                    id: repeaterServers;
                    model: SharedObject.servers;
                    delegate: Column {
                        id: delegateServer;
                        anchors {
                            left: parent.left;
                            right: parent.right;
                        }

                        property QtIrcServer serverEntry : model.qtObject;

                        LabelNormal {
                            id: lblServer;
                            height: 30;
                            enabled: delegateServer.serverEntry.online;
                            hasBackground: true;
                            text: delegateServer.serverEntry.host;
                            hasSelection: (currentChannel === delegateServer.serverEntry.defaultChannelEntry);
                            isItalic: false;
                            isBold: true;
                            anchors {
                                left: parent.left;
                                right: parent.right;
                            }
                            onClicked: {
                                currentServer  = delegateServer.serverEntry;
                                currentChannel = delegateServer.serverEntry.defaultChannelEntry;
                            }
                        }
                        Column {
                            id: layoutChannels;
                            anchors {
                                left: parent.left;
                                right: parent.right;
                            }

                            Repeater {
                                id: repeaterChannels;
                                model: SortFilterProxyModel {
                                    sourceModel: delegateServer.serverEntry.channels;
                                    sortRole: delegateServer.serverEntry.channels.roleForName ("name");
                                }
                                delegate: LabelNormal {
                                    id: lblChannel;
                                    hasBackground: false;
                                    text: channelEntry.name;
                                    hasSelection: (currentChannel === channelEntry);
                                    visible: (delegateServer.serverEntry.defaultChannelEntry !== channelEntry);
                                    isItalic: channelEntry.hasUnreadMessages;
                                    anchors {
                                        left: layoutChannels.left;
                                        right: layoutChannels.right;
                                    }
                                    onClicked: {
                                        currentServer  = delegateServer.serverEntry;
                                        currentChannel = channelEntry;
                                        channelEntry.hasUnreadMessages = false;
                                    }

                                    property QtIrcChannel channelEntry : model.qtObject;
                                }
                            }
                        }
                    }
                }
            }
        }
        VScrollIndicator { flicker: flickSideTop; }
        Rectangle {
            id: separator;
            height: 1;
            color: "#CCCCCC";
            anchors {
                left: parent.left;
                right: parent.right;
                verticalCenter: parent.verticalCenter;
            }
        }
        Rectangle {
            width: 1;
            color: "#CCCCCC";
            anchors {
                top: parent.top;
                right: parent.right;
                bottom: parent.bottom;
            }
        }
    }
    Item {
        id: containerWorkspaces;
        anchors {
            top: parent.top;
            left: panelSide.right;
            right: parent.right;
            bottom: parent.bottom;
        }

        Repeater {
            model: SharedObject.servers;
            delegate: Item {
                id: workspaceServer;
                opacity: (isCurrentServer ? 1.0 : 0.0);
                visible: (opacity > 0.0);
                enabled: visible;
                focus: enabled;
                anchors.fill: containerWorkspaces;

                property bool        isCurrentServer : (currentServer === serverEntry);
                property QtIrcServer serverEntry     : model.qtObject;

                Repeater {
                    model: qtObject.channels;
                    delegate: FocusScope {
                        id: workspaceChannel;
                        opacity: (isCurrentChannel ? 1.0 : 0.0);
                        visible: (opacity > 0.0);
                        enabled: visible;
                        focus: enabled;
                        anchors.fill: workspaceServer;

                        property bool         isCurrentChannel : (currentChannel === channelEntry);
                        property QtIrcChannel channelEntry     : model.qtObject;

                        Rectangle {
                            color: "white";
                            anchors.fill: parent;
                        }
                        Item {
                            id: panelMembers;
                            visible: (workspaceChannel.channelEntry.name [0] === "#");
                            width: panelSide.width;
                            anchors {
                                top: parent.verticalCenter
                                right: parent.left;
                                bottom: parent.bottom;
                            }

                            LabelTitle {
                                id: titleMembers;
                                text: qsTr ("Members");
                                anchors {
                                    top: parent.top;
                                    left: parent.left;
                                    right: parent.right;
                                }
                            }
                            Flickable {
                                id: flickSideBottom;
                                clip: true;
                                contentHeight: vLayoutSideBottom.height;
                                contentWidth: width;
                                anchors {
                                    top: titleMembers.bottom;
                                    left: parent.left;
                                    right: parent.right;
                                    bottom: parent.bottom;
                                }

                                Column {
                                    id: vLayoutSideBottom;
                                    spacing: 0;
                                    anchors {
                                        top: parent.top;
                                        left: parent.left;
                                        right: parent.right;
                                    }

                                    Repeater {
                                        model: SortFilterProxyModel {
                                            sourceModel: workspaceChannel.channelEntry.members;
                                            sortRole: workspaceChannel.channelEntry.members.roleForName ("nickname");
                                        }
                                        delegate: LabelNormal {
                                            text: (model.nickname || "");
                                            anchors {
                                                left: vLayoutSideBottom.left;
                                                right: vLayoutSideBottom.right;
                                            }
                                            onClicked: { editInput.insert (editInput.length, "@%1, ".arg (model.nickname)); }
                                        }
                                    }
                                }
                            }
                            VScrollIndicator { flicker: flickSideBottom; }
                        }
                        Item {
                            id: panelInput;
                            height: (rectInput.height + rectInput.anchors.margins * 2);
                            anchors {
                                left: parent.left;
                                right: parent.right;
                                bottom: parent.bottom;
                            }

                            Rectangle {
                                color: "#ECECEC";
                                anchors.fill: parent;
                            }
                            Rectangle {
                                height: 2;
                                color: "#F9F9F9";
                                anchors {
                                    top: parent.top;
                                    left: parent.left;
                                    right: parent.right;
                                }
                            }
                            Rectangle {
                                height: 1;
                                color: "#CCCCCC";
                                anchors {
                                    top: parent.top;
                                    left: parent.left;
                                    right: parent.right;
                                }
                            }
                            Text {
                                id: lblNickname;
                                text: workspaceServer.serverEntry.nickname;
                                font {
                                    family: fontName;
                                    pixelSize: fontSize;
                                    weight: Font.Bold;
                                }
                                anchors {
                                    left: parent.left;
                                    margins: 10;
                                    verticalCenter: rectInput.verticalCenter;
                                }
                            }
                            Rectangle {
                                id: rectInput;
                                radius: 8;
                                antialiasing: true;
                                height: (editInput.contentHeight + editInput.anchors.margins * 2);
                                border {
                                    color: "#CCCCCC";
                                    width: 1;
                                }
                                anchors {
                                    top: parent.top;
                                    left: lblNickname.right;
                                    right: parent.right;
                                    margins: 10;
                                }

                                TextEdit {
                                    id: editInput;
                                    color: "black";
                                    focus: true;
                                    textFormat: TextEdit.PlainText;
                                    selectByMouse: true;
                                    selectionColor: "#2153C7";
                                    selectedTextColor: "white";
                                    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
                                    anchors {
                                        top: parent.top;
                                        left: parent.left;
                                        right: parent.right;
                                        margins: 8;
                                    }

                                    Keys.onPressed: {
                                        var tmp = text.trim ();
                                        switch (event.key) {
                                        case Qt.Key_Return:
                                            if (!(event.modifiers & Qt.ShiftModifier) && tmp !== "") {
                                                workspaceServer.serverEntry.sendMessage (tmp,
                                                                                         workspaceChannel.channelEntry);
                                                text = "";
                                                event.accepted = true;
                                            }
                                            break;
                                        default:
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: panelTopic;
                            height: (titleTopic.contentHeight + titleTopic.anchors.margins * 2);
                            visible: (repeaterMsg.model !== 0)
                            anchors {
                                top: parent.top;
                                left: parent.left;
                                right: parent.right;
                            }

                            Text {
                                id: titleTopic;
                                text: (workspaceChannel.channelEntry !== workspaceServer.serverEntry.defaultChannelEntry
                                       ? workspaceChannel.channelEntry.topic
                                       : workspaceChannel.channelEntry.name);
                                color: "#406698";
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                                font {
                                    family: fontName;
                                    pixelSize: fontSize;
                                    weight: Font.Light;
                                    italic: true;
                                }
                                anchors {
                                    top: parent.top;
                                    left: parent.left;
                                    right: parent.right;
                                    margins: 5;
                                }
                            }

                            Rectangle {
                                height: 1;
                                color: "#CCCCCC";
                                anchors {
                                    left: parent.left;
                                    right: parent.right;
                                    bottom: parent.bottom;
                                }
                            }
                        }
                        Item {
                            id: workspace;
                            anchors {
                                top: panelTopic.bottom;
                                left: parent.left;
                                right: parent.right;
                                bottom: panelInput.top;
                            }

                            Flickable {
                                id: flickMsg;
                                clip: true;
                                contentHeight: (vLayoutMsg.height + vLayoutMsg.anchors.margins * 2);
                                contentWidth: width;
                                anchors.fill: parent;

                                Column {
                                    id: vLayoutMsg;
                                    spacing: 5;
                                    anchors {
                                        top: parent.top;
                                        left: parent.left;
                                        right: parent.right;
                                        margins: 5;
                                    }

                                    Repeater {
                                        id: repeaterMsg;
                                        model: qtObject.messages;
                                        delegate: Row {
                                            id: delegateMessage;
                                            spacing: 10;
                                            anchors {
                                                left: vLayoutMsg.left;
                                                right: vLayoutMsg.right;
                                            }

                                            property QtIrcMessage messageEntry : model.qtObject;

                                            property color textColor : {
                                                switch (messageEntry.type) {
                                                    case QtIrcMessage.Status: return "gray";
                                                    case QtIrcMessage.Error:  return "darkred";
                                                    case QtIrcMessage.Normal: (messageEntry.toMe
                                                                               ? "orange"
                                                                               : (messageEntry.fromMe
                                                                                  ? "steelblue"
                                                                                  : "black"));
                                                }
                                            }

                                            Text {
                                                id: lblTime;
                                                text: "(%1)".arg (Qt.formatDateTime(qtObject.timestamp, "hh:mm:ss"));
                                                color: delegateMessage.textColor;
                                                width: 50;
                                                opacity: 0.65;
                                                font {
                                                    family: fontName;
                                                    pixelSize: fontSize * 0.85;
                                                    weight: Font.Light;
                                                }
                                            }
                                            Text {
                                                id: lblNick;
                                                text: (qtObject.from !== "" ? "%1 :".arg (qtObject.from) : "");
                                                color: delegateMessage.textColor;
                                                elide: Text.ElideRight;
                                                width: 150;
                                                font {
                                                    family: fontName;
                                                    pixelSize: fontSize;
                                                    underline: true;
                                                    weight: Font.Bold;
                                                }

                                                MouseArea {
                                                    anchors.fill: parent;
                                                    visible: (qtObject.from !== "");
                                                    onClicked: { editInput.insert (editInput.length, "@%1, ".arg (qtObject.from)); }
                                                }
                                            }
                                            Text {
                                                id: lblMsg;
                                                text: qtObject.content;
                                                color: delegateMessage.textColor;
                                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                                                width: parent.width - (parent.spacing * 2) - lblTime.width - lblNick.width;
                                                font {
                                                    family: fontName;
                                                    pixelSize: fontSize;
                                                    weight: Font.Light;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            VScrollIndicator { flicker: flickMsg; }
                        }
                    }
                }
            }
        }
    }
}


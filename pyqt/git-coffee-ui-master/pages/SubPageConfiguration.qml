import QtQuick 2.1;
import QtQmlTricks.UiElements 2.0;
import QtGit 5.0;

StretchColumnContainer {
    spacing: Style.spacingBig;
    anchors {
        fill: parent;
        margins: Style.spacingBig;
    }

    readonly property var configs : [
        {
            "legend" : qsTr ("User name :"),
            "key"    : "user.name",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("User e-mail :"),
            "key"    : "user.email",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("Pager :"),
            "key"    : "core.pager",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("Editor :"),
            "key"    : "core.editor",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("Merge tool :"),
            "key"    : "merge.tool",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("Diff tool :"),
            "key"    : "diff.tool",
            "type"   : "string",
        },
        {
            "legend" : qsTr ("Filemode :"),
            "key"    : "core.filemode",
            "type"   : "bool",
        },
        {
            "legend" : qsTr ("Auto CRLF :"),
            "key"    : "core.autocrlf",
            "type"   : "choice",
            "list"   : [
                { "key" : "false", "value" : qsTr ("False (Default)") },
                { "key" : "true",  "value" : qsTr ("True")  },
                { "key" : "input", "value" : qsTr ("Input") },
            ]
        },
        {
            "legend" : qsTr ("Safe CRLF :"),
            "key"    : "core.safecrlf",
            "type"   : "choice",
            "list"   : [
                { "key" : "false", "value" : qsTr ("False (Default)") },
                { "key" : "true",  "value" : qsTr ("True")  },
                { "key" : "warn",  "value" : qsTr ("Warn")  },
            ]
        },
        {
            "legend" : qsTr ("Push default :"),
            "key"    : "push.default",
            "type"   : "choice",
            "list"   : [
                { "key" : "simple",   "value" : qsTr ("Push current branch to its upstream if they have same name (Default)")  },
                { "key" : "upstream", "value" : qsTr ("Push current branch to its upstream")  },
                { "key" : "current",  "value" : qsTr ("Push current branch to same name remote")  },
                { "key" : "matching", "value" : qsTr ("Push all matching branches (same local/upstream name)") },
                { "key" : "nothing",  "value" : qsTr ("Do not push anything")  },
            ]
        },
        {
            "legend" : qsTr ("Push rebase :"),
            "key"    : "pull.rebase",
            "type"   : "choice",
            "list"   : [
                { "key" : "false",    "value" : qsTr ("False (Default)") },
                { "key" : "true",     "value" : qsTr ("True")  },
                { "key" : "preserve", "value" : qsTr ("Preserve local merge commits")  },
            ]
        },
        {
            "legend" : qsTr ("Merge-conflict style :"),
            "key"    : "merge.conflictStyle",
            "type"   : "choice",
            "list"   : [
                { "key" : "merge", "value" : qsTr ("Simple merge (Default)") },
                { "key" : "diff3", "value" : qsTr ("3-ways diff")  },
            ]
        },
    ];

    TextLabel {
        text: qsTr ("Change GIT configuration :");
        style: Text.Sunken;
        styleColor: Style.colorEditable;
        font.pixelSize: Style.fontSizeTitle;
    }
    Line { }
    ScrollContainer {
        showBorder: true;
        implicitHeight: -1;

        Flickable {
            contentHeight: (layout.height + layout.anchors.margins * 2);
            flickableDirection: Flickable.VerticalFlick;

            Column {
                id: metricsLegend;

                Repeater {
                    model: configs;
                    delegate: TextLabel {
                        text: modelData ["legend"];
                        font.weight: Font.Bold;
                        color: Style.colorNone;
                    }
                }
            }
            StretchColumnContainer {
                id: layout;
                spacing: Style.spacingBig;
                anchors.margins: Style.spacingBig;
                ExtraAnchors.topDock: parent;

                Repeater {
                    model: configs;
                    delegate: StretchRowContainer {
                        spacing: Style.spacingNormal;

                        Stretcher {
                            height: implicitHeight;
                            implicitWidth: metricsLegend.width;
                            implicitHeight: lbl.contentHeight;
                            anchors.verticalCenter: parent.verticalCenter;

                            TextLabel {
                                id: lbl;
                                text: modelData ["legend"];
                                font.weight: Font.Bold;
                                anchors.right: parent.right;
                            }
                        }
                        CheckableBox {
                            id: checker;
                            value: (ok.indexOf (Shared.getConfigValue (modelData ["key"])) > -1);
                            visible: (modelData ["type"] === "bool");
                            anchors.verticalCenter: parent.verticalCenter;
                            onValueChanged: {
                                Shared.setConfigValue (modelData ["key"], value ? "true" : "false");
                            }

                            readonly property var ok : ["true", "yes", "on", "1"];
                        }
                        Stretcher { visible: (modelData ["type"] === "bool"); }
                        ComboList {
                            id: combo;
                            visible: (modelData ["type"] === "choice");
                            implicitWidth: -1;
                            model: ListModel {
                                Component.onCompleted: {
                                    var tmp = Shared.getConfigValue (modelData ["key"]);
                                    if (Array.isArray (modelData ["list"])) {
                                        modelData ["list"].forEach (function (item, idx) {
                                            append (item);
                                            if (item ["key"] === tmp) {
                                                combo.currentIdx = idx;
                                            }
                                        });
                                    }
                                    combo.ready = true;
                                }
                            }
                            anchors.verticalCenter: parent.verticalCenter;
                            onCurrentKeyChanged: {
                                if (ready) {
                                    Shared.setConfigValue (modelData ["key"], currentKey);
                                }
                            }

                            property bool ready : false;
                        }
                        TextBox {
                            id: field;
                            text: Shared.getConfigValue (modelData ["key"]);
                            visible: (modelData ["type"] === "string");
                            readOnly: true;
                            textColor: (readOnly ? Style.colorLink : Style.colorForeground);
                            implicitWidth: -1;
                            textFont.underline: readOnly;
                            anchors.verticalCenter: parent.verticalCenter;
                            Keys.onReturnPressed: { btnSave.click (); }
                            Keys.onEscapePressed: { btnCancel.click (); }

                            MouseArea {
                                visible: field.readOnly
                                anchors.fill: parent;
                                onClicked: {
                                    field.readOnly = false;
                                    field.forceActiveFocus ();
                                }
                            }
                        }
                        TextButton {
                            id: btnCancel;
                            visible: (!field.readOnly && field.visible);
                            icon: Loader {
                                id: cross;
                                sourceComponent: Style.symbolCross;
                                states: State {
                                    when: (cross.item !== null);

                                    PropertyChanges {
                                        target: cross.item;
                                        size: Style.fontSizeNormal;
                                        color: (enabled ? Style.colorForeground : Style.colorBorder);
                                    }
                                }
                            }
                            onClicked: {
                                field.text = Shared.getConfigValue (modelData ["key"]);
                                field.readOnly = true;
                            }
                        }
                        TextButton {
                            id: btnSave;
                            visible: (!field.readOnly && field.visible);
                            icon: Loader {
                                id: check;
                                sourceComponent: Style.symbolCheck;
                                states: State {
                                    when: (check.item !== null);

                                    PropertyChanges {
                                        target: check.item;
                                        size: Style.fontSizeNormal;
                                        color: (enabled ? Style.colorForeground : Style.colorBorder);
                                    }
                                }
                            }
                            onClicked: {
                                Shared.setConfigValue (modelData ["key"], field.text);
                                field.readOnly = true;
                            }
                        }
                    }
                }
            }
        }
    }
}

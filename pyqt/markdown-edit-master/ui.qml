import QtQuick 2.1;
import QtQuick.Window 2.1;
import QtQuick.Layouts 1.1;
import QtQuick.Controls 1.1;
import QtQuick.Controls.Styles 1.1;
import QtWebKit.experimental 1.0; // FIXME : use WebEngine ASAP !!!
import "markdown-core.js" as MarkDown;

ApplicationWindow {
    id: window;
    title: qsTr ("MarkDown Edit");
    width: 1280;
    height: 800;
    visible: true;
    visibility: Window.Maximized;
    toolBar: ToolBar {
        id: toolbar;
        height: 64;

        RowLayout {
            spacing: 12;
            anchors {
                left: parent.left;
                margins: 12
                verticalCenter: parent.verticalCenter;
            }

            ToolButton {
                text: qsTr ("New document");
                iconSource: "icons/add.svg";
            }
            ToolButton {
                text: qsTr ("Open existing...");
                iconSource: "icons/open.svg";
                onClicked: { dialogOpen.visible = true; }
            }
            ToolButton {
                text: qsTr ("Save content");
                iconSource: "icons/save.svg";
            }
            ToolButton {
                text: qsTr ("Export HTML");
                iconSource: "icons/export.svg";
            }
        }
    }
    statusBar: StatusBar {
        id: statusbar;
        height: 32;

    }

    property string css : TextFileHelper.read (":/style-default.css");

    property string currentFilePath : "";

    property bool showViewerPanel     : true;
    property bool showEditorPanel     : true;
    property bool showNavigationPanel : true;

    readonly property string fontName          : "Ubuntu";
    readonly property string fontFixedName     : "Ubuntu Mono";

    readonly property int    fontSizeSmall     : 11;
    readonly property int    fontSizeNormal    : 14;
    readonly property int    fontSizeTitle     : 18;

    function gray (val) {
        var tmp = (val / 255);
        return Qt.rgba (tmp, tmp, tmp, 1.0);
    }

    Timer {
        id: timer;
        repeat: false;
        running: false;
        interval: 850;
        onTriggered: {
            var html = "";
            html += '<html>';
            html += '<head>';
            html += '<style type="text/css">';
            html += css;
            html += '</style>';
            html += '</head>';
            html += '<body>';
            html += MarkDown.md2html (editor.text);
            html += '</body>';
            html += '<html>';
            viewer.loadHtml (html);
        }
    }
    Component {
        id: styleButtonIconText;

        ButtonStyle {
            padding {
                top: 6;
                left: 6;
                right: 6;
                bottom: 6;
            }
            label: RowLayout {
                spacing: 12;
                anchors.fill: parent;

                Image {
                    source: control.iconSource;
                    opacity: (control.enabled ? 1.0 : 0.65);
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Label {
                    text: control.text;
                    color: (control.enabled ? "black" : "gray");
                    font.weight: Font.Light;
                    font.family: fontName;
                    font.pixelSize: fontSizeNormal;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                    Layout.fillWidth: true;
                    Layout.fillHeight: true;
                }
            }
        }
    }
    Component {
        id: styleScrollView;

        ScrollViewStyle {
            frame: Rectangle {
                color: "white";
                border {
                    width: 1;
                    color: "darkgray";
                }
            }
        }
    }
    RowLayout {
        id: layoutWorkspace;
        spacing: 0;
        anchors.fill: parent;

        Rectangle {
            id: sidePanel;
            color: gray (40);
            visible: showNavigationPanel;
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.minimumWidth: (parent.width / 5);
            Layout.maximumWidth: 400;

            ScrollView {
                frameVisible: false;
                anchors.fill: parent;

                ListView {
                    model: 100;
                    delegate: Text {
                        text: "%1. Header".arg (model.index +1);
                        height: 36;
                        color: gray (200);
                        verticalAlignment: Text.AlignVCenter;
                        font {
                            family: fontName;
                            weight: Font.Light;
                            pixelSize: fontSizeTitle;
                        }
                        anchors {
                            left: parent.left;
                            right: parent.right;
                            margins: 6;
                        }
                    }
                }
            }
        }
        Rectangle {
            id: editPanel;
            color: gray (230);
            visible: showEditorPanel;
            Layout.fillWidth: true;
            Layout.fillHeight: true;

            TextArea {
                id: editor;
                focus: true;
                activeFocusOnPress: true;
                wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
                textMargin: 12;
                textFormat: TextEdit.PlainText;
                selectByMouse: true;
                selectByKeyboard: true;
                frameVisible: false;
                backgroundVisible: false;
                tabChangesFocus: false;
                horizontalAlignment: TextEdit.AlignLeft;
                style: TextAreaStyle {
                    textColor: "black";
                    selectionColor: "steelblue";
                    selectedTextColor: "white";
                    backgroundColor: "transparent";
                }
                font {
                    family: fontFixedName;
                    weight: Font.Light;
                    pixelSize: fontSizeNormal;
                }
                anchors.fill: parent;
                onTextChanged: { timer.restart (); }
                Component.onCompleted: {
                    text = TextFileHelper.read (":/example.md");
                }
            }
            Rectangle {
                width: 1;
                color: "darkgray";
                anchors {
                    top: parent.top;
                    right: parent.right;
                    bottom: parent.bottom;
                }
            }
        }
        Rectangle {
            id: viewPanel;
            color: gray (250);
            visible: showViewerPanel;
            Layout.fillWidth: true;
            Layout.fillHeight: true;

            ScrollView {
                frameVisible: false;
                anchors.fill: parent;

                WebView {
                    id: viewer;
                    url: "about:blank";
                    smooth: true;
                    antialiasing: true;
                    experimental {
                        transparentBackground: false;
                        useDefaultContentItemSize: true;
                        preferredMinimumContentsWidth: width;
                        deviceWidth: Screen.width;
                        deviceHeight: Screen.height;
                        preferences {
                            autoLoadImages: true;
                            fullScreenEnabled: false;
                            javascriptEnabled: true;
                            pluginsEnabled: false;
                            offlineWebApplicationCacheEnabled: false;
                            localStorageEnabled: false;
                            xssAuditingEnabled: true;
                            privateBrowsingEnabled: false;
                            dnsPrefetchEnabled: false;
                            navigatorQtObjectEnabled: true;
                            frameFlatteningEnabled: true;
                            developerExtrasEnabled: true;
                            webGLEnabled: true;
                            webAudioEnabled: true;
                            caretBrowsingEnabled: false;
                            notificationsEnabled: false;
                            universalAccessFromFileURLsAllowed: true;
                            fileAccessFromFileURLsAllowed: true;
                        }
                    }
                }
            }
        }
    }
    DialogFile {
        id: dialogOpen;
        currentDirPath: "file:///home/";
        acceptCallback: function () {
            console.log ("currentFilePath=", currentFilePath);
            editor.text = TextFileHelper.read (currentFilePath);
        }
        rejectCallback: function () { }
    }
}

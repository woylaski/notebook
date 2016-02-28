import QtQuick 2.1;
import QtQuick.Window 2.1;

Window {
    id: window;
    title: qsTr ("DocBook5 Qt/QML Editor");
    color: foreground;
    width: 1024;
    height: 600;
    visible: true;
    Component.onDestruction: { console.log ("\n" + exportElement (rootElement)); }

    property AbstractElement currElement : null;
    property BlockElement    rootElement : BlockElement {
        tagName: "page";

        BlockElement {
            uid: "title_1";
            tagName: "section";
            attributes: [
                Attribute { name: "title"; value: "Example of title"; }
            ]

            BlockElement {
                uid: "title_1.1";
                tagName: "section";
                attributes: [
                    Attribute { name: "title"; value: "Example of sub-title"; }
                ]

                BlockElement {
                    tagName: "paragraph";

                    ContentData {
                        content: "This is a paragraph...";
                    }
                    BlockElement {
                        tagName: "list";

                        BlockElement {
                            tagName: "item";
                            attributes: [
                                Attribute { name: "title"; value: "First item"; }
                            ]

                            ContentData {
                                content: "Trying to put data in list item.";
                            }
                        }
                        BlockElement {
                            tagName: "item";
                            attributes: [
                                Attribute { name: "title"; value: "Next item"; }
                            ]
                        }
                        BlockElement {
                            tagName: "item";
                            attributes: [
                                Attribute { name: "title"; value: "Last item"; }
                            ]
                        }
                    }
                    ContentData {
                        content: "This is a paragraph with symboles like < > or & that are entitized...";
                    }
                }
                InlineElement {
                    tagName: "image";
                    attributes: [
                        Attribute { name: "type"; value: "svg"; },
                        Attribute { name: "source"; value: "test/img.url"; }
                    ]
                }
            }
        }
    }

    readonly property int cm : (Screen.pixelDensity * 10);

    readonly property color background : "white";
    readonly property color foreground : "black";
    readonly property color coloration : "steelblue";

    function gray (level) {
        var tmp = (level / 255);
        return Qt.rgba (tmp, tmp, tmp, 1.0);
    }

    function opacify (color, alpha) {
        var tmp = Qt.lighter (color, 1.0);
        tmp.a = alpha;
        return tmp;
    }

    function entitize (text) {
        return text.replace (/&/gi, "&amp;").replace (/</gi, "&lt;").replace (/>/gi, "&gt;").replace (/\n/gi, "<br>");
    }

    function exportElement (element, lvl) {
        var ret = "";
        if (element && "tagName" in element) {
            var idx;
            var depth = (lvl || 0);
            var padding = new Array (depth +1).join ("    ");
            if (element ["tagName"] !== "") {
                ret += padding;
                ret += '<%1'.arg (element ["tagName"]); // OPEN TAG
                if ("uid" in element) { // ID
                    if (element ["uid"] !== "") {
                        ret += ' id="%1"'.arg (entitize (element ["uid"]));
                    }
                }
                if ("attributes" in element) {
                    for (idx = 0; idx < element ["attributes"].length; idx++) {
                        var attr = element ["attributes"][idx];
                        ret += ' %1="%2"'.arg (attr ["name"]).arg (entitize (attr ["value"])); // ATTRIBUTE
                    }
                }
                ret += ">";
                if ("subElements" in element) {
                    ret += "\n";
                    for (idx = 0; idx < element ["subElements"].length; idx++) {
                        var subelement = element ["subElements"][idx];
                        ret += exportElement (subelement, depth +1); // CHILD
                    }
                    ret += padding;
                }
                ret += '</%1>\n'.arg (element ["tagName"]); // CLOSE TAG
            }
            else {
                ret += padding;
                ret += '%1\n'.arg (entitize (element ["content"])); // CDATA
            }
        }
        return ret;
    }

    Component {
        id: compoCDATA;

        ContentData { content: ""; }
    }
    Component {
        id: compoPara;

        BlockElement {
            tagName: "paragraph";

            ContentData { content: ""; }
        }
    }
    Component {
        id: compoImage;

        InlineElement {
            tagName: "image";
            attributes: [
                Attribute { name: "type";   value: ""; },
                Attribute { name: "source"; value: ""; }
            ]
        }
    }
    Component {
        id: compoSection;

        BlockElement {
            tagName: "section";
            attributes: [
                Attribute { name: "title"; value: ""; }
            ]
        }
    }
    Rectangle {
        id: workspace;
        color: background;
        anchors {
            top: toolBar.bottom;
            left: modeBar.right;
            right: sideBar.left;
            bottom: infoBar.top;
        }

        ScrollableArea {
            id: scroller;
            showBorder: false;
            background: "transparent";
            anchors.fill: parent;

            Flickable {
                id: flicker;
                contentWidth: (layout.width + layout.anchors.margins * 2);
                contentHeight: (layout.height + layout.anchors.margins * 2);
                flickableDirection: Flickable.HorizontalAndVerticalFlick;

                Column {
                    id: layout;
                    spacing: (0.25 * cm);
                    anchors {
                        top: parent.top;
                        left: parent.left;
                        margins: (0.5 * cm);
                    }

                    Text {
                        text: qsTr ("Document elements :");
                        font.pixelSize: (0.5 * cm);
                    }
                    Repeater {
                        model: rootElement;
                        delegate: Component {
                            id: compo;

                            Rectangle {
                                id: rect;
                                color: (loader.sourceComponent !== delegateCData
                                        ? (element === currElement ? "lightgray" : "white")
                                        : "transparent");
                                width: (loader.sourceComponent !== delegateCData ? 400 : 364);
                                height: loader.height;
                                border.width: (element === currElement ? 2 : 1);
                                border.color: {
                                    switch (loader.sourceComponent) {
                                    case delegateBlock:  return "darkred";
                                    case delegateInline: return "darkgreen";
                                    case delegateCData:  return "darkblue";
                                    default:             return "darkgray";
                                    }
                                }

                                readonly property AbstractElement element : modelData;

                                MouseArea {
                                    anchors.fill: parent;
                                    onClicked: { currElement = rect.element; }
                                }
                                Loader {
                                    id: loader;
                                    active: sourceComponent;
                                    sourceComponent: {
                                        if (rect.element && "tagName" in rect.element) {
                                            if (rect.element.tagName !== "") {
                                                if ("subElements" in rect.element) {
                                                    return delegateBlock;
                                                }
                                                else {
                                                    return delegateInline;
                                                }
                                            }
                                            else {
                                                return delegateCData;
                                            }
                                        }
                                        else {
                                            return null;
                                        }
                                    }
                                    anchors {
                                        left: parent.left;
                                        right: parent.right;
                                        margins: 4;
                                    }
                                }
                                Component {
                                    id: delegateBlock;

                                    Column {
                                        id: column;
                                        spacing: 4;

                                        readonly property BlockElement block : rect.element;

                                        Row {
                                            spacing: (0.25 * cm);

                                            Text {
                                                text: (list.visible ? "+" : "-");
                                                font.bold: true;
                                                font.pixelSize: (0.4 * cm);

                                                MouseArea {
                                                    anchors.fill: parent;
                                                    anchors.margins: -4;
                                                    onClicked: { list.visible = !list.visible; }
                                                }
                                            }
                                            Text {
                                                text: column.block.tagName + (column.block.uid !== ""
                                                                              ? " (" + column.block.uid + ")"
                                                                              : "");
                                                color: rect.border.color;
                                                font.bold: true;
                                                font.pixelSize: (0.4 * cm);
                                            }
                                        }
                                        Column {
                                            id: list;
                                            x: (0.5 * cm);
                                            spacing: (0.25 * cm);

                                            Repeater {
                                                model: column.block.subElements;
                                                delegate: compo;
                                            }
                                            Item {
                                                width: 1;
                                                height: 1;
                                            }
                                        }
                                    }
                                }
                                Component {
                                    id: delegateInline;

                                    Text {
                                        text: inline.tagName + (inline.uid !== "" ? " (" + inline.uid + ")" : "");
                                        color: rect.border.color;
                                        font.bold: true;
                                        font.pixelSize: (0.4 * cm);

                                        readonly property InlineElement inline : rect.element;
                                    }
                                }
                                Component {
                                    id: delegateCData;

                                    TextEdit {
                                        id: edit;
                                        color: rect.border.color;
                                        font.pixelSize: (0.3 * cm);
                                        wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
                                        onTextChanged: { cdata.content = text; }

                                        readonly property ContentData cdata : rect.element;

                                        Binding on text { value: edit.cdata.content; }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: toolBar;
        color: gray (60);
        height: (1.15 * cm);
        anchors {
            top: parent.top;
            left: parent.left;
            right: parent.right;
        }




    }
    Rectangle {
        id: modeBar;
        color: gray (140);
        width: (1 * cm);
        anchors {
            top: toolBar.bottom;
            left: parent.left;
            bottom: infoBar.top;
        }





    }
    Rectangle {
        id: sideBar;
        color: gray (200);
        width: (6 * cm);
        anchors {
            top: toolBar.bottom;
            right: parent.right;
            bottom: infoBar.top;
        }

        Grid {
            id: grid;
            columns: 1;
            spacing: (0.25 * cm);
            anchors {
                top: parent.top;
                left: parent.left;
                right: parent.right;
                margins: (0.5 * cm);
            }

            Text {
                text: qsTr ("Attributes :");
                font.pixelSize: (0.5 * cm);
                visible: currElement;
            }
            Row {
                spacing: (0.5 * cm);
                visible: currElement;

                Text {
                    text: "xml:id";
                    width:  (1.5 * cm);
                    font.bold: true;
                    font.pixelSize: (0.25 * cm);
                }
                TextInput {
                    width:  (3 * cm);
                    font.pixelSize: (0.25 * cm);
                    onTextChanged: { currElement.uid = text; }

                    Binding on text { value: (currElement ? currElement.uid : ""); }
                    Rectangle {
                        z: -1;
                        border.width: 1;
                        anchors.fill: parent;
                        anchors.margins: -2;
                    }
                }
            }
            Repeater {
                model: (currElement ? currElement.attributes : 0);
                delegate: Row {
                    id: form;
                    spacing: (0.5 * cm);
                    visible: currElement;

                    readonly property Attribute attribute : modelData;

                    Text {
                        text: form.attribute.name;
                        width:  (1.5 * cm);
                        font.bold: true;
                        font.pixelSize: (0.25 * cm);
                    }
                    TextInput {
                        width:  (3 * cm);
                        font.pixelSize: (0.25 * cm);
                        onTextChanged: { form.attribute.value = text; }

                        Binding on text { value: form.attribute.value; }
                        Rectangle {
                            z: -1;
                            border.width: 1;
                            anchors.fill: parent;
                            anchors.margins: -2;
                        }
                    }
                }
            }
            Text {
                text: qsTr ("Add sub-element :");
                visible: (currElement && "addSubElement" in currElement);
                font.pixelSize: (0.5 * cm);
            }
            Row {
                spacing: (0.25 * cm);
                visible: (currElement && "addSubElement" in currElement);

                Repeater {
                    model: [
                        { "title" : "CDATA",     "compo" : compoCDATA   },
                        { "title" : "Paragraph", "compo" : compoPara    },
                        { "title" : "Section",   "compo" : compoSection },
                        { "title" : "Image",     "compo" : compoImage   },
                    ];
                    delegate: Text {
                        text: modelData ["title"];
                        font.underline: true;
                        font.pixelSize: (0.25 * cm);

                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                var compo = (modelData ["compo"] || null);
                                if (compo) {
                                    var object = compo.createObject (window);
                                    if (object) {
                                        currElement ["addSubElement"] (object);
                                        currElement = object;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Text {
                text: qsTr ("Move element :");
                visible: (currElement && "parentElement" in currElement && currElement ["parentElement"]);
                font.pixelSize: (0.5 * cm);
            }
            Row {
                spacing: (0.25 * cm);
                visible: (currElement && "parentElement" in currElement && currElement ["parentElement"]);

                Text {
                    text: qsTr ("Up");
                    visible: (currElement && currElement ["parentElement"]
                              ? currElement.elementIndex > 0
                              : false);
                    font.underline: true;
                    font.pixelSize: (0.25 * cm);

                    MouseArea {
                        anchors.fill: parent;
                        onClicked: { currElement ["parentElement"].moveSubElement (currElement, currElement.elementIndex -1); }
                    }
                }
                Text {
                    text: qsTr ("Down");
                    visible: (currElement && currElement ["parentElement"]
                              ? currElement.elementIndex < currElement ["parentElement"]["subElementsCount"] -1
                              : false);
                    font.underline: true;
                    font.pixelSize: (0.25 * cm);

                    MouseArea {
                        anchors.fill: parent;
                        onClicked: { currElement ["parentElement"].moveSubElement (currElement, currElement.elementIndex +1); }
                    }
                }
            }
        }
    }
    Rectangle {
        id: infoBar;
        color: gray (40);
        height: (0.65 * cm);
        anchors {
            left: parent.left;
            right: parent.right;
            bottom: parent.bottom;
        }




    }
}

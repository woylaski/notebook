import QtQuick 2.0;
import QtQuick.Window 2.0;
import QtQuick.Controls 1.0;
import QtQuick.Layouts 1.0;

Window {
    title: qsTr ("Radix Qonvertor");
    width: 650;
    height: 150;

    property var currentValues : [];

    readonly
    property var digits : [
        '0','1',
        '2','3','4','5','6','7','8','9',
        'A','B','C','D','E','F'
    ];

    ColumnLayout {
        id: layout;
        spacing: 10;
        anchors {
            fill: parent;
            margins: 20;
        }

        Label {
            text: qsTr ("Type space separated values, to live-convert into other radix :");
            color: "gray";
            Layout.fillWidth: true;
        }
        Repeater {
            model: [
                { "legend" : qsTr ("Binary (radix 2) :"),       "base" :  2 },
                { "legend" : qsTr ("Decimal (radix 10) :"),     "base" : 10 },
                { "legend" : qsTr ("Hexadecimal (radix 16) :"), "base" : 16 }
            ];
            delegate: RowLayout {
                id: item;
                spacing: 10;
                Layout.fillWidth: true;

                property int base : model.modelData ["base"];

                Label {
                    id: lbl;
                    text: model.modelData ["legend"];
                    color: "black";
                    Layout.minimumWidth: 200;
                    Layout.maximumWidth: 200;
                }
                TextField {
                    id: txt;
                    textColor: "black";
                    validator: RegExpValidator {
                        regExp: new RegExp ("^[%1\\s]*$".arg (digits.slice (0, item.base).join ('')), "i");
                    }
                    Layout.fillWidth: true;
                    onTextChanged: {
                        if (txt.activeFocus) {
                            var tmp   = [];
                            var list = text.trim ().split (/\s+/gi);
                            for (var idx = 0; idx < list.length; idx++) {
                                var val = parseInt (list [idx], item.base);
                                if (val !== undefined && !isNaN (val)) {
                                    tmp.push (val);
                                }
                            }
                            currentValues = tmp;
                        }
                    }

                    Binding on text {
                        value: {
                            var tmp = [];
                            if (currentValues && Array.isArray (currentValues)) {
                                for (var idx = 0; idx < currentValues.length; idx++) {
                                    tmp.push (currentValues [idx].toString (item.base));
                                }
                            }
                            return tmp.join (' ');
                        }
                        when: !txt.activeFocus;
                    }
                }
            }
        }
    }
}



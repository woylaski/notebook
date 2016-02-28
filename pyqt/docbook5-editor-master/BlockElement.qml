import QtQuick 2.1;

AbstractElement {
    id: base;

    property list<AbstractElement> subElements;

    default property alias content : base.subElements;

    readonly property var subElementsCount : subElements.length;
    readonly property var subElementsArray : {
        var ret = [];
        for (var idx = 0; idx < subElements.length; idx++) {
            subElements [idx]["elementIndex"]  = idx;
            subElements [idx]["parentElement"] = base;
            ret.push (subElements [idx]);
        }
        return ret;
    }

    function addSubElement (element) {
        var tmp = [].concat (subElementsArray);
        tmp.push (element);
        subElements = tmp;
    }

    function moveSubElement (element, idx) {
        var tmp = [].concat (subElementsArray);
        if (element && idx >= 0 && idx < tmp.length) {
            tmp.splice (tmp.indexOf (element), 1);
            tmp.splice (idx, 0, element);
        }
        subElements = tmp;
    }
}

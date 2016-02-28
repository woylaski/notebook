import QtQuick 2.1;

QtObject {
    id: element;

    property string uid     : "";
    property string tagName : "";

    property int elementIndex : -1;

    property QtObject parentElement : null;

    property list<Attribute> attributes;
}

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

SplitView {
    id: root

    Layout.fillWidth: true
    Layout.fillHeight: true

    property string direction: "row" //column
    orientation: direction=="row"?Qt.Horizontal:Qt.Vertical
    property bool separator: false

    function add(item){
        root.addItem(item)
    }

    function remove(item){
         root.removeItem(item)
    }

    /*Rectangle{
        Layout.minimumHeight: 10
        Layout.minimumWidth: 20
        Layout.maximumHeight: 50
        Layout.maximumWidth: 100
        Layout.fillWidth: true
        Layout.fillHeight: true
    }*/

    handleDelegate : Rectangle {
        width: direction=="row"?1:root.width
        height: direction=="row"?root.height:1
        //color: "red"
        color: Qt.darker("lightgray", 1.5)
        //color darker(color baseColor, real factor)
        //Returns a color darker than baseColor by the factor provided
        visible: separator
    }
}

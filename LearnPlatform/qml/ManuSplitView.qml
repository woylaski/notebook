import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import "."

SplitView {
    id: root
    anchors.fill: parent
    property string direction: "row" //column
    orientation: direction=="row"?Qt.Horizontal:Qt.Vertical
    property bool separator: false

    function add(item){
        addItem(item)
    }

    function remove(item){
         removeItem(item)
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
        width: 1
        height: 1
        color: Qt.darker(parent.color, 1.5)
        //color darker(color baseColor, real factor)
        //Returns a color darker than baseColor by the factor provided
        visible: separator
    }

}


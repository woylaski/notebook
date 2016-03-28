import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls

Controls.Tab {
    id: tab

    property string iconName
    property string iconSource: "icon://" + iconName
    property bool canRemove: false
    property int index
    property Item __tabView
    signal closing(var close)

    function close() {
        var event = {accepted: true}
        closing(event)

        if (event.accepted) {
            __tabView.removeTab(index)
        }
    }
}


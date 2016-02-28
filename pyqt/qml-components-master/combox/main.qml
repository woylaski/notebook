import QtQuick 1.1

Rectangle {
    width: 400
    height: 400
    ComboBox_alpha {
        x: 150
        items: ["item1","item2","item3"]
        currentItem: 0
        onCurrentItemChanged: console.log(currentItem)
    }
}

import QtQuick 1.0


Rectangle {

    width: row.width + 10
    height: 60
    color: "#33EEEEEE"

    Row {
        spacing: 50
        id: row
        MenuItem {
            menuText: "End"
        }
        MenuItem {
            menuText: "Hold"
        }
        MenuItem {
            menuText: "Add"
        }
    }

}

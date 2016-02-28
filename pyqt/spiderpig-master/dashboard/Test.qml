import QtQuick 1.0


Rectangle {
    width: 600
    height: 600

    Theme {
        id:  currentTheme
        themeColor: "blue"
        tileWidth: 200
        tileHeight: 10
    }

    Row {
        anchors.centerIn: parent
        width: childrenRect.width
        height: childrenRect.height

        spacing: 10

        TestTile {
            theme: currentTheme
        }

        TestTile {
            theme: currentTheme
        }
    }
}

//Item {
//    property color dashboardBackground: "black"
//    property color themeColor: "#73c330"
//    property color fontColor: "white"

//    property string fontFamily: "Helvetica"
//    property int fontSizeBig: 40
//    property int fontSizeMedium: 18
//    property int fontSizeSmall: 14

//    property int tileWidth: 230
//    property int tileHeight: 120
//}

import QtQuick 1.1

Rectangle {

    property variant theme: Theme {}

    width: theme.tileWidth
    height: theme.tileHeight
    color: theme.themeColor
}

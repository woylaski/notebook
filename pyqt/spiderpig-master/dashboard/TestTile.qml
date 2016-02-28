import QtQuick 1.0

Rectangle {
    property Theme theme: Theme{}

    color: theme.themeColor
    width: theme.tileWidth
    height: theme.tileHeight
}

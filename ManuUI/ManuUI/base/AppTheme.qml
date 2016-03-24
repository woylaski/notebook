import QtQuick 2.5
import "."

QtObject {
    id: appTheme
    property string accentColor
    property string backgroundColor
    property string tabHighlightColor
    property string primaryColor
    property string primaryDarkColor: primaryColor

    onPrimaryColorChanged: Theme.primaryColor = getColor(primaryColor, "500")
    onPrimaryDarkColorChanged: Theme.primaryDarkColor = getColor(primaryDarkColor, "700")
    onAccentColorChanged: Theme.accentColor = getColor(accentColor, "A200")
    onBackgroundColorChanged: Theme.backgroundColor = getColor(backgroundColor, "500")
    onTabHighlightColorChanged: Theme.tabHighlightColor = getColor(tabHighlightColor, "500")

    function getColor(color, shade) {
        if (Palette.colors.hasOwnProperty(color)) {
            return Palette.colors[color][shade]
        } else {
            return color
        }
    }
}


import QtQuick 2.5

pragma Singleton

//http://www.google.com/design/spec/style/color.html#color-color-palette
Object {
    id: theme
    //首先色
    property color primaryColor: "#FAFAFA"
    //深色
    property color primaryDarkColor: Qt.rgba(0,0,0, 0.54)
    //重点色
    property color accentColor: "#2196F3"
    //背景色
    property color backgroundColor: "#f3f3f3"
    //高亮色
    property color tabHighlightColor: accentColor

    property ThemePalette light: ThemePalette {
        light: true
    }

    property ThemePalette dark: ThemePalette {
        light: false
    }

    function alpha(color, alpha) {
        // Make sure we have a real color object to work with (versus a string like "#ccc")
        var realColor = Qt.darker(color, 1)

        realColor.a = alpha

        return realColor
    }

    function lightDark(background, lightColor, darkColor) {
        return isDarkColor(background) ? darkColor : lightColor
    }

    function isDarkColor(background) {
        var temp = Qt.darker(background, 1)

        var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);

        return temp.a > 0 && a >= 0.3
    }

    // TODO: Load all the fonts!
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-BlackItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Black.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Bold.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-BoldItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Bold.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-BoldItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Medium.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-MediumItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Italic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Light.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-LightItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Regular.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Italic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Light.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-LightItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-Thin.ttf")}
    FontLoader {source: Qt.resolvedUrl("fonts/roboto/Roboto-ThinItalic.ttf")}
}


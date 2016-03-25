import QtQuick 2.5

pragma Singleton

//rgba, a就是透明通道,是alpha,0是全透明,1是不透明
//alpha通道一般用作不透明度参数。
//如果一个像素的alpha通道数值为0%，那它就是完全透明的（也就是看不见的），
//而数值为100%则意味着一个完全不透明的像素（传统的数字图像）。
//在0%和100%之间的值则使得像素可以透过背景显示出来，就像透过玻璃（半透明性）
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

        //这是Qt里面的颜色设置函数,用于返回比该颜色深的函数,
        //当然深度可以自己设计,如果深度设为1,返回比这个的颜色本来的颜色,
        //如果深度设为3,则返回该颜色的暗度为原来的1/3.
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
    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-BlackItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-BlackItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Black.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Black.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Bold.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Bold.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-BoldItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-BoldItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Bold.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-Bold.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-BoldItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-BoldItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Medium.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Medium.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-MediumItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-MediumItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Regular.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Italic.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-Italic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Light.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-Light.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-LightItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-LightItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/RobotoCondensed-Regular.ttf")
        source: "qrc:/fonts/fonts/roboto/RobotoCondensed-Regular.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Italic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Italic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Light.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Light.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-LightItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-LightItalic.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-Thin.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-Thin.ttf"
    }

    FontLoader {
        //source: Qt.resolvedUrl("fonts/roboto/Roboto-ThinItalic.ttf")
        source: "qrc:/fonts/fonts/roboto/Roboto-ThinItalic.ttf"
    }
}


import QtQuick 2.5
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "qrc:/base/base" as Base

Item {
    id: icon
    property color color: Base.Theme.light.iconColor
    property real size: Base.Units.dp(24)

    //icon name to display
    property string name

    property string source: "icon://" + name

    property bool valid: source.indexOf("icon://awesome/") == 0
            ? awesomeIcon.valid : image.status == Image.Ready

    property url iconDirectory: Qt.resolvedUrl("icons")

    width: size
    height: size

    //着色
    //设置源 Item 的 HSL 颜色空间
    property bool colorize: icon.source.indexOf("icon://") === 0 || icon.source.indexOf(".color.") === -1

    Image {
        id: image

        anchors.fill: parent
        visible: source != "" && !colorize

        source: {
            if (icon.source.indexOf("icon://") == 0) {
                //substring() 方法用于提取字符串中介于两个指定下标之间的字符。
                //stringObject.substring(start,stop)
                var name = icon.source.substring(7)
                print(name)
                var list = name.split("/");

                if (name == "" || list[0] === "awesome")
                    return "";
                return "qrc:/icons/icons/%1/%2.svg".arg(list[0]).arg(list[1]);
                //return Qt.resolvedUrl("icons/%1/%2.svg".arg(list[0]).arg(list[1]));
            } else {
                return icon.source
            }
        }

        sourceSize {
            width: size * Screen.devicePixelRatio
            height: size * Screen.devicePixelRatio
        }
    }

    //在源 Item 上覆盖一层颜色
    ColorOverlay {
        id: overlay

        anchors.fill: parent
        source: image
        color: Base.Theme.alpha(icon.color, 1)
        cached: true
        visible: image.source != "" && colorize
        opacity: icon.color.a
    }

    AwesomeIcon {
        id: awesomeIcon

        anchors.centerIn: parent
        size: icon.size * 0.9
        visible: name != ""
        color: icon.color

        name: {
            if (icon.source.indexOf("icon://") == 0) {
                var name = icon.source.substring(7)
                var list = name.split("/")

                if (list[0] === "awesome") {
                    return list[1]
                }
            }

            return ""
        }
    }
}


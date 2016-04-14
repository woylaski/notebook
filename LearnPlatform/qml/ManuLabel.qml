import QtQuick 2.0
import "."

Text {
    //--------------------------------------------------------------------------
    // Custom properties
    //--------------------------------------------------------------------------

    property bool centered: false
    property string fontSize: "small"

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    smooth: true
    color: "#222"
    opacity: enabled ? 1 : 0.5

    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter

    //font.family: Fo.font
    textFormat: Text.PlainText
    linkColor: Qt.darker ("#ccc", 1.2)
    font.pixelSize: Size.getSize (fontSize)
    onLinkActivated: Qt.openUrlExternally (link)
    anchors.horizontalCenter: centered ? parent.horizontalCenter : undefined

    //--------------------------------------------------------------------------
    // Behaviors
    //--------------------------------------------------------------------------

    Behavior on color { ColorAnimation{} }
    Behavior on opacity { NumberAnimation{} }

}


import QtQuick 1.1

Rectangle {
    id: sliderbar

    property int __value: colorbar.width*100/maxWidth
    property int defaultValue: 0
    property int maxWidth: width-pullblock.width

    signal valueChanged(int newValue)

    border.width: 1;
    width: 210; height: 30

    //clip: true

    Rectangle {
        id: pullblock

        width: 10; height: sliderbar.height
        border.width: 1;
        x: maxWidth*defaultValue/100

        MouseArea {
            anchors.fill: parent
            drag {
                target: pullblock
                axis: Drag.XAxis
                minimumX: 0;
                maximumX: maxWidth;
            }
            onReleased: valueChanged(__value)
        }
    }

    Rectangle {
        id: colorbar

        anchors {
            left: sliderbar.left; right: pullblock.left
            top:  sliderbar.top; bottom: sliderbar.bottom
        }

        color: "#5bacc4"
    }

    Text {
        id: label

        anchors.right: colorbar.right
        horizontalAlignment: Text.AlignRight
        text: __value+'%'

    }

}


import QtQuick 2.5

//grid自动排版排列
Grid {
    id: grid

    default property alias delegate: repeater.delegate
    property real cellWidth
    property real cellHeight
    property alias model: repeater.model
    property real widthOverride: parent.width
    property real heightOverride: parent.height
    property real minColumnSpacing

    columns: {
        var flooredResult = Math.floor(widthOverride/cellWidth);
        if (flooredResult >= 1 && flooredResult <= repeater.count)
            if ((widthOverride-(flooredResult*cellWidth))/(flooredResult+1) < minColumnSpacing)
                return flooredResult-1;
            else
                return flooredResult;
        else if (flooredResult > repeater.count)
            return repeater.count;
        else
            return 1;
    }

    columnSpacing: (widthOverride-(columns*cellWidth))/(columns+1) < (minColumnSpacing/2) ? (minColumnSpacing/2) : (widthOverride-(columns*cellWidth))/(columns+1)
    width: widthOverride - 2*columnSpacing
    anchors{
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: rowSpacing
    }

    Repeater {
        id: repeater
    }
}


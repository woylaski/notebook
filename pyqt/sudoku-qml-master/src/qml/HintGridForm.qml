import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    id: hintGrid

    width: childrenRect.width
    height: childrenRect.height

    color: "Transparent"

    property alias hints: grid.children

    Grid {
        id: grid

        columns: 3
        rows: 3

        Repeater {
            model: 9

            Hint {
                digit: index + 1
            }
        }
    }
}

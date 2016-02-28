
import QtQuick 2.2
import "../components"

Rectangle {
    width: 800
    height: 600
    color: "white"

    ProgrammedLoader {
        source: "items/rect.qml"; x: 200
        begin_at: new Date(2015, 11, 30, 12, 00)
        end_at: new Date(2015, 11, 30, 12, 05)
    }
}


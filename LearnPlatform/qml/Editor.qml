import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "js/ObjUtils.js" as ObjUtils
import "."

Window {
    id: root
    width: 300
    height: 200
    visible: true
    color: "gray"

    ManuColumnContainer{
        spacing: 20
        color: "lightgreen"
        anchors.fill: parent

        ManuRowContainer{
            spacing: 10
            //height:60
            width: 100; height:60
            Text{text:"x:"}
            ManuTextFiled{placeholderText:"input x"}
        }

        ManuRowContainer{
            spacing: 10
            //height:60
            width: 100; height:60
            Text{text:"y:"}
            ManuTextFiled{placeholderText:"input y"}
        }
    }
}



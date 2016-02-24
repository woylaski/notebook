import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Window {
    width: 480;
    height: 320;
    title: "SplitView";

    SplitView{
        anchors.fill:parent;
        orientation: Qt.Horizontal;
        Rectangle{
            id:rect1;
            width:100;
            color:"red";
        }
        Rectangle{
            id:rect2;
            Layout.fillWidth: true;
            Layout.minimumWidth: 50;
            color:"blue";
        }
        Rectangle{
            id:rect3;
            width:100;
            color:"green";
        }
    }
}
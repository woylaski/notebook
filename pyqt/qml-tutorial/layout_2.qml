import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

Window {
    id:gridLayoutWindow;
    title:"GridLayoutWindow";
    width: 480;
    height: 320;

    GridLayout{
        id: gridLayout1
        columns: 2;
        rows:2;
        anchors.fill: parent;
        anchors.margins: 5;
        columnSpacing: 0;
        rowSpacing: 0;

        Rectangle{
            id:rect00;
            color: "red";
            Layout.fillWidth: true;
            Layout.fillHeight: true;
        }

        Rectangle{
            id:rect01;
            color: "blue";
            Layout.fillWidth: true;
            Layout.fillHeight: true;
        }

        Rectangle{
            id:rect10;
            color: "green";
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.row:1;
            Layout.column: 1;
        }

    }
}
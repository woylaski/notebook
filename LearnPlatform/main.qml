import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "qml"

ApplicationWindow {
    id: application
    visible: true
    width: 800
    height: 600
    title: qsTr("Learn-Work-Create-") + Qt.application.version

    //主窗口
    SplitView {
        id: mainWindow
        anchors.fill: parent
        orientation: Qt.Vertical

        //工作区
        Rectangle{
            id: workWindow
            Layout.fillHeight: true
            SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal
                //菜单区域
                Rectangle{
                    id: leftMenu
                    Layout.minimumWidth: 100
                    Layout.maximumWidth: 300
                    border.color: "black"

                    SlideMenuColumn{}
                }

                //文档显示区域
                Rectangle{
                    id: documentArea
                    Layout.minimumWidth: 50
                    Layout.fillWidth: true
                    color: ColorVar.primary
                    border.color: "black"
                }
            }
        }

        //输出区域
        Rectangle{
            id: consoleWindow
            Layout.minimumHeight: 100
            Layout.maximumHeight: 400
            border.color: "black"
        }
    }

    //状态区域
    statusBar: Rectangle{
        id: stateArea
        color: "lightgray"
        height: 20
        width: parent.width
        property alias text: status.text;
        Text {
            id: status;
            anchors.fill: parent;
            anchors.margins: 4;
            font.pointSize: 12;
        }
    }
}


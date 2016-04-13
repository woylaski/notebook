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

    /*toolBar: ManuTopNavBar{
        anchors.left: parent.left
        anchors.right: parent.right
        searchBarVisible: true
    }*/

    toolBar: ManuToolBar{
        anchors.left: parent.left
        anchors.right: parent.right

        iconList: [
            {"name":"fa_align_justify", "action":"ColorList.qml"},
            {"name":"fa_book", "action":"IconList.qml"},
            {"name":"fa_bookmark", "action":"Configure.qml"},
            {"name":"fa_building", "action":"WebBrowser.qml"},
            {"name":"fa_building", "action":"ManuScreenPicker.qml"},
            {"name":"fa_building", "action":"SimplePrez.qml"}
        ]
    }

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
                    Layout.minimumWidth: 150
                    Layout.maximumWidth: 300
                    border.color: "black"

                    SlideMenuColumn{}
                }

                //文档显示区域
                Rectangle{
                    id: documentArea
                    Layout.minimumWidth: 50
                    Layout.fillWidth: true
                    color: "darkgray"
                    border.color: ColorVar.primary
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
    statusBar: ManuBottomBar{
        id: stateArea
    }

    Component.onCompleted: {
        print("os ", Global.os)
        print("workDir ", Global.workDir)
    }
}


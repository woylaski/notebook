import QtQuick 2.5
import QtQml 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import ProjectManager 1.1
import "qml"

ManuApplication{
    id: appWindow
    visible: true
    width: 800
    height: 600
    title: qsTr("Learn-Work-Create-") + Qt.application.version

    //toolbar
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

                    StackView {
                        id: stackView
                        objectName: "docAreaStackView"
                        anchors.fill: parent
                        initialItem: ManuMainMenuScreen { }
                        enabled: true
                        //enabled: !dialog.visible
                    }

                    /*ManuDialogLoader {
                        id: dialog
                        anchors.fill: parent
                    }*/
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

    onLoaded: {
        // http://doc.qt.io/qt-5/qml-qtquick-window-screen.html
        // The Screen attached object is valid inside Item or Item derived types, after component completion
        settings.pixelDensity = settings.debugMode ? 6.0 : Screen.logicalPixelDensity

        var previousVersion = parseInt(settings.previousVersion.split(".").join(""))
        if (previousVersion === 0)
        { // first run
            ProjectManager.restoreExamples()
            settings.previousVersion = Qt.application.version
        }
        else
        {
            var currentVersion = parseInt(Qt.application.version.split(".").join(""))
            if (currentVersion > previousVersion)
            {
                var parameters = {
                    title: qsTr("New examples"),
                    text: qsTr("We detected that you had recently updated QML Creator on your device.") + "\n" +
                          qsTr("We are constantly working on QML Creator improvement, and we may have added some new sample projects in the current release.") + "\n" +
                          qsTr("Press OK if you would like to get them now (notice that all the changes you have made in the Examples section will be removed)") + "\n" +
                          qsTr("Alternatively, you can do it later by pressing the Restore examples button in the Examples screen.")
                }

                var callback = function(value)
                {
                    if (value)
                        ProjectManager.restoreExamples()

                    settings.previousVersion = Qt.application.version
                }

                dialog.open(dialog.types.confirmation, parameters, callback)
            }
        }

        print("---dialog load end---")
        print("dialog visible ", dialog.visible)
    }

    onBackPressed: {
        if (dialog.visible)
        {
            dialog.close()
        }
        else
        {
            if (stackView.depth > 1)
                stackView.pop()
            else
                Qt.quit()
        }
    }

    Component.onCompleted: {
        print("os ", Global.os)
        print("workDir ", Global.workDir)
        //loaded()
    }

    Component.onDestruction: {
        //settings.input = myTextField.text
    }
}


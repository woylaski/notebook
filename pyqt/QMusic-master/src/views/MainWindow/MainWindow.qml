import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
import QtMultimedia 5.0
import DMusic 1.0
import "../DMusicWidgets"
import "../MusicManagerPage"
import "../PlaylistManagerPage"
import "../SettingPage"
import "../SearchPage"


Rectangle {

    id: mainWindow
    property var constants
    property var views: ['MusicManagerPage', 'PlayListPage', 'SettingPage', 'SearchPage']
    property var bgImage: bgImage
    property var titleBar: titleBar
    property var playBottomBar: playBottomBar
    property var mainWindowController: mainWindowController

    color: "white"
    focus: true
    radius: 10

    BorderImage {
        id: bgImage
        objectName: 'bgImage'

        anchors.fill: mainWindow
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
    }


    FastBlur {
        anchors.fill: bgImage
        source: bgImage
        // deviation: 4
        radius: 64
        // samples: 16
    }

    Column{
        anchors.fill: parent
        Row{
            LeftSideBar {
                id: leftSideBar
                objectName: 'leftSideBar'
                width: 56
                height: mainWindow.height - playBottomBar.height
                iconWidth: 56
                iconHeight: 56
                color: "white"
            }

            Rectangle {
                width: 1
                height: mainWindow.height - playBottomBar.height
                color: "lightgray"
            }

            Column{

                TitleBar {
                    id: titleBar
                    objectName: 'mainTitleBar'

                    width: mainWindow.width - leftSideBar.width - 1
                    height: 25
                    iconWidth: titleBar.height
                    iconHeight: titleBar.height
                    color: "white"
                    windowFlag: true
                }

                DStackView {

                    id: stackViews
                    objectName: 'stackViews'
                    width: mainWindow.width - leftSideBar.width
                    height: mainWindow.height - titleBar.height - playBottomBar.height
                    currentIndex: 0

                    MusicManagerPage {
                        id: musicManagerPage
                        objectName: 'musicManagerPage'
                        anchors.fill: parent
                    }

                    PlaylistPage {
                        id: palylistPage
                        objectName: 'palylistPage'
                        anchors.fill: parent
                    }

                    SettingPage {
                        id: settingPage
                        property var name: '9999'
                        objectName: 'settingPage'
                        anchors.fill: parent
                    }

                    SearchPage {
                        id: searchPage
                        objectName: 'searchPage'
                        anchors.fill: parent
                    }
                }
            }
        }

        PlayBottomBar {
            id: playBottomBar
            width: mainWindow.width
            height: 90

            color: "#282F3F"
        }
    }

    SearchInputBox {
        id: searchInputBox
        x: leftSideBar.width + 1
        y: playBottomBar.y - 30
        height: 30
        width: stackViews.width
    }
   

    MainWindowController{
        id: mainWindowController
        mainWindow: mainWindow
        stackViews: stackViews
        bgImage: bgImage
        titleBar: titleBar
        leftSideBar: leftSideBar
        searchPage: searchPage
        searchInputBox: searchInputBox
        playBottomBar: playBottomBar
    }
}

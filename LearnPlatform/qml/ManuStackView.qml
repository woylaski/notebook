import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import "js/ObjUtils.js" as ObjUtils
import "."

Window {
    id: root

    title: qsTr("StackView")
    minimumWidth: 640
    minimumHeight: 480
    visible: true

    property alias pages: pageStack

    function initPage(page){
        pageStack.initialItem=page
        //initialItem: Qt.resolvedUrl("MyItem.qml")
        //initialItem: myItem
        //initialItem: {"item" : Qt.resolvedUrl("MyRectangle.qml"), "properties" : {"color" : "red"}}
    }

    function pushPage(page){
        pageStack.push(page)
        //pageStack.push("qrc:/SettingsPage.qml")
        //pageStack.push({item: "qrc:/TimerPage.qml",
        //                properties:{"groups":g, "timeStringText":timeString}})
    }

    function popPage(){
        pageStack.pop()
    }

    function clearPage(){
        pageStack.clear()
    }

    StackView {
        id: pageStack
        anchors.fill: parent
        //initialItem: WelcomePage {id: welcomePage}
    }
}


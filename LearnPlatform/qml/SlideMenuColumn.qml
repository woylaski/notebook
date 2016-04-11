import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import "."
import "js/Promise.js" as Promise
import "js/LocalFile.js" as LocalFile

Item {
    id: menu
    anchors.fill: parent

    property var jsondata: {}
    //property string source
    property string source: "menu.json"

    function loadMenuFile(fname){
        if(!fname){print("config file not specified");return ;}
        print("try to read file:"+fname)

        //var promise = HttpUtils.get(fname)
        var promise = LocalFile.readFile(fname)
        promise.then( function(data) {
            print("----ok----")
            setMenuData(data)
            //filecontent.text = data;
        });

        promise.error( function(data) {
            print("----error----")
            //filecontent.text = "read file error:" + data;
        });
    }

    function setMenuData(data){
        print("menu data: ", data)
    }

    function menuFileSelect(){
        print("menu folder clicked");
        fileDialog.open()
    }

    function menuItemPlus(){

    }

    function menuItemMinus(){

    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            //Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            //Qt.quit()
        }
        //Component.onCompleted: visible = true
    }

    //在column的内部元素中指定anchors top bottom等垂直方向设置是没有意义的
    //因为column是从垂直方向上按照height自动排的
    Column{
        //anchors.fill: parent
        anchors {
            top: parent.top;
            left: parent.left;
            right: parent.right;
            bottom: parent.bottom;
            margins: 2;
        }
        width: parent.width
        height: parent.height

        Rectangle{
            id: toolBar
            width: parent.width
            height: 40
            color: "darkgray"

            anchors{
                left: parent.left
                //top: parent.top
            }

            ManuIconNavBar{
                width: parent.width
                anchors.fill: parent

                Row {
                    id: iconButtonRow
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    ManuFontIconButton{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        fontFamily: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons["fa_folder"]

                        onClicked: {
                            menuFileSelect()
                            //print("menu folder clicked");
                        }
                    }

                    ManuFontIconButton{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        fontFamily: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons["fa_plus"]

                        onClicked: {
                            menuItemPlus()
                            //print("menu plus clicked");
                        }
                    }

                    ManuFontIconButton{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        fontFamily: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons["fa_minus"]

                        onClicked: {
                            menuItemMinus()
                            //print("menu minus clicked");
                        }
                    }
                }
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height-toolBar.height
            anchors{
                left: parent.left
                //top: toolBar.bottom
            }

            Column {
                id: menuList
                spacing: 2

                Repeater {
                    id: menuView
                    model: jsondata
                    Rectangle {
                        width: menu.width
                        height: 20
                        radius: 3
                        color: "lightBlue"
                        Text {
                            anchors.centerIn: parent
                            //text: index
                        }
                    }
                }
            }
        }
    }
    onSourceChanged: {
        loadMenuFile(source)
    }

    Component.onCompleted: {
        if(source){
            print("menu source file is ", source)
            loadMenuFile(source)
        }else{
            print("no menu source file specified ")
        }
    }
}


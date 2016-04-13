import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import "."
import "js/Promise.js" as Promise
import "js/LocalFile.js" as LocalFile

Item {
    id: menu
    anchors.fill: parent

    property var menuData: []
    property url source

    function loadMenuFile(fname){
        if(!fname){print("config file not specified");return ;}
        print("try to read file:"+fname)

        var promise = LocalFile.readFile(fname)
        promise.then( function(data) {
            print("----load file ok----")
            setMenuData(data)
        });

        promise.error( function(data) {
            print("----error----")
        });
    }

    function setMenuData(data){
        if(!data) return;

        print("menu data: ", data)
        var jsondata=JSON.parse(data)
        //print("jsondata len:", jsondata.length)
        for (var i in jsondata) {
            print("key: ",i, ", value:", jsondata[i])
        }

        //var menuData = new Array (0)
        menuData.length=0

        for(i=0;i<jsondata["topmenu"].length;i++){
            //print(jsondata["topmenu"][i])
            print(jsondata["topmenu"][i]["menu"])
            menuData.push(jsondata["topmenu"][i])
            //menuData.push(jsondata["topmenu"][i]["menu"])
        }

        menuList.dataModel=menuData
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
        folder: Global.workDir
        //folder: shortcuts.home
        //nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
        nameFilters: [ "Json files (*.json)", "All files (*)" ]
        //selectedNameFilter: "All files (*)"
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)

            //for (var i = 0; i < fileUrls.length; ++i)
            //    Qt.openUrlExternally(fileUrls[i])

            menu.source=fileDialog.fileUrls[0]
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
        anchors.fill: parent
        spacing: 2

        Item{
            id: toolBar
            width: parent.width
            height: 40

            anchors{
                left: parent.left
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
                        }
                    }

                    ManuFontIconButton{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        fontFamily: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons["fa_plus"]

                        onClicked: {
                            menuItemPlus()
                        }
                    }

                    ManuFontIconButton{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        fontFamily: FontIconVar.fontAwesome.name
                        text: FontIconVar.faIcons["fa_minus"]

                        onClicked: {
                            menuItemMinus()
                        }
                    }
                }
            }
        }

        //ScrollView
        ScrollView {
            width: parent.width
            height: parent.height-toolBar.height
            anchors{left: parent.left}

            ManuColumnRepeater{
                id: menuList
                width: toolBar.width
                key: "desc"
                subMenuKey: "submenu"
                anchors{margins: 10}
            }
        }
    }

    onSourceChanged: {
        loadMenuFile(source)
    }

    Component.onCompleted: {
        if(source!=undefined && source!=""){
            print("menu source file is ", source)
            loadMenuFile(source)
        }else{
            print("no menu source file specified ")
        }
    }
}


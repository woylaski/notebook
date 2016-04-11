import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import "."
import "js/Promise.js" as Promise
import "js/LocalFile.js" as LocalFile

Item {
    id: menu
    anchors.fill: parent

    property var menuData: ["netdev","novel","social"]
    //property string source
    property url source: "menu.json"

    function loadMenuFile(fname){
        if(!fname){print("config file not specified");return ;}
        print("try to read file:"+fname)

        //var promise = HttpUtils.get(fname)
        var promise = LocalFile.readFile(fname)
        promise.then( function(data) {
            print("----load file ok----")
            //print(data)
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
        if(!data) return;

        var ary = new Array (0)
        var jsondata=JSON.parse(data)
        print("jsondata len:", jsondata.length)
        for (var i in jsondata) {
            print("key: ",i, ", value:", jsondata[i])
        }

        //reload menuData
        //menuData.clear()
        //menuData=[]
        menuData.length=0
        menuView.model=[]

        for(i=0;i<jsondata["topmenu"].length;i++){
            print(jsondata["topmenu"][i])
            print(jsondata["topmenu"][i]["menu"])
            //menuData.append(jsondata["topmenu"][i])
            menuData.push(jsondata["topmenu"][i]["menu"])
        }
        //menuData = jsondata["topmenu"]
        menuView.model=menu.menuData
        print("new menuData ",menu.menuData)
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
                    model: menu.menuData
                    Rectangle {
                        width: menu.width
                        height: 20
                        radius: 3
                        color: "lightBlue"
                        Text {
                            anchors.centerIn: parent
                            text: modelData
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


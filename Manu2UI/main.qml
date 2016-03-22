import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtWebKit 3.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile
import "qrc:/base/base" as Base
import "qrc:/components/components" as Components

Components.AppWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    /*
    Label {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    */

    ListModel {
        id: colorModel
        /*
        ListElement {
            acolor: "#1abc9c"
            //acolor: Base.Defines.colorTurquoise
        }
        ListElement {
            acolor: "#16a085"
            //acolor: Base.Defines.colorTurquoise
        }
        */
        Component.onCompleted: {
            colorModel.append({"acolor": Base.Defines.colorTurquoise})
            colorModel.append({"acolor": Base.Defines.colorGreenSea})
            colorModel.append({"acolor": Base.Defines.colorEmerald})
            colorModel.append({"acolor": Base.Defines.colorNephritis})
            colorModel.append({"acolor": Base.Defines.colorPeterRiver})
            colorModel.append({"acolor": Base.Defines.colorBelizeHole})
            colorModel.append({"acolor": Base.Defines.colorAmethyst})
            colorModel.append({"acolor": Base.Defines.colorWisteria})
            colorModel.append({"acolor": Base.Defines.colorWetAsphalt})
            colorModel.append({"acolor": Base.Defines.colorMidnightBlue})
            colorModel.append({"acolor": Base.Defines.colorSunFlower})
            colorModel.append({"acolor": Base.Defines.colorOrange})
            colorModel.append({"acolor": Base.Defines.colorCarrot})
            colorModel.append({"acolor": Base.Defines.colorPumpkin})
            colorModel.append({"acolor": Base.Defines.colorAlizarin})
            colorModel.append({"acolor": Base.Defines.colorPomegranate})
            colorModel.append({"acolor": Base.Defines.colorClouds})
            colorModel.append({"acolor": Base.Defines.colorSilver})
            colorModel.append({"acolor": Base.Defines.colorConcrete})
            colorModel.append({"acolor": Base.Defines.colorAsbestos})
        }
    }

    Component {
        id: colorDelegate
        Rectangle{
            width: root.width
            height: root.height/colorModel.count
            radius: Base.Defines.radius
            color: acolor
        }
    }

    /*
    ListView{
        id: colorlist
        anchors.fill: parent
        model: colorModel
        delegate: colorDelegate
    }
    */

    function readFile(fname){
        print("try to read file:"+fname)
        //var promise = HttpUtils.get(fname)
        var promise = LocalFile.readFile(fname)
        promise.then( function(data) {
            print("----ok----")
            filecontent.text = data;
        });

        promise.error( function(data) {
            print("----error----")
            filecontent.text = "read file error:" + data;
        });
    }

    function writeFile(fname, content){
        print("try to write file:"+fname)
        //var promise = HttpUtils.get(fname)
        var promise = LocalFile.writeFile(fname, content)
        promise.then( function(data) {
            print("----ok----")
            //filecontent.text = data;
        });

        promise.error( function(data) {
            print("----error----")
            //filecontent.text = "read file error:" + data;
        });
    }

    Item{
        anchors.fill: parent

        Text{
            id: filecontent
            anchors.centerIn: parent
            text: "hello world"
        }

        Button{
            anchors.bottom: parent.bottom
            text: "click"
            property int count:0
            onClicked: {
                if(count%2==0){
                    //readFile("https://www.baidu.com")
                    //readFile("qrc:/hello.txt")
                    //readFile("qrc:///hello.txt")
                    readFile("file:///E:/hello.txt")
                }else{
                    writeFile("file:///E:/hello.txt", count.toString())
                }

                count++;
                print(count)
            }
        }
    }

    Component.onCompleted: {
        print("list AppWindow all info")
        //ObjUtils.listProperty(root)
        print(ObjUtils.haveProperty(root, "menuBarChanged"))
        print(ObjUtils.haveProperty(root, "aaaa"))
        print(ObjUtils.fuzzyProperty(root, "size"))

        //Base.Device.initDeviceSize(Screen.width, Screen.height,Screen.pixelDensity)
        print(Base.Device.printDeviceInfo())

        print(Base.Defines.colorTurquoise)

        MiscUtils.bfun()

        Promise.testJoinedPromise()
    }
}


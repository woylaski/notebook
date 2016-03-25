import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
//import QtWebKit 3.0
import QtQml.Models 2.2
import QtQuick.Dialogs 1.2

import com.manu.fileio 1.0
import com.manu.treemodel 1.0

import "qrc:/base/base/ObjUtils.js" as ObjUtils
import "qrc:/base/base/MiscUtils.js" as MiscUtils
import "qrc:/base/base/HttpUtils.js" as HttpUtils
import "qrc:/base/base/Promise.js" as Promise
import "qrc:/base/base/LocalFile.js" as LocalFile

/*
import "base/"
*/
import "qrc:/base/base" as Base
import "qrc:/elements/elements" as Elements
import "qrc:/components/components" as Components

Components.AppWindow {
//ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Base.AppTheme{
        id: apptheme
        primaryColor: "red"
        primaryDarkColor: "blue"
    }

    Item{
        id: viewarea
        width: parent.width
        height: parent.height-buttonarea.height
        anchors.top: parent.top
        //Text{
        //    text: "hello world"
        //}

        Column{
            Row{
                spacing: 20

                Rectangle{
                    width: 50
                    height: 50
                    border.color: "black"
                    border.width: 2
                    color: Base.Theme.primaryColor
                }

                Rectangle{
                    width: 50
                    height: 50
                    border.width: 2
                    border.color: "black"
                    color: Base.Theme.accentColor
                }

                Rectangle{
                    width: 50
                    height: 50
                    border.width: 2
                    border.color: "black"
                    color: Base.Theme.primaryDarkColor
                }

                Rectangle{
                    width: 50
                    height: 50
                    border.width: 2
                    border.color: "black"
                    color: Base.Theme.backgroundColor
                }

                Rectangle{
                    width: 50
                    height: 50
                    border.width: 2
                    border.color: "black"
                    color: Base.Theme.tabHighlightColor
                }
            }

            Row{
                spacing: 20
                Elements.AwesomeIcon{
                    name: "android"
                }

                Elements.AwesomeIcon{
                    name: "amazon"
                }

                Elements.AwesomeIcon{
                    name: "apple"
                }

                Elements.CheckBox {
                    checked: true
                    text: "On"
                    darkBackground: true
                }
            }

            Row{
                spacing: 20
                Elements.Label{
                    style: "button"
                    text: "This is A Label"
                }

                //Elements.View{
                //    border: 2
                //}
            }
        }
    }

    Elements.Divider{
        //anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: buttonarea.top
    }

    //Elements.ThinDivider{
    //    anchors.bottom: buttonarea.top
    //}

    Item{
        id: buttonarea
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom

        Row{
            Button{
                text: "btn1"
                onClicked: {
                    print("button 1 clicked")
                    text="button1"
                }
            }

            Button{
                text: "btn2"
                onClicked: {
                    print("button 2 clicked")
                    text="button2"
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("app complete")
        print(Base.Theme.accentColor)
    }
}


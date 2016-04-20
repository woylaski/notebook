import QtQuick 2.5
import QtQuick.Controls 1.4

import "."

Rectangle {
    id: root
    width: parent.width
    height: 40
    radius: 6
    color: ColorVar.colorVars["wetAsphalt"]
    //color: "lightgray"

    property alias iconList: iconLayout.model

    Row{
        anchors.fill: parent
        spacing: 5
        Repeater{
            id: iconLayout
            delegate: iconView
        }
    }

    Component{
        id: iconView

        ManuFontIconButton{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            fontFamily: FontIconVar.fontAwesome.name
            text: FontIconVar.faIcons[modelData.name]
            color: ColorVar.colorVars["wetAsphalt"]

            onClicked: {
                print("nav ",modelData.name," clicked")
                //var afunc=modelData.action
                //var editPage = Qt.createComponent("EditPage.qml").createObject(mainPage);
                //myEditPage.destroy()
                var component = Qt.createComponent(modelData.action)
                if (component.status == Component.Ready){
                    print("create componet ok ", modelData.action);
                    var obj=component.createObject(appWindow, {"x": 100, "y": 100});
                    obj.show()
                }
                else if(component.status == Component.Error){
                    print("create componet error ", modelData.action);
                }

            }
        }
    }
}

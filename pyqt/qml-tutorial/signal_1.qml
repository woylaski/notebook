import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

TextInput{
    id: txt
    width:300; height:200

    property string myname: "zhangbiaoyi"
    color: "lightgreen"

    text: "hellow world"

    onTextChanged: {
        console.log("text changed to: ", text)
    }

    onMynameChanged:{
        console.log("myname changed to :", myname)
    }

    MouseArea{
        id: btn
        anchors.fill: parent
        onClicked:{
            myname="jiayuan"
        }
    }
}
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow{
    visible:true
    width:640
    height:480
    id:window
    title:asTr("editor")

    signal show(string text)



    TextArea{
        text:"hello"
        onTextChanged:show(text);
    }

}
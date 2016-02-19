
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

ListModel {
    id: dataBank

    ListElement {
         value: "http://www.wondericons.com/dogs/myspace_dogs_icons_02.gif"
         type: "image"
    }
    
    ListElement {
         value: "Dummy text 1"
         type: "text"
    }
    
    ListElement {
         value: "http://www.wondericons.com/dogs/myspace_dogs_icons_08.gif"
         type: "image"
    }
    
    ListElement {
         value: "Dummy text 2"
         type: "text"
    }
}
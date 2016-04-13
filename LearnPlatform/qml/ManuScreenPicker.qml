import QtQuick 2.5
import QtQuick.Window 2.2
//import QuickMamba 1.0

Window{
    Rectangle
    {
        id:root
        property string pickerImg: "img/screenPicker.png"
        property string pickerImgHover: "img/screenPickerHover.png"
        // Default style
        color: "#212121"
        border.width: 2
        border.color: "#333"
        radius: 3
        height: pickerImg.height * 2
        width: pickerImg.width * 2

        signal accepted(var color)
        signal grabbedColor(var color)

        Image {
            id: pickerImg
            source: root.pickerImg
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: root
            hoverEnabled: true

            onEntered: pickerImg.source = root.pickerImgHover
            onExited: pickerImg.source = root.pickerImg

            //onPressed: screenPicker.grabbing = true
            cursorShape: Qt.OpenHandCursor
        }

        //ColorPicker {
        ManuColorDialog {
            id: screenPicker

            onAccepted:{
                print("accept color ", color)
                root.accepted(color)
            }
            //onCurrentColorChanged: root.grabbedColor(currentColor)
        }
    }
}

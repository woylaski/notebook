import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: window
    width: 150
    height: 130
    visible: true
    color: "#192324"
    title: "Progress Bar Circolare"

    ManuProgressCircleCanvas {
        id:progressBar
        width: parent.width
        height: 100
        y:10
    }

    Slider {
        id: sliderHorizontal
        anchors.top:progressBar.bottom
        anchors.horizontalCenter: window
        width: parent.width
        height: 20
         minimumValue: 0
        maximumValue: 100
        onValueChanged: progressBar.value=value;
    }
}




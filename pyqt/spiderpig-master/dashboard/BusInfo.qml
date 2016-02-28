import QtQuick 1.0
import "trafikanten.js" as Trafikanten

Rectangle {
    id: main
    width: 400
    height: 400

    property color themeColor: "#73c330"
    property color textColor: "white"
    property int headingFontSize: 20
    property string fontType: "Helvetica"
    property string stopID: ""
    property string direction: ""
    property int subFontSize: 12

    color: themeColor

    function updateDisplay() {
        //console.log("update");
        //console.log(Trafikanten.getBusData());
        Trafikanten.getBusData(onBusDataReceived, stopID, direction);

    }

    function onBusDataReceived(data) {
        //console.log("Received bus data for " + data.length + " buses");
        var buses = Math.min(3, data.length); // in case trafikanten reports less than 3
        for (var i=0; i<buses; i++) {
            busModel.set(i, {"line": data[i].lineNumber,
                             "name": data[i].lineName,
                             "timeRemaining": data[i].timeUntilArrival,
                             "realtime": data[i].realtime
            });
        }
    }

    Timer {
        interval: 10*1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: updateDisplay()
    }

    ListModel {
        id: busModel
        ListElement {
            line: ""
            name: ""
            timeRemaining: ""
            realtime: true
        }
        ListElement {
            line: ""
            name: ""
            timeRemaining: ""
            realtime: true
        }
        ListElement {
            line: ""
            name: ""
            timeRemaining: ""
            realtime: true
        }
    }

    // delegate for bus row
    Component {
        id: busListRow
        Item  {
            anchors.left: parent.left
            height: childrenRect.height 
            width: parent.width
            Rectangle {
                height: childrenRect.height
                width: parent.width
                anchors.right: parent.right
                color: themeColor

                Rectangle {
                    height: childrenRect.height
                    width: childrenRect.width
                    anchors.right: parent.right

                    Rectangle {
                        id: busNumber
                        height: childrenRect.height
                        width: childrenRect.width
                        anchors.left: parent.left
                        color: themeColor
                        Text {
                            color: textColor
                            font.bold: true
                            font.pixelSize: subFontSize
                            font.family: main.fontType
                            text: (!realtime ? "* " : "") + timeRemaining + " min"
                        }
                    }
                    Rectangle {
                        id: busTime
                        width: 30
                        height: childrenRect.height
                        anchors.left: busNumber.right
                        color: themeColor
                        Text {
                            width: parent.width
                            color: textColor
                            horizontalAlignment: Text.AlignRight
                            font.bold: true
                            font.pixelSize: subFontSize
                            font.family: main.fontType
                            text: line
                        }
                    }
                }

            }

            Rectangle {
                id: busName
                width: parent.width/2//childrenRect.width
                height: childrenRect.height
                anchors.left: parent.left
                color: themeColor
                clip: true
                Text {
                    color: textColor
                    //font.bold: true
                    font.pixelSize: subFontSize
                    font.family: main.fontType
                    text: name
                    //elide: Text.Elide
                }
            }

        }

    }

    Rectangle {
        color: themeColor
        width: busHeading.width
        height: busHeading.height
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        Text {
            id: busHeading
            color: textColor
            font.bold: true
            font.pixelSize: main.headingFontSize
            font.family: main.fontType
            text: "Bus"
        }
    }


    Rectangle {
        color: themeColor
        width: childrenRect.width

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        Text {
            id: nextHeading            
            color: textColor
            anchors.bottom: parent.bottom
            //font.bold: true
            font.pixelSize: subFontSize
            font.family: main.fontType
            text: busModel.get(0).line
        }

        Text {
            id: nextMinHeading    
            anchors.left: nextHeading.right 
            anchors.leftMargin: 6
            anchors.baseline: nextHeading.baseline
            color: textColor
            font.bold: true
            font.family: main.fontType
            font.pixelSize: 48
            text: busModel.get(0).timeRemaining + (busModel.get(0).realtime ? "'" : "*")
        }

    }



    ListView{
        id: busList
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        width: parent.width - anchors.leftMargin - anchors.rightMargin
        model: busModel
        delegate: busListRow
    }



}

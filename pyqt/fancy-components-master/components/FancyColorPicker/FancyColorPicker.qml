/****************************************************************************
**  FancyColorPicker component lets the user choose and select color from palette containing 9 colors.
**  This component was created because default(System) ColorDialog often is too 'complicated'.
**  By complicated I mean that it has more than enough colors, to be used conveniently eg. as a color tag picker.
**  Imagine selecting tag color from (0, 0, 0) to (255, 255, 255)
**  Selecting is not a problem, imagine using search box "I remember I used red color to mark this email thread, but there are plenty of reddish colors out there".
**  Author: Mateusz Drzazga
**  Email: matt.drzazga@gmail.com
**
****************************************************************************/

import QtQuick 2.4
import QtGraphicalEffects 1.0

FocusScope {
    id: scope
    visible: false
    scale: 0
    focus: false

    width: 160
    height: 160


    /* This property holds the model that is used to populate available colors pallete. It can hold up to 9 colors, passed as simple list.
    */
    property var model: ["#dfbc5a", "#b451a9", "#72c864", "#81f2e1", "#177047", "#8c4d29", "#67162e", "#dce428", "#fd7256"]

    /* This is alias for grid.currentIndex property, it holds current index of currently selected color.
    */
    property alias currentIndex: grid.currentIndex

    /* This property holds currently selected color.
    */
    readonly property alias selectedColor: root.selectedColor

    /* Setting this property to true will cause FancyColorPicker to expand greyed out sheet.
       This indicates that everything that is below that widget is inactive and thus unclickable.
       Default value: false
       // TODO It does not work as I imagined, yet. There shouldn't be an animation when expanding this sheet. It should be done instantly.
    */
    property bool expandSheet: false

    /* This signal is emitted when user selects color.
    */
    signal colorSelected(string color)

    /* This function opens dialog at given position. Function calculates x,y values so that when dialog is openned, it is centered both vertically and horizontally.
    */
    function open(mouseX, mouseY){
        scope.x = mouseX - scope.width / 2
        scope.y = mouseY - scope.height / 2
        root.state = "SHOWN"
    }

    function close(){
        root.state = ""
        scope.parent.forceActiveFocus()
    }

    //Shadow effect to provide layers experience
    DropShadow {
        anchors.fill: parent
        horizontalOffset: 3
        verticalOffset: 3
        cached: true
        samples: 16
        color: "#80000000"
        source: root
    }


    // MouseArea that covers entire available area to create application modality(known from dialogs) experiance.
    MouseArea {
        width: 5000
        height: 5000
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: scope.close()
        visible: root.state == "SHOWN"


        /* This Loader loads additional Rectangle
           Grey rectangle is loaded when property expandSheet is set to true.
        */
        Loader {
            id: sheetLoader
            anchors.fill: parent
            active: (root.state == "SHOWN" && scope.expandSheet)

            sourceComponent: Component {
                Rectangle {
                    color: "grey"
                    anchors.fill: parent
                    opacity: 0.3
                }
            }
        }
    }


    // White area with grid
    Rectangle {
        id: root
        anchors.fill: parent
        radius: width/2

        // MouseArea that does not allow the MouseArea below overlap, and steal mouse event that closes FancyColorPicker.
        MouseArea {
            anchors.fill: parent
        }

        /* This property holds current color. It is used to draw border line around currently selected color.
        */
        property string selectedColor


        /* Function is called when user selects color by mouse or by pressing space key.
        */
        function changeColor(index){
            root.selectedColor = scope.model[index]
            scope.colorSelected(root.selectedColor)
            scope.close()
        }

        Grid {
            id: grid
            spacing: 10
            focus: true
            columns: 3
            rows: 3
            anchors.centerIn: parent

            /* The currentIndex property holds the index of the current color.
            */
            property int currentIndex: -1

            Keys.onRightPressed: {
                currentIndex = (currentIndex + 1) % 9
            }

            Keys.onLeftPressed: {
                --currentIndex
                if (currentIndex < 0){
                    currentIndex = 8
                }
            }

            Keys.onDownPressed: {
                currentIndex = (currentIndex + 3) % 9
            }

            Keys.onUpPressed: {
                currentIndex -= 3
                if (currentIndex < 0){
                    currentIndex = 9 - Math.abs(currentIndex)
                }
            }

            Keys.onSpacePressed: root.changeColor(currentIndex)

            Keys.onEscapePressed: {
                scope.close()
            }


            Repeater {
                model: scope.model

                Rectangle {
                    id: delegate
                    width: 30
                    height: 30
                    radius: width / 2
                    color: scope.model[index]
                    scale: grid.currentIndex === index? 1.2 : 1
                    border.width: 1
                    border.color: root.selectedColor == color? "black" : "transparent"

                    MouseArea {
                        id: delegateMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.changeColor(index)

                        onContainsMouseChanged: {
                            if (containsMouse){
                                grid.currentIndex = index
                            }
                        }
                    }
                }
            }
        }

        states: State {
            name: "SHOWN"
            PropertyChanges {
                target: scope
                visible: true
                scale: 1
                focus: true
            }
        }

        transitions: Transition {
            from: ""
            to: "SHOWN"
            reversible: true

            SequentialAnimation {                                       // This is interesting. Duration lower than 2 is tricky.
                PropertyAnimation { target: scope; property: "visible"; duration: 2 }
                PropertyAnimation { target: scope; property: "scale"; duration: 150 }
            }
        }
    }
}

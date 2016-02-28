import QtQuick 1.1

FocusScope {
    id: comboBox
    property int maxHeight
    property int selectedItem
    property int listmaxheight:250
    property variant listModel
    signal expanded
    signal closed
    property string default_text
    property variant selectedText
    width: 120
    height: 25
    z:parent.z=11
    maxHeight:listModel.count*height
    Component.onCompleted: {
        if(listmaxheight > maxHeight)
        {
            listmaxheight=maxHeight
            scrollbar.opacity=0
            button.opacity=0
        }
    }
    ComboBoxButton {
        id: comboBoxButton
        width: parent.width
        height: parent.height
        buttontext: default_text
        onClicked: {
            if (frame.height == 0) {
                frame.height =listmaxheight
                frame.opacity=1
                buttonopacity=0
                comboBox.expanded()}
            else {
                frame.height=0
                frame.opacity=0
                buttonopacity=1
                comboBox.closed()}
        }
    }
    Rectangle{
        id:frame
        anchors.top: comboBoxButton.top
        anchors.left: comboBoxButton.left
        width: comboBoxButton.width
        height:0
        opacity:0
        border.color: "grey"
        clip:true

        Component {
            id: comboBoxDelegate

            Rectangle{
                id: delegateRectangle
                width: comboBoxButton.width-1
                height: 25
                color: "white"
                Text {
                    color: "black"
                    anchors.centerIn: parent
                    font.pointSize:12
                    font.bold: true
                    text: qtext
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: delegateRectangle.color="lightblue"
                    onPressed: delegateRectangle.color="lightblue"
                    onReleased: delegateRectangle.color="lightblue"
                    onExited: delegateRectangle.color="white"
                    onClicked: {
                        frame.height = 0
                        frame.opacity=0
                        comboBoxButton.buttonopacity=1
                        listView.currentIndex = index
                        comboBox.selectedItem = index
                        comboBoxButton.buttontext = qtext
                        selectedText = qtext
                        comboBox.closed()
                    }
                }
            }
        }

        ListView {
            // visible: false
            id: listView
            width: parent.width
            anchors.fill: parent
            anchors{
                topMargin: 1
                leftMargin: 1
                rightMargin: 1
                bottomMargin: 1
            }
            model: listModel
            delegate: comboBoxDelegate
            currentIndex: selectedItem
            focus:true
    //        highlight: Rectangle{width:parent.width;height: parent.height; color: "lightsteelblue";radius:5 }
            Behavior on height {
                NumberAnimation {
                    id: animateHeight
                    property: "height"
                    duration: 200
                    easing {type: Easing.Linear}
                }
            }
        }
        Rectangle{
            id:scrollbar
            anchors.right: parent.right
            anchors.rightMargin: 8
            height: parent.height
            width:5
            color: "lightgrey"
        }
        Rectangle{
            id: button
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: 12
            y: listView.visibleArea.yPosition * scrollbar.height
            height: listView.visibleArea.heightRatio * scrollbar.height;
            radius: 3
            smooth: true
            color: "white"
            border.color: "lightgrey"
            Column{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2
                Rectangle{
                    width: 8;height: 1
                    color: "lightgrey"
                }
                Rectangle{
                    width: 8;height: 1
                    color: "lightgrey"
                }
                Rectangle{
                    width: 8;height: 1
                    color: "lightgrey"
                }
            }
            MouseArea {
                id: mousearea
                anchors.fill: button
                drag.target: button
                drag.axis: Drag.YAxis
                drag.minimumY: 0
                drag.maximumY: scrollbar.height - button.height
                onMouseYChanged: {
                    listView.contentY = button.y / scrollbar.height * listView.contentHeight
                }
            }
        }
    }

}

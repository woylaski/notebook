import QtQuick 1.1

Rectangle {
    id: calendar

    Theme {id: theme}
    //property Theme theme: Theme {}

    color: theme.themeColor
    height: theme.tileHeight
    width: theme.tileWidth

    ListModel {
        id: calendarModel
        ListElement {
            title: "Scrum"; location:"Scrumroom"; time: "10:00"
        }
        ListElement {
            title: "Friday coke"; location:"2th floor, PP1"; time: "13:30"
        }
    }

    Component {
        id: row
        Rectangle {
            height: childrenRect.height
            width: parent.width
            color: calendar.color

            Text {
                id: titleText
                text: title
                font.family: theme.fontFamily
                color: theme.fontColor
                anchors.left: parent.left
            }
            Text {
                text: "@" + location
                font.family: theme.fontFamily
                color: theme.fontColor
                anchors.left: titleText.right
            }
            Text {
                text: time
                font.family: theme.fontFamily
                color: theme.fontColor
                anchors.right: parent.right
            }
        }
    }

    ListView {
        id: list
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        delegate: row
        model: calendarModel
    }

}

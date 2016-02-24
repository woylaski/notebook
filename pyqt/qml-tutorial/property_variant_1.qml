import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle {
    id: test;
    //width: 300; height: 200
    visible: true

    //property variant testData: [{"a":"1"}, {"a": "2"}]
    property variant testData: {"a":"1", "a": "2"}

    Repeater {
        model:testData;
        /*
        Text {
            text: modelData.a
        }
        */
        Rectangle {
            width: 100
            height: 20
            radius: 3
            color: "lightBlue"
            Text {
                anchors.centerIn: parent
                text: index +": "+ modelData
            }
        }

    }

/*
    MouseArea {
        id: testArea
        anchors.fill: parent

        onClicked: {
            testData.a = "0"
            testData.b = "1"
        }
    }
*/
    MouseArea {
        id: testArea
        anchors.fill: parent
        onClicked: {
            var tmp = testData;  // 赋值给局部变量
            tmp.a = "0"
            tmp.b = "1"
            testData = tmp;
        }
    }
}
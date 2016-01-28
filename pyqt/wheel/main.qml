import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id:root;
    visible: true;
    width: 600;
    height: 400;

    Image {
        id: bg

        width: root.width;
        height:root.height;
        source: "qrc:///images/bg.png";// 路径根据自己设置的修改
    }

    Image {
        id: wheel;
        anchors.centerIn: parent;
        source: "qrc:///images/wheel.png";// 路径根据自己设置的修改

        Behavior on rotation {

            NumberAnimation {
                duration: 5000
            }
        }

        MouseArea {
            width: wheel.width;
            height: wheel.height;

            onClicked: {
                wheel.rotation = 360;
            }
        }
    }

}

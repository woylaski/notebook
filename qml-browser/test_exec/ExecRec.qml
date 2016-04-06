import QtQuick 2.0
import com.manu.exec 1.0

Rectangle {
    width: 100
    height: 100
    Exec { id: exec }
    MouseArea {
        anchors.fill: parent
        onClicked: exec.cmd('ls');
    }
}


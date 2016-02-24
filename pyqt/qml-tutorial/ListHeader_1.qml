import QtQuick 2.0

Item {
    height: 60
    width: parent.width

    property bool refresh: state == "pulled" ? true : false

    Row {
        spacing: 6
        height: childrenRect.height
        anchors.centerIn: parent

        Image {
            id: arrow
            source: "./images/icon-refresh.png"//箭头图标
            transformOrigin: Item.Center
            Behavior on rotation { NumberAnimation { duration: 200 } }
        }

        Text {
            id: label
            anchors.verticalCenter: arrow.verticalCenter
            text: "Pull to refresh...    "
            font.pixelSize: 18
            color: "#999999"
        }
    }

    states: [
        State {
            name: "base"; when: listWorkSheet.contentY >= -120//listWorkSheet列表控件
            PropertyChanges { target: arrow; rotation: 180 }
        },
        State {
            name: "pulled"; when: listWorkSheet.contentY < -120//listWorkSheet列表控件
            PropertyChanges { target: label; text: "Release to refresh..." }
            PropertyChanges { target: arrow; rotation: 0 }
        }
    ]
}
//-------------------------------ListHeader.qml结束------------------------------------------

        ListView {
                id:listWorkSheet
                
                onDragEnded: if (header.refresh) 
		{
		   //重新加载代码...
		}

                Controls.ListHeader {
                    anchors.top: recDate.bottom//recDate为listWorkSheet上面的控件
                    id: header
                    y: -listWorkSheet.contentY - height                
}
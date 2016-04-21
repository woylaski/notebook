import QtQuick 2.0
import QtQuick.Controls 1.2

ApplicationWindow {
    id: applicationWindow1
    width: 320
    height: 480
    title: "Resource Manager Test Window"

    ResolutionManagerCahce {
        id: _S
        appWindow: parent
        intendedScreenWidth: 320
        intendedScreenHeight: 480

        /*Preset app-wide sizes
          These are only recalculated one
          */
        property real s_TEXT_SIZE_MEDIUM: 20
        property real s_TEXT_SIZE_SMALL: 14
        property real s_ACTION_BAR_HEIGHT: 48
        property real s_SQUARE_SIDE: 80
        property real s_MARGIN: 5
    }


    //--------------------------
    Rectangle {
        id: header
        height: _S.s_ACTION_BAR_HEIGHT
        color: "#00aaff"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top

        Text {
            color: "#ffffff"
            text: "App Header"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: _S.s_TEXT_SIZE_MEDIUM
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ListModel {
        id: colorModel

        property variant names: ["Grey", "Red", "Blue", "Green"]
        property variant clors: ["grey", "red", "blue", "green"]

        function randName() {
            return names[Math.floor(Math.random() * 4)]
        }
        function randColor() {
            return clors[Math.floor(Math.random() * 4)]
        }

        Component.onCompleted: {
            for (var i = 0; i < 100; i++) {
                colorModel.append({
                                      name: randName(),
                                      colorCode: randColor()
                                  })
            }
            gridView1.model = colorModel
        }
    }

    GridView {
        id: gridView1
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        cellWidth: _S.s_SQUARE_SIDE
        cellHeight: cellWidth

        delegate: Item {
            width: _S.s_SQUARE_SIDE
            height: width

            Column {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: _S.s_MARGIN
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: _S.s_SQUARE_SIDE / 2
                    height: _S.s_SQUARE_SIDE / 2
                    color: colorCode
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: name
                    font.bold: true
                    font.pixelSize: _S.s_TEXT_SIZE_SMALL
                }
            }
        }
    }
}

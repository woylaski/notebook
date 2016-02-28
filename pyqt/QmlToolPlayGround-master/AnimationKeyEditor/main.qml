import QtQuick 2.2
import QtQuick.Controls 1.2

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "gray"

        ListModel {
            id: keyList

            function findKey(frame) {
                var i;

                for (i = 0; i < count; i++) {
                    if (frame === get(i).frame) {
                        return i;
                    }
                }

                return -1;
            }

            function insertKey(frame, value) {
                var keyObj = {frame: frame, value: value};

                if (count === 0) {
                    append(keyObj);

                    return true;
                }

                if (frame < get(0).frame) {
                    insert(0, keyObj);

                    return true;
                }

                if (frame > get(count - 1).frame) {
                    append(keyObj);

                    return true;
                }

                var i;

                for (i = 0; i < count; i++) {
                    if (frame === get(i).frame) {
                        get(i).value = value;
                        return false;
                    }
                }

                for (i = 0; i < count - 1; i++) {
                    if (frame > get(i).frame && frame < get(i + 1).frame) {
                        insert(i + 1, keyObj);

                        return true;
                    }
                }

                console.log("ERROR!!!!!!!!!!!!!!!!");
                return false;
            }
        }

        Rectangle {
            height: parent.height
            width : 300
        }

        ScrollView {
            id: scrollView
            x: 300
            height: parent.height
            width: parent.width - 300


            Rectangle {
                id: animationCurveView

                height: scrollView.height - 30
                width: 2000

                property alias keyList: keyControlArea.children
                property real frameInterval: 10

                Rectangle {
                    id: animationCurveHeader
                    width: parent.width
                    height: 50

                    color: "#DDDDDD"

                    Canvas {
                        anchors.fill: parent
                        property real frameInterval: 10
                        onPaint: {
                            var ctx = getContext('2d');

                            ctx.clearRect(0, 0, width, height);
                            ctx.strokeStyle = Qt.rgba(0.3, 0.3, 0.3, 1);
                            ctx.lineWidth = 0.2;
                            ctx.beginPath();

                            for (var i = 0; i < width; i += frameInterval * 5) {
                                ctx.moveTo(i, 0);//start point
                                ctx.lineTo(i, height);
                            }
                            ctx.stroke();
                        }
                    }

                    ListView {
                        width: parent.width
                        height: parent.height

                        orientation: ListView.Horizontal
                        model: 40

                        delegate: Rectangle {
                            width: animationCurveView.frameInterval * 5
                            height: parent.height / 2

                            color: "transparent"

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 2
                                text: index * 5
                            }
                        }
                    }

                    Rectangle {
                        id: vertHeaderLine
                        x: -10
                        y: 0

                        width: 1
                        height: parent.height

                        color: "red"
                        opacity: 0.5
                    }
                }

                Rectangle {
                    id: animationCurveBody
                    y: animationCurveHeader.height
                    width: parent.width
                    height: parent.height - animationCurveHeader.height

                    color: "gray"

                    Item {
                        id: curveCanvas
                        anchors.fill: parent

                        function clear() {
                            children = [];
                        }

                        function redraw() {
                            console.log("redraw");
                            clear();

                            if (keyControlArea.children.length < 2) {

                            } else {
                                var component = Qt.createComponent("HermiteCurveItem.qml");
                                for (var i = 0; i < keyControlArea.children.length - 1; i++) {
                                    var keyItem1 = keyControlArea.children[i];
                                    var keyItem2 = keyControlArea.children[i + 1];

                                    var c1 = Qt.vector2d(keyItem1.x, keyItem1.y);
                                    var c2 = Qt.vector2d(keyItem2.x, keyItem2.y);

                                    console.log("c1: " + c1.x + " , " + c1.y);
                                    console.log("c2: " + c2.x + " , " + c2.y);

                                    var curveItem = component.createObject(curveCanvas, {width: width, height: height, control01: c1, control02: c2});

                                }
                            }
                        }
                    }

                    Canvas {
                        anchors.fill: parent
                        property real frameInterval: 10
                        onPaint: {
                            var ctx = getContext('2d');

                            ctx.clearRect(0, 0, width, height);
                            ctx.strokeStyle = Qt.rgba(0.3, 0.3, 0.3, 1);
                            ctx.lineWidth = 0.5;
                            ctx.beginPath();

                            for (var i = 0; i < width; i += frameInterval) {
                                ctx.moveTo(i, 0);//start point
                                ctx.lineTo(i, height);
                            }
                            ctx.stroke();
                        }
                    }

                    MouseArea {
                        id: mouseHandler

                        anchors.fill: parent

                        drag.threshold: 2

                        property alias activeKeyItem : keyControlArea.activeKeyItem

                        onPressed: {
                            var frame = Math.round(mouseX / animationCurveView.frameInterval);
                            var frameX = frame * animationCurveView.frameInterval;

                            //var keyFrame = keyList.findKey(frame);
                            var hittedIdx = keyControlArea.getHittedChildIdx(mouseX, mouseY);
                            if (hittedIdx !== -1) {
                                console.log(hittedIdx);
                                activeKeyItem = keyControlArea.getKeyItem(frame);
                                activeKeyItem.isActive = true;
                            } else {
                                //keyList.insertKey(frame, mouseY)
//                                var component = Qt.createComponent("KeyControl.qml");
//                                var keyItem = component.createObject(keyControlArea, {x: frameX, y: mouseY, frame: frame});
//                                console.log("new Item : " + keyItem.x + " , " + keyItem.y);

//                                keyControlArea.updateChildren();

//                                activeKeyItem = keyItem;
//                                activeKeyItem.isActive = true;
                                if (activeKeyItem) {
                                    activeKeyItem.isActive = false;
                                    activeKeyItem = null;
                                }
                            }

                            checkOverllaped(mouseX, mouseY);
                        }

                        onReleased: {
                            if (activeKeyItem) {
                                if (activeKeyItem.valid) {

                                } else {
                                    var keyItem = keyControlArea.getKeyItem(activeKeyItem.frame);
                                    console.log("delete " + activeKeyItem.frame + " : " + keyItem);
                                    keyControlArea.deleteKeyItem(keyItem); // doesn't work immediately
                                    keyItem.destroy();

                                    activeKeyItem.valid = true;

                                    console.log("count of KeyItems : " + keyControlArea.children.length);
                                }

                                //activeKeyItem.isActive = false;
                                //activeKeyItem = null;

                                keyControlArea.updateChildren();
                            }
                        }

                        onClicked: {
                        }

                        onDoubleClicked: {
                            var frame = Math.round(mouseX / animationCurveView.frameInterval);
                            var frameX = frame * animationCurveView.frameInterval;

                            var component = Qt.createComponent("KeyControl.qml");
                            var keyItem = component.createObject(keyControlArea, {x: frameX, y: mouseY, frame: frame});
                            console.log("new Item : " + keyItem.x + " , " + keyItem.y);

                            keyControlArea.updateChildren();

                            activeKeyItem = keyItem;
                            activeKeyItem.isActive = true;
                        }

                        hoverEnabled: true

                        onPositionChanged: {
                            updateMousePosition(mouseX, mouseY);

                            checkOverllaped(mouseX, mouseY);
                        }

                        function checkOverllaped(x, y) {
                            if (pressed & pressedButtons === Qt.LeftButton) {
                                if (activeKeyItem) {
                                    var frame = Math.round(x / animationCurveView.frameInterval);
                                    var frameX = frame * animationCurveView.frameInterval;

                                    activeKeyItem.x = frameX;
                                    activeKeyItem.y = y;
                                    activeKeyItem.frame = frame;

                                    var keyItem = keyControlArea.getKeyItem(frame);
                                    if (keyItem && keyItem !== activeKeyItem) {
                                        activeKeyItem.valid = false;
                                    } else {
                                        activeKeyItem.valid = true;
                                    }

                                    keyControlArea.updateChildren();
                                }
                            }
                        }

                        function updateMousePosition(x, y) {
                            vertLine.x = Math.round(x / animationCurveView.frameInterval) * animationCurveView.frameInterval;
                            vertHeaderLine.x = vertLine.x;
                            horzLine.y = y;
                        }

                        Rectangle {
                            id: vertLine
                            x: -10
                            y: 0

                            width: 1
                            height: parent.height

                            color: "red"
                            opacity: 0.5
                        }

                        Rectangle {
                            id: horzLine
                            x: 0
                            y: -10

                            width: parent.width
                            height: 1

                            color: "red"
                            opacity: 0.5
                        }
                    }

                    Item {
                        id: keyControlArea
                        anchors.fill: parent

                        property var activeKeyItem : null

                        signal keyItemUpdated

                        function sortChildren() {
                            var childList = [];

                            console.log("before");
                            for(var i = 0; i < children.length; i++) {
                                console.log(children[i].frame);
                                childList.push(children[i]);
                            }

                            console.log("after");
                            childList.sort(function(a, b) {return a.frame - b.frame;});

                            for(var i = 0; i < childList.length; i++) {
                                console.log(childList[i].frame);
                                childList[i].idx = i;
                            }

                            children = childList;
                        }

                        function updateChildren() {

                            sortChildren();
                            keyItemUpdated();

                            curveCanvas.redraw();
                        }

                        function setKey(frame, value) {
                            for(var i = 0; i < children.length; i++) {
                                //console.log( children[i].frame + " : " + frame);
                                if (children[i].frame === frame) {
                                    children[i].y = value;
                                }
                            }
                        }

                        function getKeyItem(frame) {
                            //console.log("finding " + frame);
                            for(var i = 0; i < children.length; i++) {
                                if (children[i].frame === frame && children[i] !== activeKeyItem) {
                                    //console.log("child[" + i +"].valid : " + children[i].valid);
                                    return children[i];
                                }
                            }

                            return null;
                        }

                        function deleteKeyItem(keyItem) {
                            var childList = [];

                            for(var i = 0; i < children.length; i++) {
                                if (children[i] === keyItem) {
                                    children[i].destroy();
                                } else {
                                    childList.push(children[i]);
                                }
                            }

                            children = childList;
                        }

                        function getHittedChildIdx(x, y) {
                            for (var i = 0; i < children.length; i++) {
                                var child = children[i];
                                if ( Math.abs(child.x - x) < child.size
                                        && Math.abs(child.y - y) < child.size) {
                                    return i;
                                }
                            }

                            return -1;
                        }
                    }

                }
            }
        }
    }
}

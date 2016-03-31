import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

import "qrc:/style/style" as Style

Rectangle {
    visible: true

    //width: 480;
    //height: 320;
    color: "black";

    //onWidthChanged: mask.recalc();
    //onHeightChanged: mask.recalc();
    //Image 可以显示一个图片，只要是 Qt 支持的，比如 JPG 、 PNG 、 BMP 、 GIF 、 SVG 等都可以显示。
    //它只能显示静态图片，对于 GIF 等格式，只会把第一帧显示出来。
    //如果你要显示动画，可以使用 AnimateSprite 或者 AnimateImage
    Image {
        id: source;
        visible: true;
        anchors.fill: parent;
        //Image 的 width 和 height 属性用来设定图元的大小，
        //如果你没有设置它们，那么 Image 会使用图片本身的尺寸
        //如果你设置了 width 和 height ，那么图片就可能会拉伸来适应这个尺寸
        //此时 fillMode 属性可以设置图片的填充模式，
        //它支持 Image.Stretch（拉伸） 、 Image.PreserveAspectFit（等比缩放） 、
        //Image.PreserveAspectCrop（等比缩放，最大化填充 Image ，必要时裁剪图片） 、
        //Image.Tile（在水平和垂直两个方向平铺，就像贴瓷砖那样） 、
        //Image.TileVertically（垂直平铺） 、 Image.TileHorizontally（水平平铺） 、
        //Image.Pad（保持图片原样不作变换） 等模式。
        fillMode: Image.PreserveAspectFit;

        //Image 默认会阻塞式的加载图片，如果要显示的图片很小，没什么问题，
        //如果分辨率很高，麻烦就来了。此时你可以设置 asynchronous 属性为 true 来开启异步加载模式，
        //这种模式下 Image 使用一个线程来加载图片，而你可以在界面上显示一个等待图标之类的小玩意儿来告诉用户它需要等会儿。
        //然后当 status（枚举值） 的值为 Image.Ready 时再隐藏加载等候界面。
        asynchronous: true;
        onStatusChanged: {
            if(status == Image.Ready){
                console.log("image loaded");
                mask.recalc();
            }
        }
    }

    FileDialog {
        id: fileDialog;
        title: "Please choose an Image File";
        nameFilters: ["Image Files (*.jpg *.png *.gif)"];
        onAccepted: {
            source.source = fileDialog.fileUrl;
        }
    }

    Component {
        id: flatButton;
        ButtonStyle {
            background: Rectangle{
                implicitWidth: 70;
                implicitHeight: 30;
                border.width: control.hovered ? 2: 1;
                border.color: control.hovered ? "#c0c0c0" : "#909090";
                color: control.pressed ? "#a0a0a0" : "#707070";
            }
            label: Text {
                anchors.fill: parent;
                font.pointSize: 12;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                text: control.text;
                color: (control.hovered && !control.pressed) ?
"blue": "white";
            }
        }
    }

    Canvas {
        id: mask;
        anchors.fill: parent;
        z: 1;

        property real w: width;
        property real h: height;
        property real dx: 0;
        property real dy: 0;
        property real dw: 0;
        property real dh: 0;
        property real frameX: 66;
        property real frameY: 66;

        function calc(){
            var sw = source.sourceSize.width;
            var sh = source.sourceSize.height;
            if(sw > 0 && sh > 0){
                if(sw <= w && sh <=h){
                    dw = sw;
                    dh = sh;
                }else{
                    var sRatio = sw / sh;
                    dw = sRatio * h;
                    if(dw > w){
                        dh = w / sRatio;
                        dw = w;
                    }else{
                        dh = h;
                    }
                }
                dx = (w - dw)/2;
                dy = (h - dh)/2;
            }
        }

        function recalc(){
            calc();
            //触发重画
            requestPaint();
        }

        function getImageData(){
            //CanvasImageData getImageData(real sx, real sy, real sw, real sh)
            //Returns an CanvasImageData object containing the image data for the given rectangle of the canvas
            return context.getImageData(frameX - 64, frameY - 64, 128, 128);
        }

        onPaint: {
            var ctx = getContext("2d");
            if(dw < 1 || dh < 1) {
                ctx.fillStyle = "#0000a0";
                ctx.font = "20pt sans-serif";
                ctx.textAlign = "center";
                ctx.fillText("Please Choose An Image File", width/2, height/2);
                return;
            }

            ctx.clearRect(0, 0, width, height);
            //drawImage(variant image, real dx, real dy, real dw, real dh)
            //drawImage(variant image, real dx, real dy)
            //This is an overloaded function. Draws the given item as image onto the canvas at point (dx, dy) and with width dw, height dh.
            //The image type can be an Image item, an image url or a CanvasImageData object. When given as Image item, if the image isn't fully loaded, this method draws nothing
            ctx.drawImage(source, dx, dy, dw, dh);

            //fillRect
            var xStart = frameX - 66;
            var yStart = frameY - 66;
            ctx.save();

            //遮罩的颜色，像一层纱窗
            ctx.fillStyle = "#a0000000";

            //把整个图片罩上纱窗，除了鼠标点击位置为起点的一个132、132的矩形，还是原色的，显得亮一些
            //这样就要把这矩形的上方罩上纱窗
            ctx.fillRect(0, 0, w, yStart);

            //这样就要把这矩形的整个下方罩上纱窗
            var yOffset = yStart + 132;
            ctx.fillRect(0, yOffset, w, h - yOffset);

            //这样就要把这矩形的左侧方罩上纱窗
            ctx.fillRect(0, yStart, xStart, 132);

            //这样就要把这矩形的右侧方罩上纱窗
            var xOffset = xStart + 132;
            ctx.fillRect(xOffset, yStart, w - xOffset, 132);

            //see through area
            //小红框
            ctx.strokeStyle = "red";
            ctx.fillStyle = "#00000000";
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.rect(xStart, yStart, 132, 132);
            ctx.fill();
            ctx.stroke();
            ctx.closePath ();
            ctx.restore();

        }
    }

    Canvas {
        id: forSaveCanvas;
        width: 128;
        height: 128;
        contextType: "2d";
        visible: false;
        z: 2;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;

        property var imageData: null;
        onPaint: {
            if(imageData != null){
                //抠出来的小图
                context.drawImage(imageData, 0, 0);
            }
        }

        function setImageData(data){
            imageData = data;
            requestPaint();
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent;
        minimumTouchPoints: 1;
        maximumTouchPoints: 1;
        touchPoints:[
            TouchPoint{
                id: point1;
            }
        ]

        onUpdated: {
            mask.frameX = point1.x;
            mask.frameY = point1.y;
            mask.requestPaint();
        }

        onReleased: {
            forSaveCanvas.setImageData(mask.getImageData());
            actionPanel.visible = true;
        }

        onPressed: {
            actionPanel.visible = false;
        }
    }

    Row {
        id: actionPanel
        //z越大越在上边，类似于图层
        z: 5
        //这个Row 整体居中
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 20;

        spacing: 8;

        Button {
            //style: Style.FlatButtonStyle;
            style: flatButton;
            text: "Open";
            onClicked:{
                fileDialog.open();
            }
        }

        Button {
            style: flatButton;
            text: "Save";
            onClicked: {
                //bool save(string filename)
                //Save the current canvas content into an image file filename.
                //The saved image format is automatically decided by the filename's suffix.
                forSaveCanvas.save("selected.png");
                actionPanel.visible = false;
            }
        }

        Button {
            style: flatButton;
            text: "Cancel";
            onClicked:{
                actionPanel.visible = false;
            }
        }
    }
}


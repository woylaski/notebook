import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

import "../JavaScriptFiles/tempValue.js" as JS

Rectangle{
	id: root;

	//x: 0; y:0;
    width:Screen.width/2;
    height:Screen.height/2;
    radius: 10;

    color: "paleturquoise";
    border.color: "lightsteelblue"
    border.width: 4
    //接收键盘事件
    focus: true;
    visible: true;

    //自定义变量
    property bool vidFormatChanged: false
    property string stateDisplay:"";
    property string indexvalue: ""
    property int controly : 0;
    property int controlId
    property int brightnessControlId
    property int contrastControlId
    property int saturationControlId
    property int panControlId
    property int tiltControlId
    property int zoomControlId
    property int hueControlId
    property int ledModeControlId
    property int whiteBalanceControl_auto_Id
    property int whiteBalanceControlId
    property int gammaControlId
    property int sharpnessControlId
    property int gainControlId
    property int powerLineComboControlId
    property int ledModeComboControlId
    property int exposureAutoControlId
    property int exposurecontrolId
    property int exposureAutoPriorityControlId
    property int backLightCompensationId
    property int rawBitsControlId
    property int ledFreqControlId
    property int focusLogitechControlId
    property int focusControlId
    property int focusControlAutoId
    property int disableVideoControlId
    property bool powerLineComboEnable
    property bool ledModeComboEnable
    property bool exposureComboEnable
    property bool keyEventFiltering
    property int seconds : 0

    property string statusText : "Status Bar";
    property bool stillColorSpace
    property bool outputSizeBox
    property bool colorSpace
    property bool frameRateBox

    property bool brightValueChangeProperty
    property bool contrastValueChangeProperty
    property bool saturationValueChangeProperty
    property bool panValueChangeProperty
    property bool tiltValueChangeProperty
    property bool zoomValueChangeProperty
    property bool wbValueChangeProperty
    property bool sharpValueChangeProperty
    property bool gainValueChangeProperty
    property bool hueValueChangeProperty
    property bool ledModeChangeProperty
    property bool exposureValueChangeProperty
    property bool bcklightValueChangeProperty
    property bool rawBitsValueChangeProperty
    property bool ledFreqValueChangeProperty
    property bool focusLogitechValueChangeProperty
    property bool focusValueChangeProperty
    property bool setResolutionEnable

    //property string systemVideoFolder : "video"
    property string videoStoragePath : SystemVideoFolder

    //about 窗口变量
    property variant aboutWindow
    property variant see3cam

    //camera模式tab选择动作
    Action {
        id: cameratab
        onTriggered: {
            selectCameraSettings()
        }
    }

    //about动作Action
    Action {
        id: aboutAction
        onTriggered: {
        	console.log("about action triggered");
            aboutWindow.show();
        }
    }

    //exit 动作action
    Action {
        id: exitAction
        onTriggered: {
            exitDialog.visible = true
        }
    }

    Action {
        id: stillProperty
        onTriggered: {
            stillImageProperty()
        }
    }

    Action {
        id: videoControl
        onTriggered: {
            videoControlFilter()
        }
    }

    Action {
        id: videoLocation
        onTriggered: {
            fileDialogVideo.open()
        }
    }

    Action {
        id: videoCap
        onTriggered: {
            videoCapProperty()
            openVideoPinPage()
        }
    }

    Action {
        id: hardwareDefault
        onTriggered: {
            vidstreamproperty.cameraFilterControls(olderValue)
        }
    }

    //拍照模式按钮动作
    Action {
        id: cameraBtn
        onTriggered: {
            captureBtnSelected()
        }
    }

    //录像模式按钮动作
    Action {
        id: videoBtn
        onTriggered: {
            videoBtnSelected()
        }
    }

    //抓拍按钮
    Action {
        id: photoCapture
        enabled: capture.enabled ?  true : false
        onTriggered: {
            mouseClickCapture()
        }
    }

    //录像按钮
    Action {
        id: videoRecord
        enabled: record.enabled ?  true : false
        onTriggered: {
            videoRecordBegin()
        }
    }

    //录像保存按钮
    Action {
        id: saveVideo
        onTriggered: {
            videoSaveVideo()
        }
    }


    //拍照按钮触发动作
    function captureBtnSelected() {
    	console.log("cameraBtn triggered")
    	//录像状态不显示，显示拍照状态
        video_selected.visible = false;
        camera_selected.visible = true;

        capture.visible = true
        record.visible = false
    }

    //录像按钮触发动作
    function videoBtnSelected() {
    	console.log("videoBtn triggered")

    	//拍照状态不显示，显示录像状态
        video_selected.visible = true;
        camera_selected.visible = false;
        capture.visible = false
        record.visible = true
    }

    //抓拍按钮动作
    function mouseClickCapture() {
        capture.enabled = false
        capture.opacity = 0.5
    }

    //录像动作
    function videoRecordBegin() {
        record_stop.visible = true
        record.visible = false
    }

    //保存录像动作
    function videoSaveVideo() {
        record.visible = true
        record_stop.visible = false
    }

    function selectCameraSettings(){
    	camera_settings.forceActiveFocus()
        cbItemsImgFormat.clear();
        cbItemsImgFormat.insert(0, {text: "raw" })
        cbItemsImgFormat.insert(1, {text: "bmp" })
        cbItemsImgFormat.insert(2, {text: "jpg" })
        cbItemsImgFormat.insert(3, {text: "png" })
    }

    function extensionTab() {
        if(cameraColumnLayout.visible) {
            cameraColumnLayout.visible = false
            JS.cameraComboIndex = device_box.currentIndex
            if(device_box.currentText == "e-con's 1MP Bayer RGB \nCamera" ) {
                see3cam = Qt.createComponent("UVCSettings/see3cam10/uvc10_c.qml").createObject(root)
            } else if(device_box.currentText == "e-con's 1MP Monochrome\n Camera") {
                see3cam = Qt.createComponent("UVCSettings/see3cam10/uvc10_m.qml").createObject(root)
            } else if(device_box.currentText == "See3CAM_11CUG") {
                see3cam = Qt.createComponent("UVCSettings/see3cam11/uvc11.qml").createObject(root)
            } else if(device_box.currentText == "e-con's 8MP Camera") {
                see3cam = Qt.createComponent("UVCSettings/see3cam80/uvc80.qml").createObject(root)
            } else if(device_box.currentText == "See3CAMCU50") {
                see3cam = Qt.createComponent("UVCSettings/see3cam50/uvc50.qml").createObject(root)
            } else if(device_box.currentText == "See3CAM_CU130") {
                see3cam = Qt.createComponent("UVCSettings/see3cam130/uvc130.qml").createObject(root)
            } else if(device_box.currentText == "See3CAM_CU51") {
                see3cam = Qt.createComponent("UVCSettings/see3cam51/uvc51.qml").createObject(root)
            } else if(device_box.currentText == "See3CAM_12CUNIR") {
                see3cam = Qt.createComponent("UVCSettings/see3camar0130/uvc_ar0130.qml").createObject(root)
            } else if(device_box.currentText == "See3CAM_CU40") {
                see3cam = Qt.createComponent("UVCSettings/see3cam40/uvc40.qml").createObject(root)
            } else if(device_box.currentText == "CX3-UVC") {
                see3cam = Qt.createComponent("UVCSettings/ascella/cx3-uvc.qml").createObject(root)
            } else {
                //see3cam = Qt.createComponent("UVCSettings/others/others.qml").createObject(root)
                see3cam = Qt.createComponent("UVCSettings/ascella/cx3-uvc.qml").createObject(root)
            }
        }
    }

    function stillImageProperty() {
        if(!stillchildProperty.visible) {
            //camproperty.logDebugWriter("Still Properties Selected")
            stillchildProperty.visible = true
            color_comp_box.forceActiveFocus()
            video_capture_filter_Child.visible = false
            video_Capture_property_Child.visible = false
            controly =0
            stillColorSpace = true
        } else {
            stillchildProperty.visible = false
            stillchildProperty.focus = false
        }
    }

    function videoControlFilter() {
        if(!video_capture_filter_Child.visible) {
            //camproperty.logDebugWriter("Video Capture Filter Selected")
            brightValueChangeProperty = true
            brightness_Slider.forceActiveFocus()
            contrastValueChangeProperty = true
            saturationValueChangeProperty = true
            panValueChangeProperty = true
            tiltValueChangeProperty = true
            zoomValueChangeProperty = true
            wbValueChangeProperty = true
            sharpValueChangeProperty = true
            gainValueChangeProperty = true
            hueValueChangeProperty = true
            ledModeChangeProperty = true
            exposureValueChangeProperty = true
            bcklightValueChangeProperty = true
            rawBitsValueChangeProperty = true
            ledFreqValueChangeProperty = true
            focusLogitechValueChangeProperty = true
            focusValueChangeProperty = true
            controly = 30
            stillchildProperty.visible = false
            video_capture_filter_Child.visible = true
            video_Capture_property_Child.visible = false
            vidstreamproperty.cameraFilterControls()
        } else {
            video_capture_filter_Child.visible = false
            video_capture_filter_Child.focus = false
        }
    }

    function videoCapProperty() {
        if(!video_Capture_property_Child.visible) {
            //camproperty.logDebugWriter("Video Capture Property selected")
            stillchildProperty.visible = false
            video_capture_filter_Child.visible = false
            video_Capture_property_Child.visible = true
            frame_rate_box.forceActiveFocus()
            controly = 0
        } else {
            video_Capture_property_Child.visible = false
        }
    }

    //退出对话框
    MessageDialog {
        id: exitDialog
        title: "Exit Application"
        icon: StandardIcon.Question
        text: qsTr("Do you want to really close the application?")
        standardButtons:  StandardButton.No | StandardButton.Yes
        onYes: Qt.quit()
        onNo: close()
        Component.onCompleted:{
            close()
        }
    }

    //背景图片
    Image {
        id: layer_0
        source: "images/layer_0.png"
        x: sideBarItems.visible ? 268 : 0
        y: 0
        opacity: 1
        width: sideBarItems.visible ? parent.width - 268 : parent.width
        height: parent.height - statusbar.height
        visible: true;
    }

    //左边框收缩
    Image {
        id: open_sideBar
        visible: false
        source: "images/open_tab.png"
        anchors.bottom: layer_0.bottom
        anchors.bottomMargin: 50
        anchors.left: layer_0.left
        y: layer_0.height/2 + 20
        opacity: 1
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                open_sideBar.opacity = 1
            }
            onExited: {
                open_sideBar.opacity = 1
            }

            onReleased: {
                sideBarItems.visible = true
                open_sideBar.visible = false
            }
        }
    }

    //左边栏
    Item {
        id: sideBarItems

        //左边栏背景
        Image {
            id: side_bar_bg
            source: "images/side_bar_bg.png"
            x: -3
            y: -3
            height: root.height+5
            opacity: 1
        }

        //选中条目的背景色
        Image {
            id: selection_bg
            source: "images/selection_bg.png"
            visible: false
            y: 197
            opacity: 1
        }

        //切换边框
        Image {
            id: toggle_border
            source: "images/toggle_border.png"
            x: 5
            y: 153
            opacity: 1
        }

        //摄像头选择的外框
        Image {
            id: camera_box
            source: "images/camera_box.png"
            x: 18
            y: 18
            opacity: 1
        }

        //选择摄像头模式，拍照还是录像
        Row {
            spacing: 12
            x: 45
            y: 27

            //选择拍照模式按钮
            Button {
                id: camera_btn
                opacity: 1
                tooltip: "Camera Mode Selection"
                action: cameraBtn
                activeFocusOnPress : true
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 1 : 0
                        color: "#222021"
                        border.color: "#ffffff"
                    }
                    label: Image {
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        source: "images/camera_btn.png"
                    }
                }
                Keys.onReturnPressed: {
                    captureBtnSelected()
                }
            }

            //选中拍照模式，当前处于拍照模式
            Image {
                id: camera_selected
                source: "images/camera_selected.png"
                opacity: 1
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if((mouseX > (camera_selected.paintedWidth/2)) && !record_stop.visible) {
                            video_selected.visible = true;
                            camera_selected.visible = false;
                            capture.visible = false
                            record.visible = true
                        }
                    }
                }
            }

            //选中摄像模式，当前处于录像模式
            Image {
                id: video_selected
                source: "images/video_selected.png"
                opacity: 1
                visible: false
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if((mouseX < (video_selected.paintedWidth/2)) && !record_stop.visible) {
                            video_selected.visible = false;
                            camera_selected.visible = true;
                            capture.visible = true
                            record.visible = false
                        }
                    }
                }
            }

            //选择录像模式按钮
            Button {
                id: video_btn
                opacity: 1
                tooltip: "Video Mode Selection"
                action: videoBtn
                y: 2
                activeFocusOnPress : true
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 1 : 0
                        color: "#222021"
                        border.color: "#ffffff"
                    }
                    label: Image {
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        source: "images/video_btn.png"
                    }
                }
                Keys.onReturnPressed: {
                    videoBtnSelected()
                }
            }

           	//抓拍按钮
            Button {
                id: capture
                enabled: false
                visible: true
                action: photoCapture
                opacity: enabled ? 1 : 0.5
                activeFocusOnPress: true
                y: -3
                tooltip: "Click this icon/preview to capture photo"
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 1 : 0
                        color: "#222021"
                        border.color: "#ffffff"
                    }
                    label: Image {
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        source: "images/capture.png"
                    }
                }
                Keys.onReturnPressed: {
                    mouseClickCapture()
                }
            }

            //开始录像按钮
            Button {
                id: record
                opacity: 0.5
                enabled: false
                visible: false
                activeFocusOnPress : true
                y: -3
                action: videoRecord
                tooltip: "Click this icon/preview to start recording video"
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 1 : 0
                        color: "#222021"
                        border.color: "#ffffff"
                    }
                    label: Image {
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        source: "images/record.png"
                    }
                }
                Keys.onReturnPressed: {
                    videoRecordBegin()
                }
            }

            //录像结束按钮
            Button {
                id: record_stop
                opacity: 1
                visible: false
                tooltip: "Click this icon/preview to stop/save the recorded video"
                y: -3
                action: saveVideo
                activeFocusOnPress: true
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 1 : 0
                        color: "#222021"
                        border.color: "#ffffff"
                    }
                    label: Image {
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        fillMode: Image.PreserveAspectFit
                        source: "images/record_stop.png"
                    }
                }
                Keys.onReturnPressed: {
                    videoSaveVideo()
                }
            }
        }

        //摄像头设备选择复选框
        ComboBox {
            currentIndex: 0
            property int oldIndex: currentIndex
            property int indexZero: 1
            id: device_box
            x: 18
            y: 110
            opacity: 1
            textRole: "display"
            model: camModels
            activeFocusOnPress : true

            style: ComboBoxStyle {
                background: Image {
                    id: deviceBox
                    source: "images/device_box.png"
                    Rectangle {
                        width: deviceBox.sourceSize.width -28
                        height: deviceBox.sourceSize.height
                        color: "#222021"
                        border.color: "white"
                        border.width: control.activeFocus ? 3 : 1
                        radius: control.activeFocus ? 5 : 0
                    }
                }
                label:  Text{
                    anchors.fill: parent
                    color: "#ffffff"
                    elide: Text.ElideRight
                    text: control.currentText
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    font.family: "Ubuntu"
                    font.pixelSize: 14
                }
            }

            //鼠标区域
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    if(pressed) {
                        camproperty.checkforDevice()
                    }
                    mouse.accepted = false
                }
                onWheel: {
                }
            }

            //选中一个新的设备
            onCurrentIndexChanged: {
            	console.log("choose a new device")
            }

            Component.onCompleted: {
                camproperty.checkforDevice()
            }
        }

        //vidRecTimer
        Text {
            id: vidRecTimer
            visible: false
            font.pixelSize: 16
            font.family: "Ubuntu"
            font.bold: true
            color: "green"
            smooth: true
            x: 18
            y: 66
            opacity: 1
        }

        //device_connected
        Text {
            id: device_connected
            text: "Device Connected"
            font.pixelSize: 16
            font.family: "Ubuntu"
            color: "#ffffff"
            smooth: true
            x: 18
            y: vidRecTimer.visible ? 88 : 72
            opacity: 1
        }

        //摄像头配置
        Button {
            id: camera_settings
            focus: false
            smooth: true
            x: cameraColumnLayout.visible ? 0 : 7
            y: cameraColumnLayout.visible ? 149 : 153
            opacity: 1
            tooltip: "Camera Settings - This settings will have the v4l2 controls for the camera"
            style: tabButtonStyle
            action: cameratab
            activeFocusOnPress: true
            onFocusChanged: {
                if(activeFocus){
                    selectCameraSettings()
                }
            }
        }

        //列布局
        ColumnLayout{
        	id: cameraColumnLayout

        	//videoFilter
            Item {
                id: videoFilter

                //视频
                Button {
                    id: video_capture_filter
                    y: 206
                    opacity: 1
                    tooltip: "Image Quality Settings - \nAllows User to adjust the control settings of the preview"
                    action: videoControl
                    activeFocusOnPress : true
                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: 265
                            implicitHeight: 15
                            border.width: control.activeFocus ? 1 : 0
                            color: control.activeFocus ? "#df643e" : video_capture_filter_Child.visible ? "#df643e" : "#222021"  ///*#df643e"//*/
                            border.color: control.activeFocus ? "#df643e" : "#222021"
                        }
                        label: Image {
                            horizontalAlignment: Image.AlignLeft
                            fillMode: Image.PreserveAspectFit
                            source: "images/image_qualitysettings.png"
                        }
                    }

                    //滚动条
                    ScrollView {
                        id: video_capture_filter_Child
                        x:10
                        y: 35
                        width: 257
                        height: 160
                        visible: false

                        style: ScrollViewStyle {
                            scrollToClickedPosition: true
                            handle: Image {
                                id: scrollhandle
                                source: "images/scroller.png"
                            }
                            scrollBarBackground: Image {
                                id: scrollStyle
                                source: "images/Scroller_bg.png"
                            }
                            incrementControl: Image {
                                id: increment
                                source: "images/down_arrow.png"
                            }
                            decrementControl: Image {
                                id: decrement
                                source: "images/up_arrow.png"
                            }
                        }

                        Item {
                            height: focus_value.y + 85

                            //----------3列的网格--------------
                            GridLayout {
                                id: grid
                                columns: 3
                                rowSpacing: 15
                                columnSpacing: 8

                                //--------------------------光照------------------
                                //亮度设置
                                Text {
                                    id: brightness
                                    text: "Brightness"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                //用来设置大小的滚动条滑块
                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: brightness_Slider
                                    opacity: enabled ? 1 : 0.1
                                    width: 110
                                    stepSize: 1
                                    style:econSliderStyle
                                    onValueChanged:  {
                                        if(brightValueChangeProperty) {
                                            camproperty.logDebugWriter("Brightness changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(brightnessControlId,value.toString())
                                        }
                                    }
                                }

                                //文本输入,手动设置光照
                                TextField {
                                    id: brightness_value                                    
                                    text: brightness_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: brightness_Slider.minimumValue; top: brightness_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            brightness_Slider.value = brightness_value.text
                                    }
                                }

                                //--------------------------contrast------------------
                                Text {
                                    id: contrast
                                    text: "Contrast"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: contrast_Slider
                                    width: 110
                                    stepSize: 1
                                    style:econSliderStyle
                                    opacity: enabled ? 1 : 0.1
                                    onValueChanged: {
                                        if(contrastValueChangeProperty) {
                                            camproperty.logDebugWriter("Contrast changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(contrastControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: contrast_value
                                    text: contrast_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: contrast_Slider.minimumValue; top: contrast_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            contrast_Slider.value = contrast_value.text
                                    }
                                }

                                //--------------------------saturation------------------
                                Text {
                                    id: saturation
                                    text: "Saturation"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: saturation_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(saturationValueChangeProperty) {
                                            camproperty.logDebugWriter("Saturation changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(saturationControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: saturation_value
                                    text: saturation_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: saturation_Slider.minimumValue; top: saturation_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            saturation_Slider.value = saturation_value.text
                                    }
                                }

                                //--------------------------saturation------------------
                                Text {
                                    id: pan
                                    text: "Pan\n(Absolute)"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: pan_Slider
                                    opacity: enabled ? 1 : 0.1
                                    width: 110
                                    stepSize: 3600
                                    style:econSliderStyle
                                    onValueChanged:  {
                                        if(panValueChangeProperty) {
                                            camproperty.logDebugWriter("Pan changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(panControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: pan_value
                                    text: pan_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: pan_Slider.minimumValue; top: pan_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            pan_Slider.value = pan_value.text
                                    }
                                }

                                //--------------------------tilt------------------
                                Text {
                                    id: tilt
                                    text: "Tilt\n(Absolute)"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: tilt_Slider
                                    opacity: enabled ? 1 : 0.1
                                    width: 110
                                    stepSize: 3600
                                    style:econSliderStyle
                                    onValueChanged:  {
                                        if(tiltValueChangeProperty) {
                                            camproperty.logDebugWriter("Tilt changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(tiltControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: tilt_value
                                    text: tilt_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: tilt_Slider.minimumValue; top: tilt_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            tilt_Slider.value = tilt_value.text
                                    }
                                }

                                //--------------------------zoom------------------
                                Text {
                                    id: zoom
                                    text: "Zoom\n(absolute)"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: zoom_Slider
                                    opacity: enabled ? 1 : 0.1
                                    width: 110
                                    stepSize: 1
                                    style:econSliderStyle
                                    onValueChanged:  {
                                        if(zoomValueChangeProperty) {
                                            camproperty.logDebugWriter("zoom changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(zoomControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: zoom_value
                                    text: zoom_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: zoom_Slider.minimumValue; top: zoom_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            zoom_Slider.value = zoom_value.text
                                    }
                                }

                                //-----------------------white_balance------------------
                                Column {
                                    spacing: 4
                                    Text {
                                        id: white_balance
                                        text: "White\nBalance"
                                        font.pixelSize: 12
                                        font.family: "Ubuntu"
                                        color: "#ffffff"
                                        smooth: true
                                        opacity: 0.1
                                    }
                                    CheckBox {
                                        id: autoSelect_wb
                                        opacity: 0.1
                                        activeFocusOnPress: true
                                        style: CheckBoxStyle {
                                            label: Text {
                                                id: autowb
                                                text: "Auto"
                                                font.pixelSize: 10
                                                font.family: "SegoeUI-Light"
                                                color: "#ffffff"
                                                smooth: true
                                                opacity: 1
                                            }
                                        }
                                        onCheckedChanged: {
                                            if(checked) {
                                                camproperty.logDebugWriter("White Balance set to Auto Mode")
                                                vidstreamproperty.changeSettings(whiteBalanceControl_auto_Id,1)
                                                white_balance_Slider.opacity = 0.1
                                                white_balance_Slider.enabled = false
                                            } else {
                                                camproperty.logDebugWriter("White Balance set to Manual Mode")                                                
                                                vidstreamproperty.changeSettings(whiteBalanceControl_auto_Id,0)
                                                white_balance_Slider.opacity = 1
                                                white_balance_Slider.enabled = true
                                            }
                                        }
                                    }
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: white_balance_Slider
                                    opacity: enabled ? 1 : 0.1
                                    width: 110
                                    stepSize: 1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(wbValueChangeProperty) {
                                            if(!autoSelect_wb.checked) {
                                                camproperty.logDebugWriter("White Balance changed to: "+ value.toString())
                                                vidstreamproperty.changeSettings(whiteBalanceControlId,value.toString())
                                            } else {
                                                white_balance_Slider.enabled = false
                                            }
                                        }
                                        wbValueChangeProperty = true
                                    }
                                }

                                TextField {
                                    id: wb_value
                                    text: white_balance_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: white_balance_Slider.minimumValue; top: white_balance_Slider.maximumValue;}
                                    opacity: white_balance_Slider.enabled ? 1: 0
                                    //opacity: autoSelect_wb.checked ? 0 : 1
                                    enabled: autoSelect_wb.checked ? false : true
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            white_balance_Slider.value = wb_value.text
                                    }
                                }

                                //-----------------------Gamma------------------
                                Text {
                                    id: gamma
                                    text: "Gamma"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    property bool gammaValueChangeProperty
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: gamma_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(gammaValueChangeProperty) {
                                            camproperty.logDebugWriter("Gamma settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(gammaControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: gamma_value
                                    text: gamma_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: gamma_Slider.minimumValue; top: gamma_Slider.maximumValue;}
                                    smooth: true
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            gamma_Slider.value = gamma_value.text
                                    }
                                }

                                //-----------------------Sharpness------------------
                                Text {
                                    id: sharpness
                                    text: "Sharpness"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: sharpness_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(sharpValueChangeProperty) {
                                            camproperty.logDebugWriter("Sharpness settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(sharpnessControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: sharpness_value
                                    text: sharpness_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: sharpness_Slider.minimumValue; top: sharpness_Slider.maximumValue;}
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            sharpness_Slider.value = sharpness_value.text
                                    }
                                }

                                //-----------------------Gain------------------
                                Text {
                                    id: gain
                                    text: "Gain"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity:0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: gain_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(gainValueChangeProperty) {
                                            camproperty.logDebugWriter("Gain settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(gainControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: gain_value
                                    text: gain_Slider.value
                                    validator: IntValidator {bottom: gain_Slider.minimumValue; top: gain_Slider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            gain_Slider.value = gain_value.text
                                    }
                                }

								//-----------------------Hue------------------
                                Text {
                                    id: hue
                                    text: "Hue"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: hue_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(hueValueChangeProperty) {
                                            camproperty.logDebugWriter("Hue settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(hueControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: hue_value
                                    text: hue_Slider.value
                                    validator: IntValidator {bottom: hue_Slider.minimumValue; top: hue_Slider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    horizontalAlignment: TextInput.AlignHCenter
                                    smooth: true
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            hue_Slider.value = hue_value.text
                                    }
                                }

                                //-----------------------powerLine------------------
                                Text {
                                    id: powerLine
                                    text: "PowerLine\nFrequency"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                ComboBox
                                {
                                    id: powerLineCombo
                                    opacity: 0
                                    model: menuitems
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: deviceBox_powerLine
                                            source: "images/plinefreq_box.png"                                            
                                            Rectangle {
                                                width: deviceBox_powerLine.sourceSize.width - 20
                                                height: deviceBox_powerLine.sourceSize.height + 3
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label:  Text{
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            elide: Text.ElideRight
                                            text: control.currentText
                                            verticalAlignment: Text.AlignVCenter
                                            maximumLineCount: 1
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        if(powerLineComboEnable) {
                                            vidstreamproperty.selectMenuIndex(powerLineComboControlId,currentIndex)
                                        }
                                    }
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                //-----------------------Exposure------------------
                                Text {
                                    id: exposure_auto
                                    text: "Exposure,\nAuto"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                ComboBox
                                {
                                    id: exposureCombo
                                    model: menuitems
                                    opacity: 0
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: deviceBox2
                                            source: "images/plinefreq_box.png"
                                            Rectangle {
                                                width: deviceBox2.sourceSize.width - 20
                                                height: deviceBox2.sourceSize.height + 3
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label:  Text{
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            elide: Text.ElideRight
                                            text: control.currentText
                                            verticalAlignment: Text.AlignVCenter
                                            maximumLineCount: 1
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        if(exposureComboEnable) {
                                            vidstreamproperty.selectMenuIndex(exposureAutoControlId,currentIndex)
                                            if(currentText.toString() == "Manual Mode") {
                                                JS.autoExposureSelected = false
                                                exposure_absolute.opacity = 1
                                                exposure_Slider.opacity = 1
                                                exposure_Slider.enabled = true
                                                exposure_value.opacity = 1
                                                exposure_value.enabled = true
                                            } else {
                                                JS.autoExposureSelected = true
                                                exposure_absolute.opacity = 0.1
                                                exposure_Slider.opacity = 0.1
                                                exposure_Slider.enabled = false
                                                exposure_value.opacity = 0
                                                exposure_value.enabled = false
                                            }
                                        }
                                    }
                                }

                                Image {
                                    //For layout purpose
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                }

                                //-----------------------Exposure------------------
                                Text {
                                    id: exposure_absolute
                                    text: "Exposure\n(Absolute)"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity:  0
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: exposure_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if((exposureCombo.currentText == "Manual Mode") || (device_box.currentText == "e-con's CX3 RDK with O\nV5680") || (device_box.currentText == "e-con's CX3 RDK with M\nT9P031") || (device_box.currentText == "See3CAM_CU40")) {
                                            camproperty.logDebugWriter("Exposure Control settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(exposurecontrolId,value.toString())
                                        }

                                    }
                                }

                                TextField {
                                    id: exposure_value
                                    text: exposure_Slider.value
                                    validator: IntValidator {bottom: exposure_Slider.minimumValue; top: exposure_Slider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style:econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            exposure_Slider.value = exposure_value.text
                                    }
                                }

                                //-----------------------exposureAutoPriority------------------
                                Column {
                                    spacing : 4
                                    Text {
                                        id: exposureAutoPriority
                                        text: "Exposure,\nAuto\nPriority"
                                        font.pixelSize: 12
                                        font.family: "Ubuntu"
                                        color: "#ffffff"
                                        smooth: true
                                        opacity: 0.1
                                    }
                                    CheckBox {
                                        id: exposureAutoPriorityCheck
                                        onCheckedChanged: {
                                            if(checked) {                                                
                                                camproperty.logDebugWriter("enable exposure auto priority")
                                                vidstreamproperty.changeSettings(exposureAutoPriorityControlId,1)
                                            } else {                                                
                                                camproperty.logDebugWriter("disable exposure auto priority")
                                                vidstreamproperty.changeSettings(exposureAutoPriorityControlId,0)
                                            }
                                        }
                                    }
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }
                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                //-----------------------BackLight------------------
                                Text {
                                    id: backLightCompensation
                                    text: "BackLight\nCompen\n-sation"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: backLight_Slider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(bcklightValueChangeProperty) {
                                            camproperty.logDebugWriter("Backlight compensation settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(backLightCompensationId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: backLight_value
                                    text: backLight_Slider.value
                                    validator: IntValidator {bottom: backLight_Slider.minimumValue; top: backLight_Slider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            backLight_Slider.value = backLight_value.text
                                    }
                                }

                                //-----------------------rawBits------------------
                                Text {
                                    id: rawBits
                                    text: "Raw bits\nper pixel"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: rawBitsSlider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(rawBitsValueChangeProperty) {
                                            camproperty.logDebugWriter("raw bits per pixel settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(rawBitsControlId,value.toString())                                            
                                        }
                                    }
                                }

                                TextField {
                                    id: rawBits_value
                                    text: rawBitsSlider.value
                                    validator: IntValidator {bottom: rawBitsSlider.minimumValue; top: rawBitsSlider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            rawBitsSlider.value = rawBits_value.text
                                    }
                                }
                                //-----------------------ledModeText------------------
                                Text {
                                    id: ledModeText
                                    text: "LED1 Mode"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                ComboBox
                                {
                                    id: ledModeCombo
                                    opacity: 0
                                    activeFocusOnPress: true
                                    model: ListModel {
                                        id: cbItemsledModes
                                        ListElement { text: "Off"  }
                                        ListElement { text: "On"  }
                                        ListElement { text: "Blinking"  }
                                        ListElement { text: "Auto"  }
                                    }
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: ledModeComboImage
                                            source: "images/plinefreq_box.png"
                                            Rectangle {
                                                width: ledModeComboImage.sourceSize.width - 20
                                                height: ledModeComboImage.sourceSize.height + 3
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label:  Text{
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            elide: Text.ElideRight
                                            text: control.currentText
                                            verticalAlignment: Text.AlignVCenter
                                            maximumLineCount: 1
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        if(ledModeComboEnable) {                                            
                                            vidstreamproperty.changeSettings(ledModeComboControlId,currentIndex.toString())
                                        }
                                    }
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                //-----------------------ledFrequency------------------
                                Text {
                                    id: ledFrequency
                                    text: "LED1\nFrequency"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: ledFreqSlider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(ledFreqValueChangeProperty) {
                                            camproperty.logDebugWriter("led frequency settings changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(ledFreqControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: ledFreq_value
                                    text: ledFreqSlider.value
                                    validator: IntValidator {bottom: ledFreqSlider.minimumValue; top: ledFreqSlider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            ledFreqSlider.value = ledFreq_value.text
                                    }
                                }

                                //-----------------------focusLogitech------------------
                                Text {
                                    id: focusLogitech
                                    text: "Focus"
                                    font.pixelSize: 12
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 0.1
                                }

                               	Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: focusLogitechSlider
                                    width: 110
                                    stepSize: 1
                                    opacity: enabled ? 1 : 0.1
                                    style:econSliderStyle
                                    onValueChanged: {
                                        if(focusLogitechValueChangeProperty) {
                                            camproperty.logDebugWriter("focus settings for logitech camera changed to: "+ value.toString())
                                            vidstreamproperty.changeSettings(focusLogitechControlId,value.toString())
                                        }
                                    }
                                }

                                TextField {
                                    id: focusLogitech_value
                                    text: focusLogitechSlider.value
                                    validator: IntValidator {bottom: focusLogitechSlider.minimumValue; top: focusLogitechSlider.maximumValue;}
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    opacity: 0
                                    style: econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            focusLogitechSlider.value = focusLogitech_value.text
                                    }
                                }

                                //-----------------------disableVideoProcess------------------
                                Column {
                                    spacing : 4
                                    Text {
                                        id: disableVideoProcess
                                        text: "Disable\nvideo\nProcessing"
                                        font.pixelSize: 12
                                        font.family: "Ubuntu"
                                        color: "#ffffff"
                                        smooth: true
                                        opacity: 0.1
                                    }
                                    CheckBox {
                                        id: disableVideoProcessCheck
                                        onCheckedChanged: {
                                            if(checked) {                                                
                                                camproperty.logDebugWriter("Disable video processing")
                                                vidstreamproperty.changeSettings(disableVideoControlId,1)
                                            } else {                                                
                                                camproperty.logDebugWriter("Enable video processing")
                                                vidstreamproperty.changeSettings(disableVideoControlId,0)
                                            }                                            
                                        }
                                    }
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                //-----------------------focusauto------------------
                                Column {
                                    spacing: 4
                                    Text {
                                        id: focusauto
                                        text: "Focus\nAbsolute"
                                        font.pixelSize: 12
                                        font.family: "Ubuntu"
                                        color: "#ffffff"
                                        smooth: true
                                        opacity: 0.1
                                    }
                                    CheckBox {
                                        id: autoSelect_focus                                        
                                        style: CheckBoxStyle {
                                            label: Text {
                                                id: autofocus
                                                text: "Auto"
                                                font.pixelSize: 10
                                                font.family: "SegoeUI-Light"
                                                color: "#ffffff"
                                                smooth: true
                                                opacity: 1
                                            }
                                        }
                                        onCheckedChanged: {
                                            if(checked) {
                                                JS.autoFocusChecked = true
                                                camproperty.logDebugWriter("Focus control set in Auto Mode")
                                                vidstreamproperty.changeSettings(focusControlAutoId,1)
                                                focus_Slider.opacity = 0.1
                                                focus_Slider.enabled = false
                                                focus_value.opacity = 0
                                                focus_value.enabled = false
                                            } else {
                                                JS.autoFocusChecked = false
                                                camproperty.logDebugWriter("Focus control set in Manual Mode")
                                                vidstreamproperty.changeSettings(focusControlAutoId,0)
                                                focus_Slider.opacity = 1
                                                focus_Slider.enabled = true
                                                focus_value.opacity = 1
                                                focus_value.enabled = true
                                            }
                                        }
                                    }
                                }

                                Slider {
                                    activeFocusOnPress: true
                                    updateValueWhileDragging: false
                                    id: focus_Slider
                                    width: 110
                                    stepSize: 1
                                    style:econSliderStyle
                                    opacity: enabled ? 1 : 0.1
                                    onValueChanged: {
                                        if(focusValueChangeProperty) {
                                            if(!autoSelect_focus.checked || device_box.currentText == "e-con's CX3 RDK with O\nV5680") {
                                                camproperty.logDebugWriter("Focus control settings changed to: "+ value.toString())
                                                vidstreamproperty.changeSettings(focusControlId,value.toString())
                                            } else {
                                                focus_Slider.enabled = false
                                                focus_Slider.opacity = 0.1
                                                focus_value.enabled = false
                                                focus_value.opacity = 0
                                            }
                                        }
                                        focusValueChangeProperty = true
                                    }
                                }

                                TextField {
                                    id: focus_value
                                    text: focus_Slider.value
                                    font.pixelSize: 10
                                    font.family: "Ubuntu"
                                    smooth: true
                                    horizontalAlignment: TextInput.AlignHCenter
                                    validator: IntValidator {bottom: focus_Slider.minimumValue; top: focus_Slider.maximumValue;}
                                    opacity: 0
                                    style:econTextFieldStyle
                                    onTextChanged: {
                                        if(text != "")
                                            focus_Slider.value = focus_value.text
                                    }
                                }

                                //-----------------------exposureAutoPriority------------------
                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }

                                Button {
                                    opacity: 1
                                    action: hardwareDefault
                                    activeFocusOnPress : true
                                    style: ButtonStyle {
                                        background: Rectangle {
                                            border.width: control.activeFocus ? 3 :0
                                            color: "#222021"
                                            border.color: control.activeFocus ? "#ffffff" : "#222021"
                                            radius: 5
                                        }
                                        label: Image {
                                            horizontalAlignment: Image.AlignHCenter
                                            verticalAlignment: Image.AlignVCenter
                                            fillMode: Image.PreserveAspectFit
                                            source: "images/hardware_default_selected.png"
                                            sourceSize.width: 110
                                        }
                                    }
                                }

                                Image {
                                    source: "images/pline_dropdown.png"
                                    opacity: 0
                                    //Just for layout purpose
                                }
                            //------------3列网格结束------------------
                            }
                        //网格的item结束
                        }
                    //滚动条结束
                    }

                    onFocusChanged: {
                        video_capture_filter_Child.visible = false
                    }
                    Keys.onSpacePressed: {

                    }
                    Keys.onReturnPressed: {
                        videoControlFilter()
                    }

                //button结束
                }
            //item结束
            }

            //-----------另外一个条目设置--------------
            Item {
                id: stillproperties //Still Capture settings

                Button {
                    id: still_properties // still_capture_settings
                    tooltip: "Still Capture Settings - \nAllows the user to set the image color space, image resolution,\nimage path, and image format(extension) for photo capture"
                    action: stillProperty
                    activeFocusOnPress : true

                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: 265
                            implicitHeight: 15
                            border.width: control.activeFocus ? 1 : 0
                            color: control.activeFocus ? "#df643e" : stillchildProperty.visible ? "#df643e" : "#222021"  ///*#df643e"//*/
                            border.color: control.activeFocus ? "#df643e" : "#222021"
                        }
                        label: Image {
                            horizontalAlignment: Text.AlignLeft
                            fillMode: Image.PreserveAspectFit
                            source: "images/stillcapturesettings.png"
                        }
                    }

                    y: video_capture_filter_Child.visible ? 400 : 240
                    opacity: 1

                    //又是3列的配置
                    Item {
                        id: stillchildProperty
                        visible: false
                        x: 10

                        //------------Color Space--------------
                        Text {
                            id: color_compression
                            text: "Color Space/ Compression :"
                            font.pixelSize: 14
                            font.family: "Ubuntu"
                            color: "#ffffff"
                            smooth: true
                            x: 0
                            y: 40
                            opacity: 1
                        }

						ListModel {
						    id: resolutionModel
						    ListElement { text: "Cat" }
						    ListElement { text: "Dog" }
						    ListElement { text: "Mouse" }
						    ListElement { text: "Rabbit" }
						    ListElement { text: "Horse" }
						}

                        ComboBox {
                            id: color_comp_box
                            opacity: 1
                            model: resolutionModel
                            //textRole: "display"
                            smooth: true
                            x: 0
                            y: 60
                            activeFocusOnPress: true
                            style: ComboBoxStyle {
                                background: Image {
                                    id: resolutionSize
                                    source: "images/device_box.png"
                                    Rectangle {
                                        width: resolutionSize.sourceSize.width - 28
                                        height: resolutionSize.sourceSize.height
                                        color: "#222021"
                                        border.color: "white"
                                        border.width: control.activeFocus ? 3 : 1
                                        radius: control.activeFocus ? 5 : 0
                                    }
                                }
                                label: Text {
                                    anchors.fill: parent
                                    color: "#ffffff"
                                    text: control.currentText
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Ubuntu"
                                    font.pixelSize: 14
                                }
                            }
                            onCurrentIndexChanged: {
                                JS.stillCaptureFormat = color_comp_box.currentIndex.toString()
                                if(JS.triggerMode_11cug === 1 || JS.triggerMode_B === 1 || JS.triggerMode_M === 1 || JS.triggerMode_cu51 === 1)
                                    triggerModeCapture()

                                if(stillColorSpace) {
                                      updateStillPreview(output_value.currentText.toString(), color_comp_box.currentIndex.toString())
                                }
                            }
                            Component.onCompleted:
                            {
                                stillColorSpace = true
                            }
                        }

                        Image {
                            id: color_comp_dropdown
                            source: "images/output_dropdown.png"
                            x: 204
                            y: 62
                            opacity: 1
                        }

                        //------------output_size--------------
                        Text {
                            id: output_size
                            text: "Output Size :"
                            font.pixelSize: 14
                            font.family: "Ubuntu"
                            color: "#ffffff"
                            smooth: true
                            x: 0
                            y: 95
                            opacity: 1
                        }
                        /*
						ListModel {
						    id: stillOutputFormatModel
						    ListElement { text: "Cat" }
						    ListElement { text: "Dog" }
						    ListElement { text: "Mouse" }
						    ListElement { text: "Rabbit" }
						    ListElement { text: "Horse" }
						}
						*/
                        ComboBox {
                            id: output_value
                            opacity: 1

                            //textRole: "display"
                            smooth: true
                            x: 0
                            y: 115
                            activeFocusOnPress: true

                            model: ListModel {
							    id: stillOutputFormatModel
                                ListElement { text: "jpg"  }
                                ListElement { text: "bmp"  }
                                ListElement { text: "raw"  }
                                ListElement { text: "png"  }
							}

                            style: ComboBoxStyle {
                                background: Image {
                                    id: resolutionSize2
                                    source: "images/device_box.png"
                                    Rectangle {
                                        width: resolutionSize2.sourceSize.width - 28
                                        height: resolutionSize2.sourceSize.height
                                        color: "#222021"
                                        border.color: "white"
                                        border.width: control.activeFocus ? 3 : 1
                                        radius: control.activeFocus ? 5 : 0
                                    }
                                }
                                label: Text {
                                    anchors.fill: parent
                                    color: "#ffffff"
                                    text: control.currentText
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Ubuntu"
                                    font.pixelSize: 14
                                }
                            }
                            /*
                            onCurrentIndexChanged: {
                                JS.stillCaptureResolution = output_value.currentText.toString()
                                if(JS.triggerMode_11cug === 1 || JS.triggerMode_B === 1 || JS.triggerMode_M === 1 || JS.triggerMode_cu51 === 1)
                                    triggerModeCapture()
                            }
                            */
                        }

                        Text {
                            id: image_location
                            text: "Image Location :"
                            font.pixelSize: 14
                            font.family: "Ubuntu"
                            color: "#ffffff"
                            smooth: true
                            x: 0
                            y: 155
                            opacity: 1
                        }

                        Action {
                            id: stillFileDialog
                            onTriggered: {
                                fileDialog.open()
                            }
                        }

                        Button {
                            id: still_box
                            x: 0
                            y: 175
                            width:230
                            opacity: 1
                            action: stillFileDialog
                            activeFocusOnPress : true
                            style: ButtonStyle {
                                background: Image {
                                    id: stillLoc
                                    horizontalAlignment: Image.AlignHCenter
                                    verticalAlignment: Image.AlignVCenter
                                    fillMode: Image.PreserveAspectFit
                                    source: "images/still_box.png"
                                    Rectangle {
                                        width: stillLoc.sourceSize.width + 15
                                        height: stillLoc.sourceSize.height
                                        border.width: control.activeFocus ? 3 : 1
                                        color: "#222021"
                                        border.color: "#ffffff"
                                    }
                                }
                            }
                        }

                        FileDialog {
                            id: fileDialog
                            selectFolder: true
                            title: qsTr("Select a folder")
                            onAccepted: {
                                storage_path.text = folder.toString().replace("file://", "")
                            }
                        }

                        //------------storage_path--------------
                        Text {
                            id: storage_path
                            text: SystemPictureFolder
                            elide: Text.ElideLeft
                            font.pixelSize: 14
                            font.family: "Ubuntu"
                            color: "#ffffff"
                            smooth: true
                            x: 4
                            y: 180
                            width: 185
                            opacity: 1
                        }

                        Image {
                            id: open_folder
                            source: "images/open_folder.png"
                            x: 205
                            y: 182
                            opacity: 1
                        }

                        //------------image_format--------------
                        Text {
                            id: image_format
                            text: "Image Format :"
                            font.pixelSize: 14
                            font.family: "Ubuntu"
                            color: "#ffffff"
                            smooth: true
                            x: 0
                            y: image_location.y + 60
                            opacity: 1
                        }

                        ComboBox {
                            id: imageFormatCombo
                            property bool checkIndex : false
                            opacity: 1
                            activeFocusOnPress: true
                            model: resolutionModel
                            /*
                            model: ListModel {
                                id: cbItemsImgFormat
                                ListElement { text: "jpg"  }
                                ListElement { text: "bmp"  }
                                ListElement { text: "raw"  }
                                ListElement { text: "png"  }
                            }
                            */
                            x: 0
                            y: image_format.y + 20
                            style: ComboBoxStyle {
                                background: Image {
                                    id: imageFormatBox
                                    source: "images/device_box.png"
                                    Rectangle {
                                        width: imageFormatBox.sourceSize.width - 28
                                        height: imageFormatBox.sourceSize.height
                                        color: "#222021"
                                        border.color: "white"
                                        border.width: control.activeFocus ? 3 : 1
                                        radius: control.activeFocus ? 5 : 0
                                    }
                                }
                                label:  Text{
                                    anchors.fill: parent
                                    color: "#ffffff"
                                    text: control.currentText
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Ubuntu"
                                    font.pixelSize: 14
                                }
                            }
                        }
                    //------------item end
                    }

                    Keys.onReturnPressed: {
                        stillImageProperty()
                    }
                    Keys.onSpacePressed: {

                    }
                    onFocusChanged: {
                        stillchildProperty.visible = false
                    }
                //button end
                }
            //item end
            }


            //--------又一个item 配置设置
            Item {
                id: videoCaptureProperty
                Button {
                    id: video_Capture
                    y: stillchildProperty.visible ? image_format.y + 300 : still_properties.y + 35
                    opacity: 1
                    action: videoCap
                    activeFocusOnPress : true
                    tooltip: "Video Capture Settings - \nAllows the user to set the frame rate, preview color space,\npreview resolution, the format(extension), encoder and video path\nfor video recording"

                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: 265
                            implicitHeight: 15
                            border.width: control.activeFocus ? 1 : 0
                            color: control.activeFocus ? "#df643e" : video_Capture_property_Child.visible ? "#df643e" : "#222021"
                            border.color: control.activeFocus ? "#df643e" : "#222021"
                        }
                        label: Image {
                            horizontalAlignment: Text.AlignLeft
                            fillMode: Image.PreserveAspectFit
                            source: "images/videocapturesettings.png"
                        }
                    }

                    ScrollView {
                        id: video_Capture_property_Child
                        x:10
                        y:35
                        width: 257
                        height: 160
                        visible: false
                        
                        style: ScrollViewStyle {
                            scrollToClickedPosition: true
                            handle: Image {
                                id: vidCapScrollHandle
                                source: "images/scroller.png"
                            }

                            scrollBarBackground: Image {
                                id: vidCapScrollStyle
                                source: "images/Scroller_bg.png"
                            }

                            incrementControl: Image {
                                id: vidCapIncrement
                                source: "images/down_arrow.png"
                            }

                            decrementControl: Image {
                                id: vidCapDecrement
                                source: "images/up_arrow.png"
                            }
                        }

                        Item {
                            height: video_location.y + 85

                            //-------------------grid网格1列-----------
                            GridLayout {
                                id: videoCapturePropertyGrid
                                columns: 1

                                //-----------frame rate-------------------
                                Text {
                                    id: frame_rate
                                    text: "Frame Rate"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                ComboBox {
                                    id: frame_rate_box
                                    opacity: 1
                                    model: fpsAvailable
                                    currentIndex: videoPinFrameInterval
                                    textRole: "display"
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: frameRateBox
                                            source: "images/device_box.png"
                                            Rectangle {
                                                width: frameRateBox.sourceSize.width - 28
                                                height: frameRateBox.sourceSize.height
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label:  Text{
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            text: control.currentText
                                            elide: Text.ElideRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        if(frameRateBox) {                                            
                                            videoPinFrameInterval = currentIndex
                                            updateScenePreview(output_size_box_Video.currentText.toString(), color_comp_box_VideoPin.currentIndex.toString(),currentIndex)
                                        }
                                    }
                                    Component.onCompleted: {
                                        frameRateBox = true
                                    }
                                    MouseArea {
                                        id: mouseArea_fps
                                        anchors.fill: parent
                                        onPressed: {
                                            mouse.accepted = false
                                        }
                                        onWheel: {
                                        }
                                    }

                                }

                                //-----------color_comp-------------------
                                Text {
                                    id: color_comp
                                    text: "Color Space/Compression"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                ComboBox {
                                    id: color_comp_box_VideoPin
                                    opacity: 1
                                    textRole: "display"
                                    model: resolutionModel
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: colorSpace
                                            source: "images/device_box.png"
                                            Rectangle {
                                                width: colorSpace.sourceSize.width - 28
                                                height: colorSpace.sourceSize.height
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label: Text {
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            elide: Text.ElideRight
                                            text: control.currentText
                                            maximumLineCount: 1
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        if(colorSpace) {                                            
                                            vidFormatChanged = true
                                            JS.videoCaptureFormat = color_comp_box_VideoPin.currentIndex.toString()                                            
                                            updateScenePreview(vidstreamproperty.width.toString() +"x"+vidstreamproperty.height.toString(), color_comp_box_VideoPin.currentIndex.toString(),frame_rate_box.currentIndex)
                                            vidstreamproperty.displayVideoResolution()
                                            updateFPS(currentText.toString(), output_size_box_Video.currentText.toString())
                                            vidFormatChanged = false
                                        }
                                    }
                                    Component.onCompleted: {
                                        colorSpace = true
                                    }

                                    MouseArea {
                                        id: mouseArea_colorSpace
                                        anchors.fill: parent
                                        onPressed: {
                                            mouse.accepted = false
                                        }
                                        onWheel: {
                                        }
                                    }
                                }

                                //-----------Output Size-------------------
                                Text {
                                    id: output_size_Video
                                    text: "Output Size"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                ComboBox {
                                    id: output_size_box_Video
                                    opacity: 1
                                    model: videoOutputFormatModel
                                    textRole: "display"
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: resolutionSizeVideo
                                            source: "images/device_box.png"
                                            Rectangle {
                                                width: resolutionSizeVideo.sourceSize.width - 28
                                                height: resolutionSizeVideo.sourceSize.height
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label: Text {
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            text: control.currentText
                                            elide: Text.ElideRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }                                    
                                    onCurrentIndexChanged: {                                        
                                        JS.videoCaptureResolution = output_size_box_Video.currentText.toString();
                                        if(outputSizeBox) {
                                            updateFPS(color_comp_box_VideoPin.currentText.toString(), currentText.toString())
                                            updateScenePreview(output_size_box_Video.currentText.toString(), color_comp_box_VideoPin.currentIndex.toString(),frame_rate_box.currentIndex)
                                        }                                        
                                    }
                                    Component.onCompleted: {
                                        outputSizeBox = true
                                    }
                                    MouseArea {
                                        id: mouseArea_outputSize
                                        anchors.fill: parent
                                        onPressed: {
                                            mouse.accepted = false
                                        }
                                        onWheel: {
                                        }
                                    }
                                }

                                //-----------Video record format-------------------
                                Text {
                                    id: extension
                                    text: "Video record format"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                ComboBox {
                                    id: fileExtensions
                                    opacity: 1
                                    model: ListModel {
                                        id: extensionModel
                                        ListElement { text: "avi"  }
                                        ListElement { text: "mkv"  }
                                    }

                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: fileExtension
                                            source: "images/device_box.png"
                                            Rectangle {
                                                width: fileExtension.sourceSize.width - 28
                                                height: fileExtension.sourceSize.height
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label: Text {
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            text: control.currentText
                                            elide: Text.ElideRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        JS.videoExtension = fileExtensions.currentText
                                    }
                                }

                                //-----------Video Encoder format-------------------
                                Text {
                                    id: encoder
                                    text: "Video Encoder format"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                ComboBox {
                                    id: fileEncoder
                                    opacity: 1
                                    model: ListModel {
                                        ListElement { text: "YUY"  }
                                        ListElement { text: "MJPG" }
                                        ListElement { text: "H264" }
                                        ListElement { text: "VP8" }
                                    }
                                    activeFocusOnPress: true
                                    style: ComboBoxStyle {
                                        background: Image {
                                            id: fileEncoderImage
                                            source: "images/device_box.png"
                                            Rectangle {
                                                width: fileEncoderImage.sourceSize.width - 28
                                                height: fileEncoderImage.sourceSize.height
                                                color: "#222021"
                                                border.color: "white"
                                                border.width: control.activeFocus ? 3 : 1
                                                radius: control.activeFocus ? 5 : 0
                                            }
                                        }
                                        label: Text {
                                            anchors.fill: parent
                                            color: "#ffffff"
                                            text: control.currentText
                                            elide: Text.ElideRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Ubuntu"
                                            font.pixelSize: 14
                                        }
                                    }
                                    onCurrentIndexChanged: {
                                        JS.videoEncoder = fileEncoder.currentIndex
                                    }
                                }

                                //-----------Video Location-------------------
                                Text {
                                    id: video_location
                                    text: "Video Location"
                                    font.pixelSize: 14
                                    font.family: "Ubuntu"
                                    color: "#ffffff"
                                    smooth: true
                                    opacity: 1
                                }

                                Row {
                                    Button {
                                        id: video_box
                                        width: 230
                                        opacity: 1
                                        activeFocusOnPress: true
                                        action: videoLocation
                                        tooltip:""
                                        style: ButtonStyle {
                                            background: Image {
                                                id: videoLoc
                                                horizontalAlignment: Image.AlignHCenter
                                                verticalAlignment: Image.AlignVCenter
                                                fillMode: Image.PreserveAspectFit
                                                source: "images/still_box.png"
                                                Rectangle {
                                                    width: videoLoc.sourceSize.width + 14
                                                    height: videoLoc.sourceSize.height
                                                    border.width: control.activeFocus ? 3 : 1
                                                    color: "#222021"
                                                    border.color: "#ffffff"
                                                }
                                            }
                                        }
                                        Text {
                                            id: storage_pathVideo
                                            text: SystemVideoFolder
                                            elide: Text.ElideLeft
                                            font.pixelSize: 14
                                            font.family: "Ubuntu"
                                            color: "#ffffff"
                                            smooth: true
                                            x: 4
                                            y: 4
                                            width: 195
                                            opacity: 1
                                        }
                                        Image {
                                            id: open_folderVideo
                                            source: "images/open_folder.png"
                                            x: 205
                                            y: 6
                                            opacity: 1
                                        }
                                    }
                                    FileDialog {
                                        id: fileDialogVideo
                                        selectFolder: true
                                        title: qsTr("Select a folder")
                                        onAccepted: {
                                            storage_pathVideo.text = folder.toString().replace("file://", "")
                                            videoStoragePath = storage_pathVideo.text
                                        }
                                    }
                                }//-----------Video Location end-------------------
                            }//-------------------grid网格1列结束-----------
                        }//item结束
                    }//滚动条结束

                    Keys.onReturnPressed: {
                        videoCapProperty()
                    }
                    Keys.onSpacePressed: {

                    }
                    onFocusChanged: {
                        video_Capture_property_Child.visible = false
                    }

                } //button结束
            } //item 结束


            //又一个item视频渲染
            Item{
                id:videoRenderer
                Text {
                    x: 20
                    y: about.y - 50
                    id: average_frame
                    text: "Current frame rate achieved"
                    font.pixelSize: 14
                    font.family: "Ubuntu"
                    color: "#ffffff"
                    smooth: true
                    opacity: 1
                    width: 150
                    wrapMode: Text.WordWrap
                }

                TextField {
                    id: average_frame_value
                    x: average_frame.x + 150
                    y: about.y - 50
                    text: "0"
                    font.pixelSize: 14
                    font.family: "Ubuntu"
                    textColor: "#ffffff"
                    horizontalAlignment: TextInput.AlignHCenter
                    enabled: false
                    smooth: true
                    opacity: 1
                    style: TextFieldStyle {
                        textColor: "black"
                        background: Rectangle {
                            implicitWidth: 70
                            implicitHeight: 24
                            color: "#222021"
                            border.color: "#ffffff"
                            border.width: 1
                        }
                    }
                }
            }//视频渲染配置item结束
        //-----------------columnlayout结束------------------
        }

        //uvc摄像头设置
        Button {
            id: uvc_settings
            smooth: true
            focus: false
            activeFocusOnPress: true
            tooltip: "Extension Settings - Its a special settings available for the individual camera"
            style: ButtonStyle {
                background: Image {
                    source: (!cameraColumnLayout.visible || control.activeFocus) ? "images/toggle_selection.png" : ""
                }
                label: Text {
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    text: qsTr("Extension Settings")
                    font.pixelSize: 14
                    font.family: "Ubuntu"
                    color: "#ffffff"
                }
            }
            x: cameraColumnLayout.visible ? 134 : 130
            y: cameraColumnLayout.visible ? 153 : 149
            opacity: 1
            onFocusChanged: {
                if(activeFocus)
                    extensionTab()
            }
        }

        //自定义组件econSlider
        Component {
            id: econSliderStyle
            SliderStyle {
                groove:Row {
                    spacing: 0
                    y: 3
                    Rectangle {
                        width: styleData.handlePosition
                        height: 4
                        color: "#dc6239"
                        radius: 5
                    }
                    Rectangle {
                        width: control.width - styleData.handlePosition
                        height: 4
                        color: "#dddddd"
                        radius: 5
                    }
                }
                handle: Image {
                    source: "images/handle.png"
                    opacity: 1
                }
            }
        }

        //自定义组件econTextFieldStyle
        Component {
            id: econTextFieldStyle
            TextFieldStyle {
                textColor: "black"                
                background: Rectangle {
                    radius: 2
                    implicitWidth: 50
                    implicitHeight: 20
                    border.color: "#333"
                    border.width: 2
                    y: 1                    
                }
            }
        }

        //自定义组件
        Component {
            id: tabButtonStyle
            ButtonStyle {
                background: Image {
                    source: cameraColumnLayout.visible ? "images/toggle_selection.png" : ""
                }
                label: Text {
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    text: qsTr("Camera Settings")
                    font.pixelSize: 14
                    font.family: "Ubuntu"
                    color: "#ffffff"
                }
            }
        }

        //自定义组件
        Component {
            id: tabSkipButtonStyle
            ButtonStyle {
                background: Image {
                    source: ""
                }
                label: Text {
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    text: qsTr("Camera Settings")
                    font.pixelSize: 14
                    font.family: "Ubuntu"
                    color: "#ffffff"
                }
            }
        }

        //左边栏收缩关闭
        Image {
            id: close_sideBar
            source: "images/close_tab.png"
            anchors.bottom: side_bar_bg.bottom
            anchors.bottomMargin: 50
            anchors.right: side_bar_bg.right
            anchors.rightMargin: -28
            y: side_bar_bg.height/2 + 20
            opacity: 1
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    close_sideBar.opacity = 1
                }
                onExited: {
                    close_sideBar.opacity = 1
                }

                onReleased: {
                    if(!cameraColumnLayout.visible)
                        selectCameraSettings()
                    sideBarItems.visible = false
                    open_sideBar.visible = true
                    //previewer.x = 0
                }
            }
        }

        //about 按钮
        Button {
            id: about
            x: 20
            y: statusbar.y - 30
            opacity: 1
            action: aboutAction
            activeFocusOnPress : true

            focus: true
            //text : "about"

            style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 1 :0
                    color: "#222021"
                    border.color: control.activeFocus ? "#ffffff" : "#222021"
                }
                label: Image {
                    source: "images/about.png"
                }
            }

            Keys.onReturnPressed:  {
            	console.log("about button return pressed");
                aboutWindow.show();
            }

            //onClicked: {
            //	console.log("about button clicked");
            //}
        }

        //exit 按钮
        Button {
            id: exit
            x: 192
            y: statusbar.y - 30
            opacity: 1
            action: exitAction
            activeFocusOnPress : true
            style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 1 :0
                    color: "#222021"
                    border.color: control.activeFocus ? "#ffffff" : "#222021"
                }
                label: Image {
                    source: "images/exit.png"
                }
            }
            Keys.onReturnPressed: {
                exitDialog.visible = true
            }
        }
    }//左边栏结束

    //最底下的状态栏
    StatusBar {
        id: statusbar
        anchors.bottom: parent.bottom
        Row {
            Label {
                id: statusbartext
                color: "#ffffff"
                text: statusText;
            }
        }
        style: StatusBarStyle {
            background: Rectangle {
                implicitHeight: 16
                implicitWidth: 200
                color: "#222021"
                border.width: 1
            }
        }
    }

    //窗口画好后的动作，加载about窗口
    Component.onCompleted: {
        //setOpacityFalse()
        //camproperty.createLogger()
        camera_btn.forceActiveFocus()
        var component2 = Qt.createComponent("about.qml")
        aboutWindow = component2.createObject(root);
    }

    //窗口退出时的动作
    Component.onDestruction: {
    	console.log("Component  Destruct")
        exitDialog.visible = false
    }

    //键盘事件
    Keys.onLeftPressed: {
        //if(!cameraColumnLayout.visible)
        //    selectCameraSettings()
        sideBarItems.visible = false
        open_sideBar.visible = true
    }

    Keys.onRightPressed: {
        sideBarItems.visible = true
        open_sideBar.visible = false
   }
/*
    Keys.onLeftPressed: {
    	statusbartext.color="red";
    }

    Keys.onReturnPressed:  {
    	console.log("return pressed");
        aboutWindow.show();
    }


    Keys.onRightPressed: {
    	statusbartext.color="blue";
    }

    Keys.onUpPressed: {
    	statusbartext.color="yellow";
    }

    Keys.onDownPressed: {
    	statusbartext.color="black";
    }

    Keys.onEscapePressed: {
    	console.log("quit now?")
    	Qt.quit(); 
    }

    Keys.onPressed: {
    	switch(event.key){
    		case Qt.Key_Plus:
    			console.log("key plus")
    			break;
    		case Qt.Key_Minus:
    			console.log("key minus")
    			break;

            case Qt.Key_Left:
                console.log("key left")
                break;

            case Qt.Key_a:
                console.log("key a")
                break;

            case Qt.Key_0:
                console.log("key a")
                break;

    		//default:
    		//	return;
    	}

    	//event.accepted = true
    }

    KeyNavigation.tab: statusbartext
*/

    //鼠标事件
/*
    MouseArea {
        anchors.fill: parent;  
        acceptedButtons: Qt.LeftButton | Qt.RightButton;  
        onClicked: {  
            if(mouse.button == Qt.RightButton){
            	console.log("RightButton")
                Qt.quit();  
            }
            else if(mouse.button == Qt.LeftButton){
                color = Qt.rgba((mouse.x % 255) / 255.0 , (mouse.y % 255) / 255.0, 0.6, 1.0);
                console.log("LeftButton-"+sideBarItems.width+"-"+side_bar_bg.width)
            }
        }  
        onDoubleClicked: {  
            color = "gray";  
        }  
    }
*/
}
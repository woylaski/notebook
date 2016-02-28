import QtQuick 1.1

Rectangle {
    id: button

    property alias mainText: buttonMainText.text
    property alias altText: buttonAltText.text

    width: 57
    height: 57
    color: "#CCC"
    clip: true

    Rectangle {
        id: rotatedBackground
        rotation: -45
        anchors.fill: parent
        anchors.margins: -13
        gradient: Gradient {
            GradientStop {position: 0; color: "#808080"}
            GradientStop {position: 1; color: "#414141"}
        }
    }

    Text {
        id: buttonMainText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 22
        styleColor: "#161D20"
        style: Text.Sunken
        text: "A"
    }
    Text {
        id: buttonAltText
        anchors {
            right: parent.right
            top: parent.top
            margins: 3
        }
        styleColor: "#161D20"
        style: Text.Sunken
        font.pixelSize: 10
        color: "white"
    }

//    border {
//        width: 1
//        color: "#07ffffff"
//    }

}

 //CharacterShadowColor = QColor(0x16, 0x1D, 0x20);

//    const QColor startCol     = QColor("#808080");
//    const QColor endCol       = QColor("#414141");

//    b->setBackgroundGradient(Btn::ButtonUp | Btn::ButtonDisabled, startCol, endCol);
//    b->setBackgroundGradient(Btn::ButtonPressed, endCol, startCol);

//    const QColor borderUpCol         = withAlpha(QColor("#ffffff"), 0.03);
//    const QColor borderPressedCol    = withAlpha(QColor("#ffffff"), 0.04);
//    b->setBorder(Btn::ButtonUp | Btn::ButtonDisabled, borderUpCol);
//    b->setTopBorder(Btn::ButtonUp | Btn::ButtonDisabled, withAlpha(QColor("#ffffff"), 0.13));
//    b->setBorder(Btn::ButtonPressed, borderPressedCol);
//    b->setBottomBorder(Btn::ButtonPressed, withAlpha(QColor("#ffffff"), 0.05));
//    b->setBackgroundGradient(Btn::ButtonUp | Btn::ButtonDisabled, startCol, endCol);
//    b->setBackgroundGradient(Btn::ButtonPressed, endCol, startCol);

//    const int Factor = 180;
//    const int CharacterFontSize = 22;
//    const int SuperScriptFontSize = 10;

//    const QColor CharacterShadowColor       = QColor(0x16, 0x1D, 0x20);
//    const QColor SuperScriptShadowColor     = QColor(0x4b,0x4b,0x4b);

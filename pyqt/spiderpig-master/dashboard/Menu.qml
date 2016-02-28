import QtQuick 1.0

MouseArea {

    property int themeColorIndex: 0
    property color selectedColor: themeColors()[themeColorIndex]

    function themeColors() {
        // theme colors from metro design guidelines:

        var list = ["#73c330", // custom green
                    "#e51400", // red
                    "#339933", // green
                    "#1ba1e2", // blue
                    "#f09609", // orange
                    "#8cbf26", // lime
                    "#00aba9", // teal
                    "#fe0097", // purple
                    "#e671b8", // magenta
                    "#996600", // brown
                    "#a200ff", // purple
            ];
        return list;
    }
        // backgrounds (old stuff, dont know why values are different):
        // 00afdb //blue
        // d21242 //red
        // ffc425 //yellow
        // 00b25a //green
        // f47836 //orange
        // 7d4199 //pink

    id: themeColorCaroussel
    anchors.fill: parent
    onClicked: {
        if (themeColorIndex < themeColors().length - 1)
            themeColorIndex++;
        else
            themeColorIndex = 0;
    }

}

import QtQuick 2.5
pragma Singleton

QtObject {
    id: colorsGroup
    property var colorVars:{
        // Color swatches
        "alizarin"      : "#e74c3c",
        "amethyst"      : "#9b59b6",
        "asbestos"      : "#7f8c8d",
        "belizeHole"    : "#2980b9",
        "carrot"        : "#e67e22",
        "clouds"        : "#ecf0f1",
        "concrete"      : "#95a5a6",
        "emerald"       : "#2ecc71",
        "greenSea"      : "#16a085",
        "midnightBlue"  : "#2c3e50",
        "nephritis"     : "#27ae60",
        "orange"        : "#f39c12",
        "peterRiver"    : "#3498db",
        "pomegranate"   : "#c0392b",
        "pumpkin"       : "#d35400",
        "silver"        : "#bdc3c7",
        "sunFlower"     : "#f1c40f",
        "turquoise"     : "#1abc9c",
        "wetAsphalt"    : "#34495e",
        "wisteria"      : "#8e44ad",
        "strongCyan"    : "#20C09C"
    }

    // Grays
    property string gray       : colorVars["concrete"]
    property string gray_light : colorVars["silver"]
    property string inverse    : "white"

    // Brand colors
    property string primary   : colorVars["wetAsphalt"]
    property string secondary : colorVars["turquoise"]
    property string success   : colorVars["emerald"]
    property string warning   : colorVars["sunFlower"]
    property string danger    : colorVars["alizarin"]
    property string info      : colorVars["peterRiver"]

    // Settings for some of the most global styles.
    property string body_bg    : "#ffffff"
    property string text_color : primary

    // Global textual link color.
    property string link_color       : colorsGroup.colorVars["greenSea"]
    property string link_hover_color : colorVars["turquoise"]
}


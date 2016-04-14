import QtQuick 2.5

Item {
    id: paletteLoader

    property string name: "qrc:/qml/ManuBase"
    property alias palette: loader.item

    Loader {
        id: loader
        source: "qrc:/qml/Manu" + name + "Palette.qml"
    }
}


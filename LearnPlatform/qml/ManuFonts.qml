import QtQuick 2.0

Item {
    // Editor Fonts

    property ListModel editorFonts: ListModel {
        ListElement {
            name: "Ubuntu Mono"
            source: "../../resources/fonts/editor/ubuntumono.ttf"
        }

        ListElement {
            name: "DejaVu Sans Mono"
            source: "../../resources/fonts/editor/dejavusansmono.ttf"
        }

        ListElement {
            name: "Liberation Mono"
            source: "../../resources/fonts/editor/liberationmono.ttf"
        }

        ListElement {
            name: "Droid Sans Mono"
            source: "../../resources/fonts/editor/droidsansmono.ttf"
        }

        ListElement {
            name: "Fira Mono"
            source: "../../resources/fonts/editor/firamono.ttf"
        }

        ListElement {
            name: "Source Code Pro"
            source: "../../resources/fonts/editor/sourcecodepro.ttf"
        }

        function getCurrentIndex() {
            for (var i = 0; i < count; i++)
            {
                if (get(i).name === settings.font)
                    return i;
            }

            return -1;
        }
    }

    Repeater {
        model: editorFonts
        delegate: Loader {
            sourceComponent: FontLoader {
                source: model.source
            }
        }
    }

    // UI Fonts

    FontLoader {
        source: "../../resources/fonts/ui/robotoregular.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotoitalic.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotobold.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotobolditalic.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/fontawesome.ttf"
    }
}


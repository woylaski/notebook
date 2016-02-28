import qbs 1.0;

Project {
    name: "The DocBook5 Editor";

    Product {
        name: "app-docbook5-editor";
        type: "application";
        targetName: "DocBookEditor";

        Depends { name: "cpp"; }
        Depends {
            name: "Qt";
            submodules: ["core", "concurrent", "gui", "qml", "quick"];
        }
        Group {
            name: "C++ headers";
            files: [];
        }
        Group {
            name: "C++ sources";
            files: [
                "main.cpp",
            ]
        }
        Group {
            name: "JavaScript modules";
            files: [];
        }
        Group {
            name: "QML components";
            files: [
                "ui.qml",
                "AbstractElement.qml",
                "Attribute.qml",
                "BlockElement.qml",
                "ContentData.qml",
                "InlineElement.qml",
                "ScrollableArea.qml",
            ]
        }
        Group {
            name: "Qt resources bundles";
            files: [
                "components.qrc",
            ]
        }
    }
}

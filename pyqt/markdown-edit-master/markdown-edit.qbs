import qbs 1.0;

Project {
    name: "The MarkDown Editor";

    Product {
        name: "app-markdown-edit";
        type: "application";
        targetName: "MarkDownEdit";

        Depends { name: "cpp"; }
        Depends {
            name: "Qt";
            submodules: ["core", "gui", "network", "qml", "quick"];
        }
        Group {
            name: "C++ sources & headers";
            files: [
                "main.cpp",
                "TextFileHelper.h",
                "TextFileHelper.cpp"
            ]
        }
        Group {
            name: "JavaScript modules";
            files: [
                "markdown-core.js"
            ];
        }
        Group {
            name: "QML components";
            files: [
                "ui.qml",
                "DialogFile.qml"
            ]
        }
        Group {
            name: "CSS stylesheets";
            files: [
                "style-default.css"
            ];
        }
        Group {
            name: "Qt resources bundles";
            files: [
                "data.qrc"
            ];
        }
        Group {
            name: "Documents";
            files: [
                "syntax.markdown",
                "example.md"
            ];
        }
    }
}


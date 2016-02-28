import qbs;

Project {
    name: "The Qt Web-browser";

    Product {
        type: "application";
        name: "app-qt-webbrowser";
        targetName: "QtWebBrowser";

        Depends { name: "cpp"; }
        Depends {
            name: "Qt";
            submodules: [
                "core",
                "gui",
                "network",
                "qml",
                "quick",
                "core-private",
                "gui-private",
                "quick-private",
                "webengine"];
        }
        Group {
            name: "C++ sources";
            files: ["main.cpp"];
        }
        Group {
            name: "C++ headers";
            files: [];
        }
        Group {
            name: "QML documents";
            files: [
                "ui.qml",
            ]
        }
        Group {
            name: "Qt resource bundles";
            files: [
                "components.qrc",
                "data.qrc",
            ]
        }
        Group {
            name: "Images & icons";
            files: [];
        }
        Group {     // Properties for the produced executable
            fileTagsFilter: product.type
            qbs.install: true
        }
    }
}


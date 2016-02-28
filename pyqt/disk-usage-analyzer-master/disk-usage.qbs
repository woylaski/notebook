import qbs 1.0;

Project {
    name: "The Disk Usage graph utility";

    Product {
        name: "app-disk-usage";
        type: "application";
        targetName: "DiskUsage";

        Depends { name: "cpp"; }
        Depends {
            name: "Qt";
            submodules: ["core", "concurrent", "gui", "qml", "quick"];
        }
        Group {
            name: "C++ headers";
            files: [
                "MyFileSystemWalker.h",
            ]
        }
        Group {
            name: "C++ sources";
            files: [
                "main.cpp",
                "MyFileSystemWalker.cpp",
            ]
        }
        Group {
            name: "JavaScript modules";
            files: [

            ];
        }
        Group {
            name: "QML components";
            files: [
                "ui.qml",
            ]
        }
        Group {
            name: "Qt resources bundles";
            files: [
                "components.qrc",
                "data.qrc",
            ]
        }
    }
}

import qbs;

Project {
    name: "Video Gallery";

    Application {
        name: "app-video-gallery";

        Depends {
            name: "cpp";
        }
        Depends {
            name: "Qt";
            submodules: ["core", "concurrent", "gui", "network", "multimedia", "qml", "quick"];
        }
        Group {
            name: "C++ Sources";
            prefix: "**/";
            files: [
                "*.c",
                "*.cc",
                "*.cxx",
                "*.cpp",
            ];
        }
        Group {
            name: "C++ Headers";
            prefix: "**/";
            files: [
                "*.h",
                "*.hh",
                "*.hxx",
                "*.hpp",
            ];
        }
        Group {
            name: "Resources Bundles";
            prefix: "**/";
            files: [
                "*.rc",
                "*.qrc",
            ];
        }
        Group {
            name: "QML Documents";
            prefix: "**/";
            files: [
                "*.qml",
            ]
        }
        Group {
            name: "JavaScript Modules";
            prefix: "**/";
            files: [
                "*.js",
            ];
        }
        Group {
            name: "Images";
            prefix: "**/";
            files: [
                "*.png",
                "*.svg",
            ];
        }
    }
}

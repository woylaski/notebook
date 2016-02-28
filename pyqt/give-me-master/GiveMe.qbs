import qbs;

Project {
    name: "Give'me";
    references: [
        "libQtQmlTricks/NiceModels/QtQmlModels.qbs",
        "libQtQmlTricks/SuperMacros/QtSuperMacros.qbs",
        "libQtQmlTricks/UiElements/QtQuickUiElements.qbs",
    ]

    Product {
        name: "app-giveme";
        type: "application";
        cpp.rpaths: ["$ORIGIN"];

        Depends {
            name: "cpp";
        }
        Depends {
            name: "Qt";
            submodules: ["core", "network", "gui", "qml", "quick"];
        }
        Depends {
            name: "libqtqmltricks-qtqmlmodels";
        }
        Depends {
            name: "libqtqmltricks-qtsupermacros";
        }
        Depends {
            name: "libqtqmltricks-qtquickuielements";
        }
        Group {
            name: "C++ sources";
            files: [
                "main.cpp",
                "SharedObject.cpp",
            ]
        }
        Group {
            name: "C++ headers";
            files: [
                "SharedObject.h",
            ]
        }
        Group {
            name: "QML components";
            files: [
                "GiveMe.qml",
                "ui_generic.qml",
                "ui_silica.qml",
            ]
        }
        Group {
            name: "Qt resources bundles";
            files: [
                "data.qrc",
            ]
        }
        Group {
            qbs.install: true;
            fileTagsFilter: product.type;
        }
    }
}

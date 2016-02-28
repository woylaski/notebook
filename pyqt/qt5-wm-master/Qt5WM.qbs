import qbs;
import qbs.Probes as Prober;

Project {
    name: "The Qt5 Window Manager";

    Product {
        name: "app-qt5wm";
        type: "application";
        cpp.cxxFlags: pkgWL.cflags;
        cpp.linkerFlags: pkgWL.libs;
        cpp.includePaths: sourceDirectory;

        Prober.PkgConfigProbe {
            id: pkgWL;
            name: "wayland-server";
            minVersion: '1.5';
            maxVersion: '1.99';
        }
        Depends {
            name: "cpp";
        }
        Depends {
            name: "Qt";
            submodules: ["core", "gui", "qml", "quick"];
        }
        Group {
            name: "C++ sources";
            files: [
                "Qt5WaylandClientWrapper.cpp",
                "Qt5WaylandServerFacade.cpp",
                "main.cpp",
                "xdg-shell-server-protocol.c",
            ]
        }
        Group {
            name: "C++ headers";
            files: [
                "Qt5WaylandClientWrapper.h",
                "Qt5WaylandServerFacade.h",
                "defs.h",
                "xdg-shell-server-protocol.h",
            ]
        }
        Group {
            name: "QML components";
            files: [
                "ui.qml",
            ]
        }
        Group {
            name: "Images";
            files: [
                "data/background.jpg",
                "data/closebutton.png",
            ]
        }
        Group {
            name: "Qt resources bundles";
            files: [
                "components.qrc",
                "data.qrc",
            ]
        }
        Group {
            name: "XML protocols";
            files: [
                "xdg-shell.xml",
            ]
        }
        Group {
            fileTagsFilter: product.type;
            qbs.install: true;
        }
    }
}


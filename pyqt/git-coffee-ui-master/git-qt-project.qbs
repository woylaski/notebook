import qbs;

Project {
    id: proj;
    name: "The Qt Git UI Tools";
    references: [
        "./libQtQmlTricks/UiElements/QtQuickUiElements.qbs",
        "./libQtQmlTricks/SuperMacros/QtSuperMacros.qbs",
        "./libQtQmlTricks/SmartDataModels/QtQmlModels.qbs",
    ];

    readonly property string libGit2Path   : "./libgit2"; // put the whole lib source dir here
    readonly property string libQt5GitPath : "./libqt5git";

    Application {
        name: "qt-git-ui-exec";
        targetName: "qt-git-ui";
        cpp.optimization: "fast";
        cpp.debugInformation: true;
        cpp.libraryPaths: [
            (proj.libGit2Path + "/build"),
        ];
        cpp.includePaths: [
            (proj.libGit2Path + "/include"),
            (proj.libQt5GitPath),
        ];
        cpp.dynamicLibraries: ["git2"];

        Depends {
            name: "cpp";
        }
        Depends {
            name: "Qt";
            submodules: ["core", "gui", "network", "qml", "quick", "svg"];
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
            name: "Resources Bundles";
            files: [
                "components.qrc",
                "data.qrc",
            ]
        }
        Group {
            name: "QML Documents & Components";
            files: [
                "pages/DelegateDeltaHunkEntry.qml",
                "pages/DelegateDeltaLineEntry.qml",
                "pages/DialogSelectRepo.qml",
                "pages/PageRepository.qml",
                "pages/PageWelcome.qml",
                "pages/SubPageCommitLogAndGraph.qml",
                "pages/SubPageConfiguration.qml",
                "pages/SubPageGeneralRepositoryInfo.qml",
                "pages/SubPageRemotesAndBranches.qml",
                "pages/SubPageWorkingDirectoryStatus.qml",
                "ui.qml",
            ]
        }
        Group {
            name: "C/C++ Sources";
            files: [
                "SharedObject.cpp",
                "libqt5git/QtGitBranchEntry.cpp",
                "libqt5git/QtGitCommitEntry.cpp",
                "libqt5git/QtGitDeltaEntry.cpp",
                "libqt5git/QtGitDiffObject.cpp",
                "libqt5git/QtGitHunkEntry.cpp",
                "libqt5git/QtGitLineEntry.cpp",
                "libqt5git/QtGitRemoteEntry.cpp",
                "libqt5git/QtGitRepository.cpp",
                "libqt5git/QtGitStatusEntry.cpp",
                "libqt5git/QtGitTagEntry.cpp",
                "main.cpp",
            ]
        }
        Group {
            name: "C/C++ Headers";
            files: [
                "SharedObject.h",
                "libqt5git/QtGitBranchEntry.h",
                "libqt5git/QtGitCommitEntry.h",
                "libqt5git/QtGitDeltaEntry.h",
                "libqt5git/QtGitDiffObject.h",
                "libqt5git/QtGitHunkEntry.h",
                "libqt5git/QtGitLineEntry.h",
                "libqt5git/QtGitRemoteEntry.h",
                "libqt5git/QtGitRepository.h",
                "libqt5git/QtGitStatusEntry.h",
                "libqt5git/QtGitTagEntry.h",
            ]
        }
        Group {
            name: "Images & Icons";
            files: [
                "icons/add.svg",
                "icons/apply.svg",
                "icons/clear.svg",
                "icons/close.svg",
                "icons/copy.svg",
                "icons/cut.svg",
                "icons/delete.svg",
                "icons/disk.svg",
                "icons/edit.svg",
                "icons/export.svg",
                "icons/file.svg",
                "icons/folder.svg",
                "icons/help.svg",
                "icons/home.svg",
                "icons/import.svg",
                "icons/info.svg",
                "icons/mark.svg",
                "icons/open.svg",
                "icons/paste.svg",
                "icons/refresh.svg",
                "icons/remove.svg",
                "icons/repos.svg",
                "icons/revert.svg",
                "icons/save.svg",
                "icons/select.svg",
                "icons/stop.svg",
                "icons/system.svg",
                "icons/warn.svg",
                "img/logo@2x.png",
                "img/logo_libgit2.png",
            ]
        }
        Group {
            name: "Various Files";
            files: [
                ".gitignore",
                "prepare_libgit2.sh",
                "todolist.md",
            ];
        }
        Group {
            name: "Libraries";
            files: {
                if (qbs.targetOS.contains ("linux")) {
                    return [proj.libGit2Path + "/build/*.so*"];
                }
                else {
                    return [];
                }
            }
            qbs.install: true;
        }
        Group {
            fileTagsFilter: "application";
            qbs.install: true;
        }
    }
}

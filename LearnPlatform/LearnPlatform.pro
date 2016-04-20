TEMPLATE = app

QT += \
    core gui qml quick \
    multimedia sql \
    network websockets \
    xml svg printsupport \
    sensors bluetooth nfc \
    positioning location \
    3dcore 3drenderer 3dinput 3dquick

TRANSLATIONS = resources/translations/qmlcreator_ru.ts

SOURCES += main.cpp \
    src/fileio/fileio.cpp \
    src/livereload/livereload.cpp \
    src/component/component.cpp \
    src/filefs/filefs.cpp \
    src/tricks/qqmlgadgetlistmodel.cpp \
    src/tricks/qqmlhelpers.cpp \
    src/tricks/qqmlobjectlistmodel.cpp \
    src/tricks/qqmlsvgiconhelper.cpp \
    src/tricks/qqmlvariantlistmodel.cpp \
    src/tricks/qquickpolygon.cpp \
    src/creator/MessageHandler.cpp \
    src/creator/ProjectManager.cpp \
    src/creator/QMLHighlighter.cpp \
    src/creator/SyntaxHighlighter.cpp \
    src/groupview/groupviewdroparea.cpp \
    src/groupview/groupviewhelper.cpp \
    src/groupview/groupviewproxy.cpp \
    src/groupview/groupview.cpp \
    src/groupview/instancemodel.cpp \
    src/database/database.cpp \
    src/database/lmslistmodel.cpp \
    src/printer/printer.cpp \
    src/print-ml/MiniPage.cpp \
    src/print-ml/PageSize.cpp \
    src/print-ml/Printer.cpp \
    src/print-ml/QuickItemPainter.cpp \
    src/print-ml/StyledText.cpp \
    src/diskusage/filesystemwalker.cpp \
    src/gbyzanz/controller.cpp \
    src/graphviz/ngraph.cpp \
    src/graphviz/ngraphapp.cpp \
    src/graphviz/ngraphmodel.cpp \
    src/graphviz/ngraphview.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/fileio/fileio.h \
    src/livereload/livereload.h \
    src/component/component.h \
    src/filefs/filefs.h \
    src/tricks/qqmlobjectlistmodel.h \
    src/tricks/qqmlsvgiconhelper.h \
    src/tricks/qqmlvariantlistmodel.h \
    src/tricks/qqmlvariantlistmodel_p.h \
    src/tricks/qquickpolygon.h \
    src/tricks/qtbitstream.h \
    src/tricks/qtcobs.h \
    src/tricks/qtjsonpath.h \
    src/creator/MessageHandler.h \
    src/creator/ProjectManager.h \
    src/creator/QMLHighlighter.h \
    src/creator/SyntaxHighlighter.h \
    src/groupview/groupviewdroparea.h \
    src/groupview/groupviewhelper.h \
    src/groupview/groupviewproxy.h \
    src/groupview/groupview.h \
    src/groupview/instancemodel.h \
    src/database/database.h \
    src/database/lmslistmodel.h \
    src/printer/printer.h \
    src/print-ml/MiniPage.h \
    src/print-ml/PageSize.h \
    src/print-ml/Printer.h \
    src/print-ml/QuickItemPainter.h \
    src/print-ml/StyledText.h \
    src/diskusage/filesystemwalker.h \
    src/gbyzanz/controller.h \
    src/graphviz/ngraph.h \
    src/graphviz/ngraphapp.h \
    src/graphviz/ngraphmodel.h \
    src/graphviz/ngraphview.h

DISTFILES += \
    music.db


TEMPLATE = app

QT += \
    core gui qml quick \
    multimedia sql \
    network websockets \
    xml svg \
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
    src/groupview/instancemodel.cpp

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
    src/groupview/instancemodel.h

DISTFILES +=


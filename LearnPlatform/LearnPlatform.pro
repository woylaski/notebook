TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    src/fileio/fileio.cpp \
    src/livereload/livereload.cpp \
    src/component/component.cpp \
    src/filefs/filefs.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/fileio/fileio.h \
    src/livereload/livereload.h \
    src/component/component.h \
    src/filefs/filefs.h


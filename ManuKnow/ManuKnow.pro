TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    src/manu_workenv.cpp \
    src/manu_filesystem.cpp \
    src/manu_stringutils.cpp \
    src/manu_plugins.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =
QML_IMPORT_PATH = $$PWD/

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/manu_workenv.h \
    src/manu_common.h \
    src/manu_filesystem.h \
    src/manu_stringutils.h \
    src/manu_plugins.h

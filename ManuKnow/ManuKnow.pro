TEMPLATE = app

QT += qml quick widgets
QT += core-private
QT += gui-private

CONFIG += c++11

SOURCES += main.cpp \
    src/manu_workenv.cpp \
    src/manu_filesystem.cpp \
    src/manu_stringutils.cpp \
    src/manu_plugins.cpp \
    src/manu_device.cpp \
    src/manu_units.cpp \
    src/manu_fileopendialog.cpp \
    src/manu_filesavedialog.cpp \
    src/manu_loadqmlfile.cpp

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
    src/manu_plugins.h \
    src/manu_device.h \
    src/manu_units.h \
    src/manu_fileopendialog.h \
    src/manu_filesavedialog.h \
    src/manu_loadqmlfile.h

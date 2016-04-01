TEMPLATE = app
TARGET=ppython

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    process_1.cpp \
    process.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    process.h

TEMPLATE = app

QT += qml quick widgets network multimedia

SOURCES += main.cpp \
    beziercurve.cpp \
    painteditem.cpp \
    textballoon.cpp \
    opencvface.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    elements/qmldir

HEADERS += \
    beziercurve.h \
    painteditem.h \
    textballoon.h \
    eventfilter.h


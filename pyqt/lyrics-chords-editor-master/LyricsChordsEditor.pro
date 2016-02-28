
QT += core gui network qml quick svg

TEMPLATE = app

TARGET = LyricsChordsEditor

INCLUDEPATH += \
    $$PWD/libQtQmlTricks/include

SOURCES += \
    $$PWD/SharedObject.cpp \
    $$PWD/main.cpp \
    $$PWD/libQtQmlTricks/src/qqmlhelpers.cpp \
    $$PWD/libQtQmlTricks/src/qqmlobjectlistmodel.cpp \
    $$PWD/libQtQmlTricks/src/qqmlsvgiconhelper.cpp \
    $$PWD/libQtQmlTricks/src/qqmlvariantlistmodel.cpp \
    $$PWD/libQtQmlTricks/src/qquickpolygon.cpp

HEADERS += \
    $$PWD/SharedObject.h \
    $$PWD/libQtQmlTricks/src/qqmlhelpers.h \
    $$PWD/libQtQmlTricks/src/qqmlmodels.h \
    $$PWD/libQtQmlTricks/src/qqmlobjectlistmodel.h \
    $$PWD/libQtQmlTricks/src/qqmlsvgiconhelper.h \
    $$PWD/libQtQmlTricks/src/qqmlvariantlistmodel_p.h \
    $$PWD/libQtQmlTricks/src/qqmlvariantlistmodel.h \
    $$PWD/libQtQmlTricks/src/qquickpolygon.h \
    $$PWD/libQtQmlTricks/src/qtcobs.h

RESOURCES += \
    $$PWD/data.qrc \
    components.qrc

QML_IMPORT_PATH += \
    $$PWD/libQtQmlTricks/import

linux:!android {
    target.path = /usr/bin
    INSTALLS += target
}

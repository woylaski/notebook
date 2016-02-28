
################## CONFIG ########################

TARGET       = GiveMe

TEMPLATE     = app

QT          += core network gui qml quick

MOC_DIR      = _moc
OBJECTS_DIR  = _obj
RCC_DIR      = _rcc


################## PACKAGING ########################

android {

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    DISTFILES += \
        $$PWD/android/AndroidManifest.xml \
        $$PWD/android/res/drawable-hdpi/icon.png \
        $$PWD/android/res/drawable-ldpi/icon.png \
        $$PWD/android/res/drawable-mdpi/icon.png \
        $$PWD/android/res/values/libs.xml

}
else {

    TARGET       = harbour-giveme

    INCLUDEPATH += /usr/include/sailfishapp

    CONFIG       += link_pkgconfig
    DEFINES      += Q_OS_SAILFISH
    PKGCONFIG    += sailfishapp

    OTHER_FILES  += \
        $$PWD/rpm/harbour-giveme.yaml \
        $$PWD/harbour-giveme.desktop \
        $$PWD/harbour-giveme.png \
        $$PWD/harbour-giveme.svg

    target.path   = /usr/bin
    desktop.files = $${TARGET}.desktop
    desktop.path  = /usr/share/applications
    icon.files    = $${TARGET}.png
    icon.path     = /usr/share/icons/hicolor/86x86/apps
    INSTALLS     += target desktop icon

}

################# SUB MODULE ########################

include ($$PWD/libQtQmlTricks/NiceModels/QtQmlModels.pri)
include ($$PWD/libQtQmlTricks/SuperMacros/QtSuperMacros.pri)
include ($$PWD/libQtQmlTricks/UiElements/QtQuickUiElements.pri)

################ FILES #########################

SOURCES += \
    main.cpp \
    SharedObject.cpp

HEADERS += \
    SharedObject.h

RESOURCES += \
    data.qrc

QMAKE_RESOURCE_FLAGS += -threshold 0 -no-compress


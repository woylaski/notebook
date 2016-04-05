#-------------------------------------------------
#
# Project created by QtCreator 2016-04-05T11:10:22
#
#-------------------------------------------------

QT       += core gui

TARGET = aplugin
TEMPLATE = lib
CONFIG += plugin

DESTDIR = $$[QT_INSTALL_PLUGINS]/generic

SOURCES += genericplugin.cpp

HEADERS += genericplugin.h
DISTFILES += aplugin.json

unix {
    target.path = /usr/lib
    INSTALLS += target
}

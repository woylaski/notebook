QT += core
QT -= gui

TARGET = TOpencv
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp

INCLUDEPATH += /usr/local/include
LIBS += `pkg-config opencv --cflags --libs`


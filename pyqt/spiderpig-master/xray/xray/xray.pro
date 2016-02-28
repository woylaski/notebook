#-------------------------------------------------
#
# Project created by QtCreator 2013-09-26T16:58:54
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = xray
TEMPLATE = app

SOURCES += \
    main.cpp \
    simulator.cpp \
    tsh.cpp \
    server.cpp \
    parser.cpp \
    logmodel.cpp \
    gui/messagebrowser.cpp \
    gui/logviewer.cpp \
    gui/mainwindow.cpp \
    gui/settings.cpp \
    gui/connectiondialog.cpp \
    codecproxy.cpp \
    recorder.cpp

HEADERS  += \
    simulator.h \
    tsh.h \
    server.h \
    parser.h \
    logmodel.h \
    gui/messagebrowser.h \
    gui/logviewer.h \
    gui/mainwindow.h \
    gui/settings.h \
    gui/connectiondialog.h \
    codecproxy.h \
    recorder.h

FORMS += \
    gui/messageList.ui \
    gui/logviewer.ui \
    gui/connectiondialog.ui \



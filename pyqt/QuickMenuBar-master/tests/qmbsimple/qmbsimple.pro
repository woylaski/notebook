
TEMPLATE    = app
TARGET      = qmbsimple
CONFIG      += qt warn_on thread c++11
LANGUAGE    = C++
QT          += core widgets gui qml quick quickwidgets
INCLUDEPATH +=
RESOURCES   +=  qmbsimple.qrc               \
                ../../src/QuickMenuBar.qrc

SOURCES     +=  qmbWindow.cpp

HEADERS     +=  qmbWindow.h

DISTFILES += qmbsimple.qml


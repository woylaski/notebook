# qjsCore.pro --- 
# 
# Author: Julien Wintz
# Created: lun. mars 24 23:49:43 2014 (+0100)
# Version: 
# Last-Updated: mar. mars 25 00:14:32 2014 (+0100)
#           By: Julien Wintz
#     Update #: 7
# 

# Change Log:
# 
# 

TEMPLATE = lib

include($$PWD/../../qjshell.pri)

HEADERS += $$PWD/qjsCoreColor.h
HEADERS += $$PWD/qjsCoreComint.h
HEADERS += $$PWD/qjsCoreEngine.h
HEADERS += $$PWD/qjsCoreEngineJS.h

SOURCES += $$PWD/qjsCoreColor.cpp
SOURCES += $$PWD/qjsCoreComint.cpp
SOURCES += $$PWD/qjsCoreEngine.cpp
SOURCES += $$PWD/qjsCoreEngineJS.cpp

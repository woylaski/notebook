# qjshell.pri --- 
# 
# Author: Julien Wintz
# Created: lun. mars 24 23:52:24 2014 (+0100)
# Version: 
# Last-Updated: mar. mars 25 00:36:39 2014 (+0100)
#           By: Julien Wintz
#     Update #: 19
# 

# Change Log:
# 
# 

QT += core
QT += qml

QMAKE_CXXFLAGS += -I$$PWD/src/

LIBS += -lreadline

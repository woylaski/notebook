# app.pro --- 
# 
# Author: Julien Wintz
# Created: lun. mars 24 23:53:39 2014 (+0100)
# Version: 
# Last-Updated: lun. mars 24 23:54:34 2014 (+0100)
#           By: Julien Wintz
#     Update #: 6
# 

# Change Log:
# 
# 

TEMPLATE = app

include($$PWD/../../qjshell.pri)

SOURCES += $$PWD/main.cpp

LIBS += -lreadline

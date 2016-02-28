QT          += core network qml gui quick

TEMPLATE     = app

TARGET       = irc-qt-client

INCLUDEPATH += \
    libqtqmltricks/include

SOURCES     += \
    main.cpp \
    libqtqmltricks/src/qqmlhelpers.cpp \
    libqtqmltricks/src/qqmlobjectlistmodel.cpp \
    libqtqmltricks/src/qqmlvariantlistmodel.cpp \
    QtIrcServer.cpp \
    QtIrcChannel.cpp \
    QtIrcMessage.cpp \
    QtIrcIdentity.cpp \
    QtIrcSharedObject.cpp \
    libqtqmltricks/src/qqmlsortfilterproxymodel.cpp

HEADERS     += \
    libqtqmltricks/src/qqmlhelpers.h \
    libqtqmltricks/src/qqmlmodels.h \
    libqtqmltricks/src/qqmlobjectlistmodel.h \
    libqtqmltricks/src/qqmlobjectlistmodel_p.h \
    libqtqmltricks/src/qqmlvariantlistmodel.h \
    libqtqmltricks/src/qqmlvariantlistmodel_p.h \
    QtIrcServer.h \
    QtIrcChannel.h \
    QtIrcMessage.h \
    QtIrcIdentity.h \
    QtIrcSharedObject.h \
    libqtqmltricks/src/qqmlsortfilterproxymodel.h

RESOURCES   += \
    data.qrc \
    components.qrc

TEMPLATE = app

QT += qml quick

SOURCES	+= sample.cpp

RESOURCES += sample.qrc                 \
            ../FontAwesomeQml.qrc

OTHER_FILES +=  sample.qml              \
                ../FontAwesome.qml      \
                ../FontAwesomeModel.qml

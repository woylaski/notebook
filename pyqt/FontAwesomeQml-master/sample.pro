TEMPLATE = app

QT += qml quick

SOURCES	+= sample/sample.cpp

RESOURCES += sample/sample.qrc                 \
            ./FontAwesomeQml.qrc

OTHER_FILES +=  sample/sample.qml              \
                ./FontAwesome.qml      \
                ./FontAwesomeModel.qml

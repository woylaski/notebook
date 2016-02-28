#ifndef QTIRCMESSAGE_H
#define QTIRCMESSAGE_H

#include <QObject>
#include <QQmlHelpers>
#include <QDateTime>

class QtIrcMessage : public QObject {
    Q_OBJECT
    Q_ENUMS (MessageTypes)
    QML_READONLY_PROPERTY (bool, toMe)
    QML_READONLY_PROPERTY (bool, fromMe)
    QML_READONLY_PROPERTY (int, type)
    QML_READONLY_PROPERTY (QString, from)
    QML_READONLY_PROPERTY (QString, content)
    QML_CONSTANT_PROPERTY (QDateTime, timestamp)

public:
    explicit QtIrcMessage (QObject * parent = NULL);

    enum MessageTypes {
        Normal = 0,
        Status = 1,
        Error  = 2
    };
};

#endif // QTIRCMESSAGE_H

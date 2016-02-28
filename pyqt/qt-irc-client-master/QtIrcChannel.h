#ifndef QTIRCCHANNEL_H
#define QTIRCCHANNEL_H

#include <QObject>
#include <QQmlHelpers>
#include <QQmlObjectListModel>

class QtIrcChannel : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (bool, hasUnreadMessages)
    QML_READONLY_PROPERTY (QString, name)
    QML_READONLY_PROPERTY (QString, topic)
    QML_CONSTANT_PROPERTY (QQmlObjectListModel *, members)
    QML_CONSTANT_PROPERTY (QQmlObjectListModel *, messages)

public:
    explicit QtIrcChannel (QObject * parent = 0);
};

#endif // QTIRCCHANNEL_H

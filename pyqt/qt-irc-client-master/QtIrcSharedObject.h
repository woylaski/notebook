#ifndef QTIRCSHAREDOBJECT_H
#define QTIRCSHAREDOBJECT_H

#include <QObject>
#include <QQmlHelpers>
#include <QQmlObjectListModel>

class QtIrcSharedObject : public QObject {
    Q_OBJECT
    QML_CONSTANT_PROPERTY (QQmlObjectListModel *, servers)

public:
    explicit QtIrcSharedObject (QObject * parent = 0);

public slots:
    void addNewServer (QString host, quint16 port);
};

#endif // QTIRCSHAREDOBJECT_H

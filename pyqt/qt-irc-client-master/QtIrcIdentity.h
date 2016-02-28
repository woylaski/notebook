#ifndef QTIRCIDENTITY_H
#define QTIRCIDENTITY_H

#include <QObject>
#include <QQmlHelpers>

class QtIrcIdentity : public QObject {
    Q_OBJECT
    QML_READONLY_PROPERTY (QString, nickname)

public:
    explicit QtIrcIdentity (QObject * parent = NULL);

signals:

public slots:

};

#endif // QTIRCIDENTITY_H

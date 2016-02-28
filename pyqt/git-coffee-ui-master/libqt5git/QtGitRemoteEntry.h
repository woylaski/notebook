#ifndef QTGITREMOTEENTRY_H
#define QTGITREMOTEENTRY_H

#include <QObject>

#include "QQmlConstRefPropertyHelpers.h"

class QtGitRemoteEntry : public QObject {
    Q_OBJECT
    QML_READONLY_CSTREF_PROPERTY (QString, name)
    QML_READONLY_CSTREF_PROPERTY (QString, fetchUrl)
    QML_READONLY_CSTREF_PROPERTY (QString, pushUrl)

public:
    explicit QtGitRemoteEntry (QObject * parent = Q_NULLPTR);
};

#endif // QTGITREMOTEENTRY_H

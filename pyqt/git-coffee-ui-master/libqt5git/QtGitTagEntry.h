#ifndef QTGITTAGENTRY_H
#define QTGITTAGENTRY_H

#include <QObject>

#include "QQmlConstRefPropertyHelpers.h"

class QtGitTagEntry : public QObject {
    Q_OBJECT
    QML_READONLY_CSTREF_PROPERTY (QString, name)

public:
    explicit QtGitTagEntry (QObject * parent = Q_NULLPTR);
};

#endif // QTGITTAGENTRY_H

#ifndef QTGITBRANCHENTRY_H
#define QTGITBRANCHENTRY_H

#include <QObject>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

class QtGitBranchEntry : public QObject {
    Q_OBJECT
    QML_READONLY_CSTREF_PROPERTY (QString, name)
    QML_READONLY_CSTREF_PROPERTY (QString, upstreamName)
    QML_READONLY_VAR_PROPERTY (bool,    isLocal)
    QML_READONLY_VAR_PROPERTY (bool,    isHead)
    QML_READONLY_VAR_PROPERTY (bool,    hasRemote)

public:
    explicit QtGitBranchEntry (QObject * parent = NULL);
};

#endif // QTGITBRANCHENTRY_H

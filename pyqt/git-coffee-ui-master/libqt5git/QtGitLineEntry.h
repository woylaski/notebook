#ifndef QTGITLINEENTRY_H
#define QTGITLINEENTRY_H

#include <QObject>
#include <QDateTime>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"
#include "QQmlObjectListModel.h"
#include "QQmlVariantListModel.h"

class QtGitLineEntry : public QObject {
    Q_OBJECT
    QML_READONLY_VAR_PROPERTY (int, oldLineNum)
    QML_READONLY_VAR_PROPERTY (int, newLineNum)
    QML_READONLY_VAR_PROPERTY (bool, added)
    QML_READONLY_VAR_PROPERTY (bool, removed)
    QML_READONLY_CSTREF_PROPERTY (QString, content)

public:
    explicit QtGitLineEntry (QObject * parent = NULL);
};

#endif // QTGITLINEENTRY_H

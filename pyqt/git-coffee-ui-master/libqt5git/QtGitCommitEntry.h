#ifndef QTGITCOMMITENTRY_H
#define QTGITCOMMITENTRY_H

#include <QObject>
#include <QDateTime>

#include "QQmlPtrPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

class QtGitDiffObject;

class QtGitCommitEntry : public QObject {
    Q_OBJECT
    QML_READONLY_CSTREF_PROPERTY (QString, objectId)
    QML_READONLY_CSTREF_PROPERTY (QString, messageSummary)
    QML_READONLY_CSTREF_PROPERTY (QString, messageBody)
    QML_READONLY_CSTREF_PROPERTY (QString, authorMail)
    QML_READONLY_CSTREF_PROPERTY (QString, authorName)
    QML_READONLY_CSTREF_PROPERTY (QDateTime, authorWhen)
    QML_READONLY_CSTREF_PROPERTY (QStringList, parentsIds)
    QML_CONSTANT_PTR_PROPERTY (QtGitDiffObject, diffFromParents)

public:
    explicit QtGitCommitEntry (QObject * parent = NULL);
};

#endif // QTGITCOMMITENTRY_H

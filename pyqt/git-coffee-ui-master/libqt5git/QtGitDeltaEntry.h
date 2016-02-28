#ifndef QTGITDELTAENTRY_H
#define QTGITDELTAENTRY_H

#include <QObject>
#include <QDateTime>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"
#include "QQmlObjectListModel.h"

class QtGitHunkEntry;

class QtGitDeltaEntry : public QObject {
    Q_OBJECT
    Q_ENUMS (Status)
    QML_READONLY_VAR_PROPERTY (int, status)
    QML_READONLY_VAR_PROPERTY (int, addedCount)
    QML_READONLY_VAR_PROPERTY (int, removedCount)
    QML_READONLY_VAR_PROPERTY (bool, isBinary)
    QML_READONLY_CSTREF_PROPERTY (QString, oldFilePath)
    QML_READONLY_CSTREF_PROPERTY (QString, newFilePath)
    QML_OBJMODEL_PROPERTY (QtGitHunkEntry, hunksModel)

public:
    explicit QtGitDeltaEntry (QObject * parent = NULL);

    enum Status {
        Unknown = -1,
        UnModified,
        Added,
        Deleted,
        Modified,
        Renamed,
        Copied,
        Ignored,
        UnTracked,
        TypeChanged
    };
};

#endif // QTGITDELTAENTRY_H

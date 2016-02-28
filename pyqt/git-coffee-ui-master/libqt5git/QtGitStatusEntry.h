#ifndef QTGITSTATUSENTRY_H
#define QTGITSTATUSENTRY_H

#include <QObject>
#include <QDateTime>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlPtrPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

class QtGitDiffObject;

class QtGitStatusEntry : public QObject {
    Q_OBJECT
    Q_ENUMS (EntryType)
    QML_READONLY_CSTREF_PROPERTY (QString, path)
    QML_READONLY_CSTREF_PROPERTY (QString, oldPath)
    QML_READONLY_VAR_PROPERTY (int,     type)
    QML_READONLY_VAR_PROPERTY (int,     nesting)
    QML_READONLY_VAR_PROPERTY (bool,    unchanged)
    QML_READONLY_VAR_PROPERTY (bool,    ignored)
    QML_READONLY_VAR_PROPERTY (bool,    untracked)
    QML_READONLY_VAR_PROPERTY (bool,    moved)
    QML_READONLY_VAR_PROPERTY (bool,    modified)
    QML_READONLY_VAR_PROPERTY (bool,    chmoded)
    QML_READONLY_VAR_PROPERTY (bool,    deleted)
    QML_WRITABLE_VAR_PROPERTY (bool,    shown)
    QML_WRITABLE_VAR_PROPERTY (bool,    opened)
    QML_CONSTANT_PTR_PROPERTY (QtGitDiffObject, diffFromHead)

public:
    explicit QtGitStatusEntry (QObject * parent = NULL);

    bool hasChanged () const;

    enum EntryType {
        File,
        Folder,
        SubModule
    };
};

#endif // QTGITSTATUSENTRY_H

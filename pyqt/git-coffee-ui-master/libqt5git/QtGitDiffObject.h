#ifndef QTGITDIFFOBJECT_H
#define QTGITDIFFOBJECT_H

#include <QObject>
#include <QDateTime>

#include "QQmlObjectListModel.h"

class QtGitDeltaEntry;

class QtGitDiffObject : public QObject {
    Q_OBJECT
    QML_OBJMODEL_PROPERTY (QtGitDeltaEntry, deltaModel)

public:
    explicit QtGitDiffObject (QObject * parent = NULL);
};

#endif // QTGITDIFFOBJECT_H

#ifndef QTGITHUNKENTRY_H
#define QTGITHUNKENTRY_H

#include <QObject>
#include <QDateTime>

#include "QQmlConstRefPropertyHelpers.h"
#include "QQmlObjectListModel.h"

class QtGitLineEntry;

class QtGitHunkEntry : public QObject {
    Q_OBJECT
    QML_READONLY_CSTREF_PROPERTY (QString, header)
    QML_OBJMODEL_PROPERTY (QtGitLineEntry, linesModel)

public:
    explicit QtGitHunkEntry (QObject * parent = NULL);
};

#endif // QTGITHUNKENTRY_H

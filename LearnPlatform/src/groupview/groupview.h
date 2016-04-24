#ifndef GROUPVIEW_H
#define GROUPVIEW_H

#pragma once

class QAbstractItemModel;
class QObject;

namespace GroupView
{
    void registerTypes();
    QAbstractItemModel *makeProxy(QAbstractItemModel *model, QObject *parent = 0);
}

#endif // GROUPVIEW_H


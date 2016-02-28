#include "qqmlsortfilterproxymodel.h"

QQmlSortFilterProxyModel::QQmlSortFilterProxyModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
   setDynamicSortFilter   (true);
   setSortCaseSensitivity (Qt::CaseInsensitive);
   sort                   (0, Qt::AscendingOrder);
}

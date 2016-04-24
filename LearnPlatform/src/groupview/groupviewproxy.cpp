#include "groupviewproxy.h"

GroupViewProxy::GroupViewProxy(QObject *parent)
    : QIdentityProxyModel(parent)
{
}

QVariant GroupViewProxy::data(const QModelIndex &index, int role) const
{
    if (role == ChildrenListRole) {
        GroupViewProxy *we = const_cast<GroupViewProxy *>(this);
        if (!we->m_proxies.contains(index)) {
            we->m_proxies.insert(index, new GroupViewProxy(we));
            we->m_proxies[index]->setSourceModel(sourceModel());
            we->m_proxies[index]->setRootIndex(index);
        }
        return QVariant::fromValue(m_proxies.value(index));
    } else if (role == ModelIndexRole) {
        return mapToSource(index);
    } else {
        return QIdentityProxyModel::data(index, role);
    }
}

QHash<int, QByteArray> GroupViewProxy::roleNames() const
{
    QHash<int, QByteArray> roles = QIdentityProxyModel::roleNames();
    roles.insert(ChildrenListRole, "__childrenList");
    roles.insert(ModelIndexRole, "__modelIndex");
    return roles;
}

QModelIndex GroupViewProxy::mapFromSource(const QModelIndex &sourceIndex) const
{
    if (!sourceIndex.isValid() || sourceIndex == m_rootIndex) {
        return QModelIndex();
    } else {
        return QIdentityProxyModel::mapFromSource(sourceIndex);
    }
}
QModelIndex GroupViewProxy::mapToSource(const QModelIndex &proxyIndex) const
{
    if (!proxyIndex.isValid()) {
        return m_rootIndex;
    } else {
        return QIdentityProxyModel::mapToSource(proxyIndex);
    }
}

void GroupViewProxy::handleRowsRemoved(const QModelIndex &parent, const int first, const int last)
{
    for (int i = first; i < last; ++i) {
        m_proxies.remove(sourceModel()->index(i, 0, parent));
    }
}

void GroupViewProxy::setRootIndex(const QPersistentModelIndex &rootIndex)
{
    if (m_rootIndex == rootIndex) {
        return;
    }

    Q_ASSERT(rootIndex.isValid() || rootIndex.model() == sourceModel());
    beginResetModel();
    m_rootIndex = rootIndex;
    emit rootIndexChanged(rootIndex);
    endResetModel();
}
void GroupViewProxy::setSourceModel(QAbstractItemModel *model)
{
    if (sourceModel()) {
        disconnect(sourceModel(), &QAbstractItemModel::rowsRemoved, this, &GroupViewProxy::handleRowsRemoved);
    }
    QIdentityProxyModel::setSourceModel(model);
    qDeleteAll(m_proxies.values());
    m_proxies.clear();
    m_rootIndex = QModelIndex();
    if (sourceModel()) {
        connect(sourceModel(), &QAbstractItemModel::rowsRemoved, this, &GroupViewProxy::handleRowsRemoved);
    }
}


#ifndef TREEITEM_H
#define TREEITEM_H

#include <QList>
#include <QVariant>

//! [0],treeitem就是一条条的记录。每条记录都有固定的字段，每个记录都有自己的父子记录。
class TreeItem
{
public:
    explicit TreeItem(const QList<QVariant> &data, TreeItem *parentItem = 0);
    ~TreeItem();

    void appendChild(TreeItem *child);
    void deleteItem(int row);

    TreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    TreeItem *parentItem();

private:
    QList<TreeItem*> m_childItems;
    QList<QVariant> m_itemData;
    TreeItem *m_parentItem;
};
//! [0]


#endif // TREEITEM_H


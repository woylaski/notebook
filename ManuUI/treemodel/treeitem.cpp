/*
    treeitem.cpp
    A container for items of data supplied by the simple tree model.
*/

#include <QStringList>
#include "treeitem.h"

//! [0]
//! //explicit TreeItem(const QList<QVariant> &data, TreeItem *parentItem = 0);
TreeItem::TreeItem(const QList<QVariant> &data, TreeItem *parent)
{
    m_parentItem = parent;
    m_itemData = data;
}

//! [1]
//! QList<T> 的释放分两种情况：
//! T的类型为非指针，这时候直接调用clear()方法就可以释放了
//! 如果T为指针类型时，释放内存须在clear方法前加上qDeleteAll 方法
TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
    m_childItems.clear();
    m_itemData.clear();
}

//! [2]
void TreeItem::appendChild(TreeItem *item)
{
    m_childItems.append(item);
}
//! [2]

void TreeItem::deleteItem(int row)
{
    m_childItems.takeAt(row);
}

//! [5]
int TreeItem::columnCount() const
{
    return m_itemData.count();
}
//! [5]

//! [4]
int TreeItem::childCount() const
{
    return m_childItems.count();
}
//! [4]

//! [3]
//T QList::value(int i) const
//Returns the value at index position i in the list.
//If the index i is out of bounds, the function returns a default-constructed value.
//If you are certain that the index is going to be within bounds, you can use at() instead, which is slightly faster.
TreeItem *TreeItem::child(int row)
{
    return m_childItems.value(row);
}
//! [3]

//! [6]
QVariant TreeItem::data(int column) const
{
    return m_itemData.value(column);
}
//! [6]

//! [7]
TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}
//! [7]

//! [8]
//! int QList::indexOf(const T &value, int from = 0) const
//Returns the index position of the first occurrence of value in the list,
//searching forward from index position from. Returns -1 if no item matched.
//从这个TreeItem的父TreeItem的所有子TreeItem中找这个TreeItem的index
int TreeItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));

    return 0;
}
//! [8]

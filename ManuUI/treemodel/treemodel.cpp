#include "treeitem.h"
#include "treemodel.h"
#include <QStringList>
#include <QDebug>
#include <QDate>

//自己定义的这个TreeModel类继承QAbstractItemModel
//data是一个字符串，需要把字符串按照换行分成一条条的记录
//然后每条记录在根据空格之类的分成字段
//根据一些规则组织记录之间的父子关系
//TreeModel::TreeModel(const QString &data, QObject *parent):
TreeModel::TreeModel(QObject *parent):
    QAbstractItemModel(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
    //字段的名字，也就是所谓的role
    QList<QVariant> rootData;
    rootData << "Title" << "Summary"<<"Size";
    rootItem = new TreeItem(rootData);
    m_text="";
    m_count=0;
    //QString data="hello\nworld";
    //setupModelData(m_text.split(QString("\n")), rootItem);
}

TreeModel::~TreeModel()
{
    delete rootItem;
}

QString TreeModel::mdata() const
{
    return m_text;
}

void TreeModel::setMdata(QString text)
{
    //QList<QVariant> rootData;

    if (m_text == text)
    {
        qDebug() << "Date:" << QDate::currentDate();
        qDebug()<<"set data is same"<<endl;
        return;
    }

    //printf("new data: %s\r\n", text);
    //        qDebug() << line;            // 用qDebug 处理了字符转换问题，处理简单
    // 如果自己转换，要调用toStdString,
    // toLatin1 转换非拉丁文(例如汉字)不认识字符返回0，显示为乱码
    // 如果环境不支持toStdString 转换，就用qDebug 吧， toLatin1 不能显示汉字
    //        printf("%s\n",line.toLatin1().data());
    qDebug("new data: %s\n",text.toStdString().data());

    ////////重新加载model数据/////////
    //delete rootItem;
    //rootData << "Title" << "Summary"<<"Size";
    //rootItem = new TreeItem(rootData);
    //setupModelData(m_text.split(QString("\n")), rootItem);
    deleteModelData();
    m_text = text;
    setupModelData();
    ////////////////////////////////

    emit mdataChanged(text);
}

//定义字段的名字
QHash<int, QByteArray> TreeModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameEnum] = "name";
    roles[SummaryEnum] = "summary";
    roles[SizeEnum]="size";
    return roles;
}

//! [2]
//! 使用QModelIndex的internalPointer()函数获得这个内部指针，从而定位我们的node
//! void *QModelIndex::internalPointer() const
//! Returns a void * pointer used by the model to associate the index with the internal data structure.
int TreeModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return static_cast<TreeItem*>(parent.internalPointer())->columnCount();
    else
        return rootItem->columnCount();
}
//! [2]

//! [8]
int TreeModel::rowCount(const QModelIndex &parent) const
{
    TreeItem *parentItem;
    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    return parentItem->childCount();
}
//! [8]

//! [4]
Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return 0;

    return QAbstractItemModel::flags(index);
}
//! [4]

//! [3]
QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

//    if (role != Qt::DisplayRole)
//        return QVariant();

    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());

    switch (role) {
    case NameEnum:
        return item->data(0);
    case SummaryEnum:
        return item->data(1);
    case SizeEnum:
        return item->data(2);
    }
//    return item->data(index.column());
    return QVariant();
}
//! [3]

void TreeModel::deleteModelData()
{
    int row = 0;
    if(m_count==0) return;

    qDebug("delete %d item\r\n", m_count);
    beginRemoveRows(QModelIndex(), 0, m_count-1);
    for(row=0; row<m_count; row++)
    {
        qDebug("delete index %d item\r\n", row);
        rootItem->deleteItem(0);
    }
    endRemoveRows();

    m_text="";
    m_count=0;
}

void TreeModel::setupModelData()
{
    QList<TreeItem*> parents;
    QList<int> indentations;

    parents << rootItem;
    indentations << 0;

    int number = 0;

    QStringList lines = m_text.split(QString("\n"));
    //m_count=lines.count();
    foreach (const QString &str, lines)
    {
        if (!str.startsWith(" "))
            m_count++;
    }

    qDebug("insert %d items\r\n", m_count);

    beginInsertRows(QModelIndex(), 0, m_count-1);
    while (number < lines.count()) {
        int position = 0;
        while (position < lines[number].length()) {
            if (lines[number].mid(position, 1) != " ")
                break;
            position++;
        }

        QString lineData = lines[number].mid(position).trimmed();

        if (!lineData.isEmpty()) {
            // Read the column data from the rest of the line.
            QStringList columnStrings = lineData.split("\t", QString::SkipEmptyParts);
            QList<QVariant> columnData;
            for (int column = 0; column < columnStrings.count(); ++column)
                columnData << columnStrings[column];

            if (position > indentations.last()) {
                // The last child of the current parent is now the new parent
                // unless the current parent has no children.

                if (parents.last()->childCount() > 0) {
                    parents << parents.last()->child(parents.last()->childCount()-1);
                    indentations << position;
                }
            } else {
                while (position < indentations.last() && parents.count() > 0) {
                    parents.pop_back();
                    indentations.pop_back();
                }
            }

            // Append a new item to the current parent's list of children.
            parents.last()->appendChild(new TreeItem(columnData, parents.last()));
        }

        ++number;
    }

    endInsertRows();
}

//! [7]
//!
//! QModelIndex QAbstractItemModel::parent(const QModelIndex &index) const
//Returns the parent of the model item with the given index. If the item has no parent, an invalid QModelIndex is returned.
//A common convention used in models that expose tree data structures is that only items in the first column have children.
//For that case, when reimplementing this function in a subclass the column of the returned QModelIndex would be 0.
//When reimplementing this function in a subclass, be careful to avoid calling QModelIndex member functions,
//such as QModelIndex::parent(), since indexes belonging to your model will simply call your implementation, leading to infinite recursion.
//!
//! The QModelIndex class is used to locate data in a data model
//! Model indexes refer to items in models
//! contain all the information required to specify their locations in those models
//! Each index is located in a given row and column, and may have a parent index;

//!QModelIndex::QModelIndex()
//Creates a new empty model index. This type of model index is used to indicate that the position in the model is invalid.
//See also isValid() and QAbstractItemModel.

//QModelIndex QAbstractItemModel::createIndex(int row, int column, void *ptr = Q_NULLPTR) const
//Creates a model index for the given row and column with the internal pointer ptr.
//When using a QSortFilterProxyModel, its indexes have their own internal pointer. It is not advisable to access this internal pointer outside of the model. Use the data() function instead.
//This function provides a consistent interface that model subclasses must use to create model indexes.
QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    TreeItem *parentItem = childItem->parentItem();

    // When referring to top-level items in a model, supply QModelIndex() as the parent index.
    //// 顶层节点,直接返回空索引
    if (parentItem == rootItem)
        return QModelIndex();

    //// 为父结点建立索引
    return createIndex(parentItem->row(), 0, parentItem);
}
//! [7]

//QModelIndex QAbstractItemModel::index(int row, int column, const QModelIndex &parent = QModelIndex()) const
//Returns the index of the item in the model specified by the given row, column and parent index.
//When reimplementing this function in a subclass,
//call createIndex() to generate model indexes that other components can use to refer to items in your model.
//! [6]
QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    TreeItem *parentItem;

    if (!parent.isValid())
        parentItem = rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    TreeItem *childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    else
        return QModelIndex();
}
//! [6]

//! [5]
//! QVariant QAbstractItemModel::headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const
//Returns the data for the given role and section in the header with the specified orientation.
//For horizontal headers, the section number corresponds to the column number.
//Similarly, for vertical headers, the section number corresponds to the row number.
//headerData()返回列名或者行名
QVariant TreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return rootItem->data(section);

    return QVariant();
}
//! [5]

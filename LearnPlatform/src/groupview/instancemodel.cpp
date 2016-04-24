#include "instancemodel.h"

#include <QColor>
#include <QMimeData>

InstanceModel::InstanceModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    insertRows(0, 5, QModelIndex());
    const QModelIndex devices = index(0, 0);
    const QModelIndex settings = index(1, 0);
    const QModelIndex applications = index(2, 0);
    const QModelIndex mimetypes = index(3, 0);
    const QModelIndex python = index(4, 0);
    setData(devices, "Devices", Qt::DisplayRole);
    setData(settings, "Settings", Qt::DisplayRole);
    setData(applications, "Applications", Qt::DisplayRole);
    setData(mimetypes, "Mime types", Qt::DisplayRole);
    setData(python, "Silly", Qt::DisplayRole);

    auto add = [this](const QModelIndex &parent, const QString &name, const QString &icon)
    //auto add = [this](const QModelIndex &parent, const QString &name, const QString &icon = QString())

    {
        insertRow(rowCount(parent), parent);
        const QModelIndex i = index(rowCount(parent)-1, 0, parent);
        setData(i, name, Qt::DisplayRole);
        setData(i, "qrc:/images/icons/" + (icon.isNull() ? name.toLower().remove(' ') + ".png" : icon), Qt::DecorationRole);
    };

    add(devices, "Audio Card", QString());
    add(devices, "Audio Headphones", QString());
    add(devices, "Camera", QString());
    add(devices, "Desktop", QString());
    add(devices, "Laptop", QString());
    add(devices, "Harddisk", QString());
    add(devices, "Optical Drive", QString());
    add(devices, "USB Pendrive", QString());
    add(devices, "Removable Media", QString());
    add(devices, "Keyboard", QString());
    add(devices, "Mouse", QString());
    add(devices, "Flash Memory Stick", QString());
    add(devices, "Flash SD MMC", QString());
    add(devices, "Flash Smart Media", QString());
    add(devices, "Floppy", QString());
    add(devices, "Blu-Ray", QString());
    add(devices, "DVD", QString());
    add(devices, "CD", QString());
    add(devices, "Network Wired", QString());
    add(devices, "Network Wireless", QString());
    add(devices, "Printer", QString());
    add(devices, "Smartphone", QString());
    add(devices, "Tablet", QString());
    add(devices, "Display", QString());

    add(settings, "General", QString());
    add(settings, "Network", QString());
    add(settings, "Appearance", QString());
    add(settings, "System", QString());

    add(applications, "Engineering", QString());
    add(applications, "Graphics", QString());
    add(applications, "Internet", QString());
    add(applications, "Multimedia", QString());
    add(applications, "Office", QString());
    add(applications, "Other", QString());
    add(applications, "Science", QString());

    add(mimetypes, "EPub", QString());
    add(mimetypes, "Google Earth", QString());
    add(mimetypes, "Illustrator", QString());
    add(mimetypes, "Javascript", QString());
    add(mimetypes, "MS Access", QString());
    add(mimetypes, "MS Excel", QString());
    add(mimetypes, "MS Powerpoint", QString());
    add(mimetypes, "MS Word", QString());
    add(mimetypes, "MS Word Template", QString());
    add(mimetypes, "OpenDocument Chart", QString());
    add(mimetypes, "OpenDocument Database", QString());
    add(mimetypes, "OpenDocument Formula", QString());
    add(mimetypes, "OpenDocument Formula Template", QString());
    add(mimetypes, "OpenDocument Graphics", QString());
    add(mimetypes, "OpenDocument Image", QString());
    add(mimetypes, "OpenDocument Presentation", QString());
    add(mimetypes, "OpenDocument Presentation Template", QString());
    add(mimetypes, "OpenDocument Spreadsheet", QString());
    add(mimetypes, "OpenDocument Spreadsheet Template", QString());
    add(mimetypes, "OpenDocument Text", QString());
    add(mimetypes, "PDF", QString());
    add(mimetypes, "PGP Encrypted", QString());
    add(mimetypes, "PGP Keys", QString());
    add(mimetypes, "PostScript", QString());
    add(mimetypes, "RSS", QString());
    add(mimetypes, "RTF", QString());
    add(mimetypes, "Scribus", QString());

    add(python, "My", "my.jpg");
    add(python, "hovercraft", "hovercraft.jpg");
    add(python, "is", "is.jpg");
    add(python, "full", "full.jpg");
    add(python, "of", "of.jpg");
    add(python, "eels", "eels.jpg");
}

QModelIndex InstanceModel::index(int row, int column, const QModelIndex &parent) const
{
    Item *parentItem = parent.isValid() ? static_cast<Item *>(parent.internalPointer()) : m_root;
    return createIndex(row, column, parentItem->items.at(row));
}
QModelIndex InstanceModel::parent(const QModelIndex &child) const
{
    if (!child.isValid()) {
        return QModelIndex();
    }
    Item *item = static_cast<Item *>(child.internalPointer())->parent;
    if (!item || item == m_root) {
        return QModelIndex();
    } else {
        return createIndex(item->parent->items.indexOf(item), 0, item);
    }
}

int InstanceModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return static_cast<Item *>(parent.internalPointer())->items.size();
    } else {
        return m_root->items.size();
    }
}
int InstanceModel::columnCount(const QModelIndex &) const
{
    return 1;
}

QVariant InstanceModel::data(const QModelIndex &index, int role) const
{
    Item *item = static_cast<Item *>(index.internalPointer());
    if (!item) {
        return QVariant();
    }
    return item->values.value(role);
}
bool InstanceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    static_cast<Item *>(index.internalPointer())->values[role] = value;
    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags InstanceModel::flags(const QModelIndex &index) const
{
    if (index.parent().isValid()) {
        return Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsDragEnabled | Qt::ItemIsDropEnabled;
    } else {
        return Qt::ItemIsEnabled | Qt::ItemIsDropEnabled;
    }
}

bool InstanceModel::insertRows(int row, int count, const QModelIndex &parent)
{
    Item *parentItem = parent.isValid() ? static_cast<Item *>(parent.internalPointer()) : m_root;
    beginInsertRows(parent, row, row + count);
    for (int i = 0; i < count; ++i) {
        parentItem->items.insert(row, new Item(parentItem));
    }
    endInsertRows();
    return true;
}
bool InstanceModel::removeRows(int row, int count, const QModelIndex &parent)
{
    Item *parentItem = parent.isValid() ? static_cast<Item *>(parent.internalPointer()) : m_root;
    beginRemoveRows(parent, row, row + count);
    for (int i = 0; i < count; ++i) {
        delete parentItem->items.at(row + i);
    }
    parentItem->items.remove(row, count);
    endRemoveRows();
    return true;
}
bool InstanceModel::moveRows(const QModelIndex &sourceParent, int sourceRow, int count, const QModelIndex &destinationParent, int destinationChild)
{
    Item *sourceParentItem = sourceParent.isValid() ? static_cast<Item *>(sourceParent.internalPointer()) : m_root;
    Item *destParentItem = destinationParent.isValid() ? static_cast<Item *>(destinationParent.internalPointer()) : m_root;
    beginMoveRows(sourceParent, sourceRow, sourceRow + count, destinationParent, destinationChild);
    for (int i = 0; i < count; ++i) {
        Item *item = sourceParentItem->items.at(sourceRow + i);
        sourceParentItem->items.remove(sourceRow + i);
        item->parent = destParentItem;
        destParentItem->items.insert(destinationChild + i, item);
    }
    endMoveRows();
    return true;
}

InstanceModel::Item::~Item()
{
    qDeleteAll(items);
}

QStringList InstanceModel::mimeTypes() const
{
    return QStringList("application/x-instance");
    //return {"application/x-instance"};
}
QMimeData *InstanceModel::mimeData(const QModelIndexList &indexes) const
{
    QMimeData *data = new QMimeData;
    QStringList items;
    for (const QModelIndex &index : indexes) {
        items.append(index.data().toString());
    }
    data->setData("application/x-instance", items.join(":").toUtf8());

    return data;
}

bool InstanceModel::canDropMimeData(const QMimeData *data, Qt::DropAction action, int row, int column, const QModelIndex &parent) const
{
    if (!QAbstractItemModel::canDropMimeData(data, action, row, column, parent)) {
        return false;
    } else {
        return true;
    }
}
bool InstanceModel::dropMimeData(const QMimeData *data, Qt::DropAction action, int row, int column, const QModelIndex &parent)
{
    QModelIndex newParent = parent.isValid() ? parent : index(row, column);
    QModelIndexList list;
    const QStringList names = QString::fromUtf8(data->data("application/x-instance")).split(":");
    for (const QString &name : names) {
        for (Item * const item : m_root->items) {
            for (Item * const child : item->items) {
                if (child->values.value(Qt::DisplayRole).toString() == name) {
                    list.append(indexFor(child));
                }
            }
        }
    }
    if (action == Qt::MoveAction) {
        for (const QModelIndex &index : list) {
            moveRow(index.parent(), index.row(), newParent, row == -1 ? rowCount(newParent) : row);
        }
        return true;
    } else {
        return false;
    }
}

Qt::DropActions InstanceModel::supportedDropActions() const
{
    return Qt::MoveAction;
}
Qt::DropActions InstanceModel::supportedDragActions() const
{
    return Qt::MoveAction;
}

QModelIndex InstanceModel::indexFor(InstanceModel::Item * const item) const
{
    if (item == m_root) {
        return QModelIndex();
    } else {
        return createIndex(item->parent->items.indexOf(item), 0, item);
    }
}


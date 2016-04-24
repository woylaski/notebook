#include "groupview.h"

#include <QtQml>

#include "groupviewdroparea.h"
#include "groupviewhelper.h"
#include "groupviewproxy.h"

void GroupView::registerTypes()
{
    qmlRegisterType<GroupViewDropArea>("com.manu.groupview.internal", 1, 0, "GroupViewDropArea");
    qmlRegisterType<GroupViewHelper>("com.manu.groupview.internal", 1, 0, "GroupViewHelper");
    qmlRegisterType(QUrl("qrc:/qml/groupview/GroupView.qml"), "com.manu.groupview", 1, 0, "GroupView");
    qmlRegisterType(QUrl("qrc:/qml/groupview/ScrollBar.qml"), "com.manu.groupview", 1, 0, "ScrollBar");
}

QAbstractItemModel *GroupView::makeProxy(QAbstractItemModel *model, QObject *parent)
{
    GroupViewProxy *proxy = new GroupViewProxy(parent);
    proxy->setSourceModel(model);
    return proxy;
}

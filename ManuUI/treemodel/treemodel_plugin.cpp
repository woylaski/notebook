#include "treemodel_plugin.h"
#include "treemodel.h"
#include "treeitem.h"
#include <qqml.h>

void TreemodelPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<QAbstractItemModel> ();
    // @uri com.manu.treemodel
    qmlRegisterType<TreeModel>(uri, 1, 0, "TreeModel");
}

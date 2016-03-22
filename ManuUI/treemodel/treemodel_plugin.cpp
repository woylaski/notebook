#include "treemodel_plugin.h"
#include "treemodel.h"

#include <qqml.h>

void TreemodelPlugin::registerTypes(const char *uri)
{
    // @uri com.manu.treemodel
    qmlRegisterType<TreeModel>(uri, 1, 0, "TreeModel");
}



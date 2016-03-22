#ifndef TREEMODEL_PLUGIN_H
#define TREEMODEL_PLUGIN_H

#include <QQmlExtensionPlugin>

class TreemodelPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // TREEMODEL_PLUGIN_H


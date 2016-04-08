#ifndef DYNAMICSVG_PLUGIN_H
#define DYNAMICSVG_PLUGIN_H

#include <QQmlExtensionPlugin>

class DynamicSvgPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // DYNAMICSVG_PLUGIN_H


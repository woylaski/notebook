#ifndef ZINNIA_PLUGIN_H
#define ZINNIA_PLUGIN_H

#include <QQmlExtensionPlugin>

class ZinniaPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // ZINNIA_PLUGIN_H


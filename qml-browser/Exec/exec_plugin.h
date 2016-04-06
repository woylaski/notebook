#ifndef EXEC_PLUGIN_H
#define EXEC_PLUGIN_H

#include <QQmlExtensionPlugin>

class ExecPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // EXEC_PLUGIN_H


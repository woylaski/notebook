#ifndef MANU_PLUGINS_H
#define MANU_PLUGINS_H

#define MANU_PLUGIN_URI     "manu.plugin"
#define MANU_PLUGIN_VER_MAJOR   1
#define MANU_PLUGIN_VER_MINOR  0

#define REG_QML_TYPE(classname, qmlName)  \
    qmlRegisterType<classname>(MANU_PLUGIN_URI, MANU_PLUGIN_VER_MAJOR, MANU_PLUGIN_VER_MINOR, qmlName)

void registerManuPlugins();

#endif // MANU_PLUGINS_H

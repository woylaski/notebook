#include"manu_filesystem.h"
#include"manu_device.h"
#include"manu_units.h"
#include "manu_plugins.h"

void registerManuPlugins()
{
    REG_QML_TYPE(ManuFileIO, "FileIO");
    qmlRegisterSingletonType<Device>(MANU_PLUGIN_URI, 1, 0, "Device", Device::qmlSingleton);
    qmlRegisterUncreatableType<Units>(MANU_PLUGIN_URI, 1, 0, "Units", QStringLiteral("Units can only be used via the attached property."));
}

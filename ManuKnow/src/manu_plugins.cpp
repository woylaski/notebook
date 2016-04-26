#include"manu_filesystem.h"
#include "manu_plugins.h"

void registerManuPlugins()
{
    REG_QML_TYPE(ManuFileIO, "FileIO");
}

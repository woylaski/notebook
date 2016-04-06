#include "zinnia_plugin.h"
#include "zinnia.h"

#include <qqml.h>

void ZinniaPlugin::registerTypes(const char *uri)
{
    // @uri com.manu.zinnia
    qmlRegisterType<Zinnia>(uri, 1, 0, "Zinnia");
}



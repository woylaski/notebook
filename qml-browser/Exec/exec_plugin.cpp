#include "exec_plugin.h"
#include "exec.h"

#include <qqml.h>

void ExecPlugin::registerTypes(const char *uri)
{
    // @uri com.manu.exec
    qmlRegisterType<Exec>(uri, 1, 0, "Exec");
}



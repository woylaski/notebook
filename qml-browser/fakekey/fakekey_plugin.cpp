#include "fakekey_plugin.h"
#include "fakekey.h"

#include <qqml.h>

void FakekeyPlugin::registerTypes(const char *uri)
{
    // @uri com.mycompany.qmlcomponents
    qmlRegisterType<Fakekey>(uri, 1, 0, "Fakekey");
}



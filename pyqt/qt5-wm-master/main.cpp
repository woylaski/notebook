
#include "defs.h"

#include "Qt5WaylandClientWrapper.h"
#include "Qt5WaylandServerFacade.h"

int main (int argsCount, char * argsString []) {
    QGuiApplication app (argsCount, argsString);
    qmlRegisterType<Qt5WaylandClientWrapper> ("Qt5WM", 1, 0, "ClientWrapper");
    qmlRegisterType<Qt5WaylandServerFacade> ("Qt5WM", 1, 0, "CompositorFacade");
    new QQmlApplicationEngine (QUrl ("qrc:///ui.qml"));
    return app.exec ();
}

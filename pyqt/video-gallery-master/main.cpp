
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QUrl>
#include <QDir>

#include "SharedObject.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine (&app);
    engine.rootContext ()->setContextProperty ("Shared", new SharedObject (&app));
    engine.rootContext ()->setContextProperty ("HomePath", QUrl::fromLocalFile (QDir::homePath ()));
    engine.load (QUrl ("qrc:///ui.qml"));
    return app.exec ();
}


#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>

#include "MyFileSystemWalker.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine (&app);
    engine.rootContext ()->setContextProperty ("Walker", new MyFileSystemWalker (&engine));
    engine.load (QUrl ("qrc:/ui.qml"));
    return app.exec ();
}

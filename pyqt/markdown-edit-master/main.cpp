
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

#include "TextFileHelper.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine (&app);
    engine.rootContext ()->setContextProperty ("TextFileHelper", new TextFileHelper (&engine));
    engine.load (QUrl ("qrc:/ui.qml"));
    return app.exec ();
}

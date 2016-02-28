
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine (&app);
    engine.load (QUrl ("qrc:/ui.qml"));
    return app.exec ();
}

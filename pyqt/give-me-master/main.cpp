
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
#include <QIcon>

#include "SharedObject.h"
#include "QtQmlTricksPlugin.h"

#ifdef Q_OS_SAILFISH
#   include <sailfishapp.h>
#endif

static void prepareEngine (QQmlEngine * engine) {
    registerQtQmlTricksUiElements (engine);
    qmlRegisterType<UsersModelItem>                     ("GiveMe", 1, 0, "UserModelItem");
    qmlRegisterType<TransfersModelItem>                 ("GiveMe", 1, 0, "TransfersModelItem");
    qmlRegisterUncreatableType<QQmlObjectListModelBase> ("GiveMe", 1, 0, "QQmlObjectListModelBase", "!!!");
    engine->rootContext ()->setContextProperty ("SharedObject", new SharedObject (engine));
}

int main (int argc, char * argv []) {
#ifdef Q_OS_SAILFISH
    QGuiApplication * app = SailfishApp::application (argc, argv);
    QQuickView * view = SailfishApp::createView ();
    prepareEngine (view->engine ());
    view->setSource (QUrl ("qrc:///ui_silica.qml"));
    view->show();
    if (view->rootObject() != Q_NULLPTR) {
        return app->exec ();
    }
#else
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine;
    prepareEngine (&engine);
    engine.load (QUrl ("qrc:///ui_generic.qml"));
    if (!engine.rootObjects ().isEmpty ()) {
        return app.exec ();
    }
#endif
    return -1;
}

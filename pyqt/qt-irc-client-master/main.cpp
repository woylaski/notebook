
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QQmlSortFilterProxyModel>
#include <QQmlObjectListModel>
#include <QQmlVariantListModel>
#include <qqml.h>
#include <QIcon>

#include "QtIrcServer.h"
#include "QtIrcChannel.h"
#include "QtIrcIdentity.h"
#include "QtIrcMessage.h"
#include "QtIrcSharedObject.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    const char *  uri = "QtIrc"; // @uri QtIrc
    const int     maj = 1;
    const int     min = 0;
    const QString msg = QStringLiteral ("This object type can only be instanciated in the C++ code !!!");

    qmlRegisterUncreatableType<QQmlObjectListModel>   (uri, maj, min, "QQmlObjectListModel",   msg);
    qmlRegisterUncreatableType<QQmlVariantListModel>  (uri, maj, min, "QQmlVariantListModel",  msg);
    qmlRegisterUncreatableType<QAbstractItemModel>    (uri, maj, min, "QAbstractItemModel",    msg);
    qmlRegisterUncreatableType<QAbstractListModel>    (uri, maj, min, "QAbstractListModel",    msg);
    qmlRegisterUncreatableType<QAbstractProxyModel>   (uri, maj, min, "QAbstractProxyModel",    msg);

    qmlRegisterType<QQmlSortFilterProxyModel> (uri, maj, min, "SortFilterProxyModel");

    qmlRegisterUncreatableType<QtIrcSharedObject>     (uri, maj, min, "QtIrcSharedObject",     msg);

    qmlRegisterType<QtIrcServer>   (uri, maj, min, "QtIrcServer");
    qmlRegisterType<QtIrcChannel>  (uri, maj, min, "QtIrcChannel");
    qmlRegisterType<QtIrcMessage>  (uri, maj, min, "QtIrcMessage");
    qmlRegisterType<QtIrcIdentity> (uri, maj, min, "QtIrcIdentity");

    QQmlApplicationEngine engine;
    engine.rootContext ()->setContextProperty ("SharedObject", new QtIrcSharedObject (&engine));
    engine.load (QUrl ("qrc:/ui.qml"));

    foreach (QObject * obj, engine.rootObjects ()) {
        QQuickWindow * win = qobject_cast<QQuickWindow *> (obj);
        if (win != NULL) {
            win->setIcon (QIcon (":/img/logo.svg"));
        }
    }

    return app.exec ();
}

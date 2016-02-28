
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QUrl>

#include <QtQmlTricks>

#include "SharedObject.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QQmlApplicationEngine engine (&app);
    QQmlSvgIconHelper::setBasePath (":/icons");
    const char * uri = "QtLyricsChords";  // @uri QtLyricsChords
    const int    maj = 1;
    const int    min = 0;
    registerQtQmlTricksModule (&engine);
    qmlRegisterType<SongItem>  (uri, maj, min, "SongItem");
    qmlRegisterType<GroupItem> (uri, maj, min, "GroupItem");
    qmlRegisterType<LineItem>  (uri, maj, min, "LineItem");
    qmlRegisterType<ChordItem> (uri, maj, min, "ChordItem");
    qmlRegisterType<FileItem>  (uri, maj, min, "FileItem");
    qmlRegisterUncreatableType<ChordKey>     (uri, maj, min, "ChordKey",     "!!!");
    qmlRegisterUncreatableType<ChordVariant> (uri, maj, min, "ChordVariant", "!!!");
    qmlRegisterUncreatableType<ChordExtra>   (uri, maj, min, "ChordExtra",   "!!!");
    engine.addImportPath (QStringLiteral ("qrc:///libQtQmlTricks/import/"));
    engine.rootContext ()->setContextProperty ("Shared", new SharedObject (&engine));
    engine.load (QUrl ("qrc:///ui.qml"));
    return app.exec ();
}

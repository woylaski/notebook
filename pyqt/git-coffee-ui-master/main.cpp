
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QDebug>
#include <QFile>
#include <qqml.h>

#include "git2.h" // Just to ensure libgit2 is in include path !

#include "QQmlObjectListModel.h"
#include "QQmlVariantListModel.h"
#include "QtQmlTricksPlugin.h"

#include "SharedObject.h"
#include "QtGitDiffObject.h"
#include "QtGitRepository.h"
#include "QtGitStatusEntry.h"
#include "QtGitBranchEntry.h"
#include "QtGitRemoteEntry.h"
#include "QtGitCommitEntry.h"
#include "QtGitDeltaEntry.h"
#include "QtGitHunkEntry.h"
#include "QtGitLineEntry.h"
#include "QtGitTagEntry.h"

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    app.setApplicationName  (QStringLiteral ("GitUiQt5"));
    app.setOrganizationName (QStringLiteral ("TheBootroo"));
    SharedObject sharedObj (&app);
    qDebug () << "Using libgit2 :" << sharedObj.getGitLibVersion ();
    const char *  uri = "QtGit"; // @uri QtGit
    const int     maj = 5;
    const int     min = 0;
    const QString msg = QStringLiteral ("This object type can only be instanciated in the C++ code !!!");
    qmlRegisterUncreatableType<QQmlObjectListModelBase>  (uri, maj, min, "ObjectListModel",    msg);
    qmlRegisterUncreatableType<QQmlVariantListModel>     (uri, maj, min, "VariantListModel",   msg);
    qmlRegisterUncreatableType<SharedObject>             (uri, maj, min, "SharedObject",       msg);
    qmlRegisterType<QtGitDiffObject>                     (uri, maj, min, "DiffObject");
    qmlRegisterType<QtGitBranchEntry>                    (uri, maj, min, "BranchEntry");
    qmlRegisterType<QtGitCommitEntry>                    (uri, maj, min, "CommitEntry");
    qmlRegisterType<QtGitRemoteEntry>                    (uri, maj, min, "RemoteEntry");
    qmlRegisterType<QtGitStatusEntry>                    (uri, maj, min, "StatusEntry");
    qmlRegisterType<QtGitRepository>                     (uri, maj, min, "Repository");
    qmlRegisterType<QtGitDeltaEntry>                     (uri, maj, min, "DeltaEntry");
    qmlRegisterType<QtGitHunkEntry>                      (uri, maj, min, "HunkEntry");
    qmlRegisterType<QtGitLineEntry>                      (uri, maj, min, "LineEntry");
    qmlRegisterType<QtGitTagEntry>                       (uri, maj, min, "TagEntry");
    QQmlApplicationEngine engine;
    registerQtQmlTricksUiElements (&engine);
    engine.rootContext ()->setContextProperty ("Shared", &sharedObj);
    engine.load (QUrl ("qrc:/ui.qml"));
    foreach (QObject * obj, engine.rootObjects ()) {
        QQuickWindow * win = qobject_cast<QQuickWindow *> (obj);
        if (win != NULL) {
            QSurfaceFormat format = win->format ();
            format.setSamples (4);
            format.setSwapBehavior (QSurfaceFormat::TripleBuffer);
            win->setFormat (format);
        }
    }
    QStringList args = app.arguments ();
    qDebug () << "args=" << args;
    if (args.count () >= 2) {
        QString path = args.at (1);
        if (QFile::exists (path)) {
            qDebug () << "trying to open" << path;
            sharedObj.tryOpenGitRepository (path);
        }
        else {
            qDebug () << path << "doesn't exists !";
        }
    }
    if (!engine.rootObjects ().isEmpty ()) {
        return app.exec ();
    }
    else {
        return -1;
    }
}


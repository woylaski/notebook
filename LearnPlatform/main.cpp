#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <qqml.h>
#include <QTranslator>
#include <memory>

#include "src/creator/MessageHandler.h"
#include "src/creator/ProjectManager.h"
#include "src/creator/SyntaxHighlighter.h"

#include "src/fileio/fileio.h"
#include "src/tricks/qqmlsvgiconhelper.h"

#include "src/groupview/groupview.h"
#include "src/groupview/instancemodel.h"
#include "src/database/lmslistmodel.h"
#include "src/printer/printer.h"

#include "src/print-ml/MiniPage.h"
#include "src/print-ml/Printer.h"
#include "src/print-ml/PageSize.h"

#include "src/diskusage/filesystemwalker.h"
#include "src/gbyzanz/controller.h"

#include "src/imgviewer/filebackend.h"
#include "src/imgviewer/appeventfilter.h"

#include "src/devinfo/devinfo.h"
#include "src/network/network.h"

int main(int argc, char *argv[])
{
    //qInstallMessageHandler(&MessageHandler::handler);
    QApplication app(argc, argv);

    //Q_INIT_RESOURCE(images);

    //set application name and version
    app.setApplicationName("Learn-Work-Create");
    app.setApplicationVersion("0.01");
    app.setOrganizationName("LearnWorkCreate");
    app.setOrganizationDomain("LearnWorkCreate.com");
    app.setApplicationDisplayName(QObject::trUtf8("QML example AudioPlayer v%1. Author Ilya Petrash").arg(app.applicationVersion()));

#if QT_VERSION >= QT_VERSION_CHECK(5, 7, 0)
    app.setDesktopFileName("manu.app");
#endif

    //QTranslator translator;
    //translator.load("LWC_" + QLocale::system().name(), ":/resources/translations");
    //app.installTranslator(&translator);

    //FileBackend backend;
    //AppEventFilter filter(backend);
    //app.installEventFilter(&filter);

    // install translators
    //QTranslator translator;
    //translator.load("/usr/share/Gbyzanz/translations/gbyzanz_" + QLocale::system().name());
    //app.installTranslator(&translator);

    //register type for qml
    GroupView::registerTypes();
    qmlRegisterType<FileIO>("manu.fileio", 1, 0, "FileIO");
    qmlRegisterType<QQmlSvgIconHelper>("manu.svgicon", 1, 0, "SvgIconHelper");
    qmlRegisterSingletonType<ProjectManager>("ProjectManager", 1, 1, "ProjectManager", &ProjectManager::projectManagerProvider);
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 1, "SyntaxHighlighter");
    qmlRegisterType<LMSListModel>("manu.dblistmodel", 1, 0, "LMSListModel");
    qmlRegisterType<Printer>("manu.printer", 1, 0, "Printer");

    // @uri org.storyml.print
    qmlRegisterType<MiniPage>("manu.printml", 1, 0, "MiniPage");
    qmlRegisterType<Printer>("manu.printml", 1, 0, "Printer");
    qmlRegisterType<PageSize>("manu.printml", 1, 0, "PageSize");

    qmlRegisterType<Controller>("manu.gbyzanz", 1, 0, "Controller");
    qmlRegisterType<DevInfo>("manu.devinfo", 0, 1, "DevInfo");
    qmlRegisterType<Network>("manu.Network", 1, 0, "Network");

    //qml engine
    QQmlApplicationEngine engine;
    //AQmlEngine engine;
    //engine.addImportPath("qrc:/");
    //engine.addImportPath();
    //engine.addPluginPath();
    //engine->addImportPath ("qrc:/import");
/*
    QStringList arguments = QApplication::arguments();
    if (arguments.size() > 1) {
        arguments.removeFirst();
        backend.setArguments(arguments);
    }

#ifdef QT_DEBUG
    engine.rootContext()->setContextProperty("DEBUG", true);
#else
    engine.rootContext()->setContextProperty("DEBUG", false);
#endif

    QString aboutContents;
    QFile about("qrc:/about.html");
    if (about.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&about);
        aboutContents = in.readAll();
    }

    engine.rootContext()->setContextProperty("aboutContents", aboutContents);

    engine.rootContext()->setContextProperty("backend", &backend);
    qmlRegisterType<File>("manu.imgview", 0, 1, "File");
    qmlRegisterType<FileBackend>("manu.imgview", 0, 1, "FileBackend");
*/
    //QString	offlineStoragePath() const
    //void	setOfflineStoragePath(const QString &dir)
    QUrl offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    engine.setOfflineStoragePath("./");

    engine.rootContext()->setContextProperty("instancesModel", GroupView::makeProxy(new InstanceModel(&engine)));
    engine.rootContext()->setContextProperty ("Walker", new MyFileSystemWalker (&engine));

    const QStringList & musicPaths = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
    const QUrl musicUrl = QUrl::fromLocalFile(musicPaths.isEmpty() ? QDir::homePath() : musicPaths.first());
    engine.rootContext()->setContextProperty(QStringLiteral("musicUrl"), musicUrl);

    //const QStringList arguments = QCoreApplication::arguments();
    //const QUrl commandLineUrl = arguments.size() > 1 ? QUrl::fromLocalFile(arguments.at(1)) : QUrl();
    //engine.rootContext()->setContextProperty(QStringLiteral("url"), commandLineUrl);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}


#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <qqml.h>
#include <QTranslator>

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

int main(int argc, char *argv[])
{
    qInstallMessageHandler(&MessageHandler::handler);
    QApplication app(argc, argv);

    Q_INIT_RESOURCE(images);

    //set application name and version
    app.setApplicationName("Learn-Work-Create");
    app.setApplicationVersion("0.01");
    app.setOrganizationName("LearnWorkCreate");
    app.setOrganizationDomain("LearnWorkCreate.com");

    QTranslator translator;
    translator.load("LWC_" + QLocale::system().name(), ":/resources/translations");
    app.installTranslator(&translator);

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

    //qml engine
    QQmlApplicationEngine engine;
    //engine.addImportPath();
    //engine.addPluginPath();
    //engine->addImportPath ("qrc:/import");

    //QString	offlineStoragePath() const
    //void	setOfflineStoragePath(const QString &dir)
    QUrl offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    engine.setOfflineStoragePath("./");

    engine.rootContext()->setContextProperty("instancesModel", GroupView::makeProxy(new InstanceModel(&engine)));
    engine.rootContext ()->setContextProperty ("Walker", new MyFileSystemWalker (&engine));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}


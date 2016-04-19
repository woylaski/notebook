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

int main(int argc, char *argv[])
{
    qInstallMessageHandler(&MessageHandler::handler);
    QApplication app(argc, argv);

    //set application name and version
    app.setApplicationName("Learn-Work-Create");
    app.setApplicationVersion("0.01");
    app.setOrganizationName("LearnWorkCreate");
    app.setOrganizationDomain("LearnWorkCreate.com");

    QTranslator translator;
    translator.load("LWC_" + QLocale::system().name(), ":/resources/translations");
    app.installTranslator(&translator);

    //register type for qml
    //GroupView::registerTypes();
    qmlRegisterType<FileIO>("manu.fileio", 1, 0, "FileIO");
    qmlRegisterType<QQmlSvgIconHelper>("manu.svgicon", 1, 0, "SvgIconHelper");
    qmlRegisterSingletonType<ProjectManager>("ProjectManager", 1, 1, "ProjectManager", &ProjectManager::projectManagerProvider);
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 1, "SyntaxHighlighter");

    //qml engine
    QQmlApplicationEngine engine;
    //engine.addImportPath();
    //engine.addPluginPath();
    //engine->addImportPath ("qrc:/import");

    //QString	offlineStoragePath() const
    //void	setOfflineStoragePath(const QString &dir)
    QUrl offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    engine.setOfflineStoragePath("./");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}


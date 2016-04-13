#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <qqml.h>
#include "src/fileio/fileio.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //set application name and version
    app.setApplicationName("Learn-Work-Create");
    app.setApplicationVersion("0.01");

    //register type for qml
    qmlRegisterType<FileIO>("manu.fileio", 1, 0, "FileIO");

    QQmlApplicationEngine engine;
    //engine.addImportPath();
    //engine.addPluginPath();
    //engine->addImportPath ("qrc:/import");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}


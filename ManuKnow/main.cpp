#include "src/manu_workenv.h"
#include "src/manu_plugins.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QStringList arguments = QApplication::arguments();
    qDebug()<<arguments.size()<<arguments;

    //set application name and version
    setAppInfo(app);
    //language translator
    loadTranslator(app);

    QQmlApplicationEngine engine;
    printSysPathInfo(engine);
    setLocalStoragePath(engine, getWorkPath());

    registerManuPlugins();

    engine.rootContext()->setContextProperty ("appTitle", APP_NAME);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //set application name and version
    app.setApplicationName("ManuKnow-Everything");
    app.setApplicationVersion("0.0.1");
    app.setOrganizationName("MuoDouDong");
    app.setOrganizationDomain("MuoDouDong.com");
    app.setApplicationDisplayName(QObject::trUtf8("Manu knowledge manager v%1. Author JiaYuan Zhang").arg(app.applicationVersion()));

    //QWindow::setIcon(QIcon(":/images/1.png"));
    //QDeclarativeView view;
    //view.setWindowIcon(QIcon(":/qml/GenericHostApplicationQML/content/pics/TXE.ico")‌​)

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

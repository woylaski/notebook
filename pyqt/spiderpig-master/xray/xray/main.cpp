#include "simulator.h"
#include "tsh.h"
#include "server.h"
#include "gui/mainwindow.h"

#include <QApplication>
#include <QDebug>

const int DefaultPort = 8888;

void startServer(int port)
{
    qDebug() << "Running tsh server on port " << port;
    Server * server = new Server(port);

    MainWindow * mainWindow = new MainWindow(server);
    mainWindow->resize(800, 600);
    mainWindow->show();
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    int port = DefaultPort;
    if (argc > 1)
        port = QString(argv[1]).toInt();

    if (port)
        startServer(port);
    else
    {
        qDebug() << "Not able to run tsh server. Invalid port " << argv[1];
        exit(1);
    }
    return app.exec();
}

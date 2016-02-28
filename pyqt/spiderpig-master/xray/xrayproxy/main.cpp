#include <QCoreApplication>

#include <QString>

#include "tshproxy.h"


void startProxy(QString host, int port)
{
    qDebug() << "Starting tsh proxy on " << host << " port " << port;
    TshProxy * proxy = new TshProxy;
    proxy->start(host, port);
}

int main(int argc, char *argv[])
{
    QString host = "127.0.0.1";
    int port = 8888;

    if (argc > 1)
        host = argv[1];
    if (argc > 2)
        port = QString(argv[2]).toInt();

    if ( ! port)
    {
        qDebug() << "Unable to start tsh proxy on port "  << argv[2];
        return 1;
    }

    QCoreApplication a(argc, argv);
    startProxy(host, port);
    return a.exec();
}

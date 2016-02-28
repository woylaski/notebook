#ifndef CLIENTSOCKET_H
#define CLIENTSOCKET_H

#include <QtNetwork>
#include <QObject>
#include <QString>

class TcpSocket;
class QFile;
class QTimer;

class TshProxy: public QObject
{
    Q_OBJECT

public:
    TshProxy(QObject* parent = 0);
    ~TshProxy();
    void start(QString address, quint16 port);

public slots:
    void onSendDataToClient(QByteArray data);

private slots:
    void onDataFromClientReceived();
    void onDataFromServerReceived();
    void exit();
    void onConnected();

private:
    void appendToFile(QByteArray text);

private:
    void createLogFile();

    QTcpSocket * m_clientSocket;
    QTcpSocket * m_serverSocket;
    QFile * m_logFile;
    QTimer * m_connectionTimeout;
};

#endif // CLIENTSOCKET_H

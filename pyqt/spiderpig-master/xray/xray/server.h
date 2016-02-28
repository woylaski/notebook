#ifndef SERVER_H
#define SERVER_H

#include "message.h"

#include <QtNetwork>
#include <QObject>

class Tsh;
class LogModel;
class Recorder;
class QTcpServer;
class QTcpSocket;

class Server: public QObject
{
    Q_OBJECT

public:
    Server(int port, QObject * parent = 0);
    ~Server();

    void connectTsh(Tsh * tsh);
    LogModel * commands() const {return m_commands;}
    LogModel * replies() const {return m_replies;}
    Tsh * tsh() const { return m_tsh;}
    bool forwardRepliesToClient() const {return m_forwardRepliesToClient;}

signals:
    void clientConnected(QString name);
    void clientDisconnected();

public slots:
    void sendCustomDataToTsh(QByteArray data);
    void sendCustomDataToClient(QByteArray);
    void setForwardRepliesToClient(bool enabled) {m_forwardRepliesToClient = enabled;}
    void startRecording(QString dir);
    void stopRecording();

private slots:
    void acceptClientConnection();
    void onClientInput();
    void onCommandReceived(Message message);
    void onReplyReceived(Message message);
    void guiDisconnected();
    void sendClientInitCommands();

private:
    void sendCommand(Message command);

    QTcpServer * m_server;
    QTcpSocket * m_client;
    Tsh * m_tsh;
    LogModel * m_commands;
    LogModel * m_replies;
    bool m_forwardRepliesToClient;
    Recorder * m_recorder;
};

#endif

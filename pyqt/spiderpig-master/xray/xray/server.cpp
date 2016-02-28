#include "server.h"

#include "server.h"
#include "tsh.h"
#include "logmodel.h"
#include "simulator.h"
#include "recorder.h"

#include <iostream>

#include <QTimer>
#include <QTcpServer>
#include <QTcpSocket>

using namespace std;

Server::Server(int port, QObject* parent): QObject(parent)
  , m_server(new QTcpServer(this))
  , m_client(0)
  , m_tsh(0)
  , m_commands(new LogModel(this))
  , m_replies(new LogModel(this))
  , m_forwardRepliesToClient(true)
  , m_recorder(new Recorder(this))
{
    connect(m_server, SIGNAL(newConnection()), this, SLOT(acceptClientConnection()));
    m_server->listen(QHostAddress::Any, port);

    connect(m_commands, SIGNAL(commandSaved(Message)), m_recorder, SLOT(onNewCommand(Message)));
    connect(m_replies, SIGNAL(replySaved(Message)), m_recorder, SLOT(onNewReply(Message)));
}

Server::~Server()
{
    m_server->close();
    qDebug() << "Destroying server";
}

void Server::connectTsh(Tsh *tsh)
{
    if (m_tsh)
        delete m_tsh;

    m_tsh = tsh;
    connect(tsh, SIGNAL(replyReceived(Message)), SLOT(onReplyReceived(Message)));

    m_replies->removeAllItems();
    m_commands->removeAllItems();

    m_tsh->start();

    bool aClientIsAlreadyConnectedAndInitiated = (m_client != 0);
    if (aClientIsAlreadyConnectedAndInitiated)
        QTimer::singleShot(1000, this, SLOT(sendClientInitCommands()));
}

void Server::startRecording(QString dir)
{
    m_recorder->startRecording(dir);
}

void Server::stopRecording()
{
    m_recorder->stopRecording();
}

void Server::acceptClientConnection()
{
    qDebug() << "Tsh server: accepting connection...";
    if (m_client != 0)
    {
        qDebug() << "Disconnecting previous gui client";
        m_client->disconnectFromHost();
        emit clientDisconnected();
    }

    m_client = m_server->nextPendingConnection();
    connect(m_client, SIGNAL(readyRead()), this, SLOT(onClientInput()));
    connect(m_client, SIGNAL(disconnected()), this, SLOT(guiDisconnected()));
    emit clientConnected("");
    if (m_tsh)
        m_tsh->sendWelcomeMessage();
}

void Server::guiDisconnected()
{
    emit clientDisconnected();
    qDebug() << "Gui disconnected";
}

void Server::sendClientInitCommands() {
    if (!m_tsh)
        return;

    m_tsh->processCommand("echo off \n");
    m_tsh->processCommand("xpreferences apiversion 2 \n");
    m_tsh->processCommand("xpreferences outputmode xml \n");
    m_tsh->processCommand("xfeedback register status \n");
    m_tsh->processCommand("xfeedback register config \n");
    m_tsh->processCommand("xfeedback register event \n");
    m_tsh->processCommand("xstatus \n");
    m_tsh->processCommand("xconfig \n");
    m_tsh->processCommand("xgetxml command \n");

    /*
    echo off
    xpreferences apiversion 2
    xpreferences outputmode xml
    xfeedback register status
    xfeedback register config
    xfeedback register event
    xstatus
    xconfig
    xgetxml command
    */
}

void Server::onClientInput()
{
    while (m_client->canReadLine())
    {
        QByteArray text = m_client->readLine();
        onCommandReceived(Message::createCommand(text));
    }
}

void Server::onCommandReceived(Message command)
{
    m_commands->onCommandParsed(command);
    if (m_tsh)
        m_tsh->processCommand(command.data);
}

void Server::onReplyReceived(Message message)
{
    m_replies->onResultParsed(message);
    if (m_client && m_forwardRepliesToClient)
        m_client->write(message.data.trimmed() + "\n");
}

void Server::sendCustomDataToTsh(QByteArray data)
{
    QList<QByteArray> lines = data.split('\n');
    foreach( QByteArray line, lines )
        onCommandReceived(Message::createCommand(line));
}

void Server::sendCustomDataToClient(QByteArray data)
{
    onReplyReceived(Message::createReply(data));
}

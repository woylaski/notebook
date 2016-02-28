#include "tshproxy.h"

#include <QHostAddress>
#include <QTcpSocket>
#include <QProcessEnvironment>
#include <QTimer>

#include <iostream>

namespace
{
    const int TimeoutConnectionMs = 10 * 1000;
}

TshProxy::TshProxy(QObject* parent): QObject(parent),
    m_logFile(0)
  , m_connectionTimeout(new QTimer(this))
{
    m_serverSocket = new QTcpSocket(this);
    m_clientSocket = new QTcpSocket(this);

    //createLogFile();

    connect(m_serverSocket, SIGNAL(connected()), SLOT(onConnected()));
    connect(m_serverSocket, SIGNAL(readyRead()), SLOT(onDataFromServerReceived()));
    connect(m_clientSocket, SIGNAL(readyRead()), SLOT(onDataFromClientReceived()));
    connect(m_serverSocket, SIGNAL(disconnected()), SLOT(exit()));
    connect(m_clientSocket, SIGNAL(disconnected()), SLOT(exit()));

    m_connectionTimeout->setSingleShot(true);
    connect(m_connectionTimeout, SIGNAL(timeout()), this, SLOT(exit()));
    m_connectionTimeout->setInterval(TimeoutConnectionMs);

    m_clientSocket->setSocketDescriptor(0);
}

TshProxy::~TshProxy()
{
    qDebug() << "Killing proxy";
    m_serverSocket->close();

    if (m_logFile)
    {
        m_logFile->close();
    }
}

void TshProxy::exit()
{
    qDebug() << "No connection to tsh server. Exiting";
    qApp->quit();
}

void TshProxy::onConnected()
{
    m_connectionTimeout->stop();
}

void TshProxy::createLogFile()
{
    //QString logFile = QProcessEnvironment::systemEnvironment().value("TSH_LOG_FILE", "");
    QString logFile = "/tmp/tsh.log";
    if (logFile.isEmpty())
        return;

    m_logFile = new QFile(logFile);
    if (! m_logFile->open(QIODevice::WriteOnly | QFile::Truncate))
    {
        qWarning() << "Couldn't save to log file";
    }
    m_logFile->close();

}

void TshProxy::start(QString address, quint16 port)
{
    QHostAddress addr(address);
    m_serverSocket->connectToHost(addr, port);

    m_connectionTimeout->start();
}

void TshProxy::onSendDataToClient(QByteArray data)
{
    std::cout << QString(data).toStdString() << std::endl;
}

void TshProxy::onDataFromServerReceived()
{
    while (m_serverSocket->canReadLine())
    {
        QByteArray data = m_serverSocket->readLine();
        std::cout << QString(data).toStdString() << std::endl;

        if (m_logFile)
            appendToFile("SERVER:  " + data);
    }
}

void TshProxy::onDataFromClientReceived()
{
    while (m_clientSocket->canReadLine())
    {
        QByteArray data = m_clientSocket->readLine();
        m_serverSocket->write(data);

        if (m_logFile)
            appendToFile("GUI:  " + data);
    }
}

void TshProxy::appendToFile(QByteArray text)
{
    if (m_logFile)
    {
        m_logFile->open(QIODevice::Append);
        m_logFile->write(text);
        m_logFile->close();
    }
}

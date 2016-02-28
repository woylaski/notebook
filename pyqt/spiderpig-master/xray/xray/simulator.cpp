#include "simulator.h"

#include "recorder.h"
#include "parser.h"

#include <iostream>
#include <QTimer>
#include <QFile>
#include <QDebug>

namespace {

    const int SimulatedNetworkDelayMs = 100;

    QByteArray readFile(QString filename)
    {
        QFile file(filename);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            return "";
        }

        QByteArray data = file.readAll();
        return data.trimmed();
    }
}

Simulator::Simulator(QObject *parent) :
    Tsh(parent)
  , m_msgCount(0)
  , m_parser(new Parser(this))
{
    connect(m_parser, SIGNAL(resultParsed()), SLOT(onReplyParsed()));
}

void Simulator::start()
{
}

void Simulator::onReplyParsed()
{
    emit replyReceived(m_parser->latestReply());
}

void Simulator::sendWelcomeMessage()
{
    sendData(getWelcomeMessage());
}

void Simulator::processCommand(QByteArray command)
{
    m_msgCount++;

    if (command.toLower().startsWith("bye"))
    {
        emit quit();
    }

    QString file = Recorder::makeMessageName(command);
    QByteArray response = readFile(m_currentDirectory + "/" + file);
    if (! response.isEmpty())
        sendData(response);
    else
        qDebug() << "No simulator file found for " << file;
    return;

}

void Simulator::sendFile(QString filename)
{
    sendData(readFile(filename));
}

void Simulator::sendData(QByteArray data)
{
    QList<QByteArray> lines = data.split('\n');
    foreach( QByteArray line, lines )
    {
        m_parser->parseResult("\n" + line + "\n");
    }
}

QByteArray Simulator::getWelcomeMessage() const
{
    return readFile("/touchmenu/simulator/Welcome.txt");
}

QByteArray Simulator::emptyMessage(int resultId) const
{
    QString msg = "<XmlDoc resultId=\"" + QString::number(resultId) + "\">\n</XmlDoc>";
    return msg.toAscii();
}

#include "codecproxy.h"

#include "parser.h"

#include <QProcess>
#include <QDebug>

CodecProxy::CodecProxy(QString host, QString username, QObject *parent) :
    Tsh(parent)
  , m_tsh(new QProcess(this))
  , m_username(username)
  , m_host(host)
  , m_parser(new Parser(this))
{
    connect(m_parser, SIGNAL(resultParsed()), SLOT(onReplyParsed()));
}

CodecProxy::~CodecProxy()
{}

void CodecProxy::onReplyParsed()
{
    emit replyReceived(m_parser->latestReply());
}

void CodecProxy::processCommand(QByteArray command)
{
    char requiredDelimiterForCodec = '\n';
    m_tsh->write(command.trimmed() + requiredDelimiterForCodec);
}

void CodecProxy::sendWelcomeMessage()
{
    emit replyReceived(Message::createCommand("OK\n"));
}

void CodecProxy::start()
{
    connectToCodec(m_host, m_username);
}

void CodecProxy::connectToCodec(QString host, QString username)
{
    QString program = "ssh";
    QStringList args;
    args << username + "@" + host;

    connect(m_tsh, SIGNAL(readyRead()), SLOT(onIncomingData()));

    m_tsh->start(program, args);
}


void CodecProxy::onIncomingData()
{
    while (m_tsh->canReadLine())
    {
        QByteArray data = m_tsh->readLine();
        m_parser->parseResult(data);
    }
}

#include "parser.h"

#include <QRegExp>
#include <QDebug>


namespace
{
    QString searchForId(QByteArray text)
    {
        QRegExp resultIdSearch("resultId=\"(\\d+)\"");
        QString id = "-1";
        if (resultIdSearch.indexIn(text) > -1)
            id = resultIdSearch.cap(1);

        return id;
    }
}

Parser::Parser(QObject * parent)
    : QObject(parent)
    , m_state(WAITING_FOR_STARTTAG)
{}

Parser::~Parser() {}

void Parser::parseResult(QByteArray line)
{
    if (m_state == WAITING_FOR_STARTTAG && line.contains("<XmlDoc") && line.contains("</XmlDoc"))
    {
        Message m;
        m.data = line;
        evaluateParsedReply(m);
        m_state = WAITING_FOR_STARTTAG;
    }
    else if (m_state == WAITING_FOR_STARTTAG && line.contains("<XmlDoc"))
    {
        m_currentReply = Message();
        m_currentReply.data.append(line);
        m_state = PARSING_MESSAGE;
    }
    else if (m_state == WAITING_FOR_STARTTAG)
    {
        // this is one-line, non-xml message (typically "Welcome to codec" or similar)
        m_currentReply = Message();
        m_currentReply.data = line;
        evaluateParsedReply(m_currentReply);
        m_state = WAITING_FOR_STARTTAG;
    }
    else if (m_state == PARSING_MESSAGE)
    {
        m_currentReply.data.append(line);
        if (line.contains("</Xml"))
        {
            m_state = WAITING_FOR_STARTTAG;
            evaluateParsedReply(m_currentReply);
        }
    }
}

void Parser::evaluateParsedReply(Message msg)
{
    msg.commandId = searchForId(msg.data.left(100));
    msg.name = Message::parseReplyName(msg.data);
    msg.data = msg.data.trimmed();
    m_latestParsedReply = msg;
    emit resultParsed();
}

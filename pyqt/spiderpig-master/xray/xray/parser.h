#ifndef PARSER_H
#define PARSER_H

#include "message.h"

#include <QObject>

class Parser : public QObject
{
    Q_OBJECT

    enum ResultParsingState {
        WAITING_FOR_STARTTAG, PARSING_MESSAGE
    };

public:
    explicit Parser(QObject * parent = 0);
    virtual ~Parser();

    Message latestReply() {return m_latestParsedReply;}

public slots:
    void parseResult(QByteArray line);

signals:
    void resultParsed();

private:
    void evaluateParsedReply(Message msg);

    Message m_latestParsedReply;
    Message m_currentReply;
    ResultParsingState m_state;
};


#endif // PARSER_H

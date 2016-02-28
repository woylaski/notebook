#ifndef MESSAGE_H
#define MESSAGE_H

#include <QString>
#include <QByteArray>
#include <QRegExp>

class Message
{
public:
    QString name;
    QString commandId;
    QByteArray data;

    static Message createCommand(QByteArray command)
    {
        Message msg;
        msg.data = command.trimmed();
        msg.name = msg.data;
        return msg;
    }

    static Message createReply(QByteArray reply)
    {
        Message msg;
        msg.data = reply.trimmed();
        msg.name = parseReplyName(reply);
        return msg;
    }

    static QByteArray parseReplyName(QByteArray text)
    {
        QByteArray match = "";
        QRegExp pattern("<XmlDoc.*>\\s*<(\\S*)(.*)>");
        pattern.setMinimal(true);
        if (pattern.indexIn(text) > -1)
            match = pattern.cap(1).toAscii().trimmed();
        else
            match = text.left(50).trimmed();

        if (match == "/XmlDoc")
            match = "(Empty result)";

        return match;
    }
};

#endif // MESSAGE_H

#ifndef CODECPROXY
#define CODECPROXY

#include "tsh.h"
#include "message.h"

#include <QObject>

class QProcess;
class Parser;

class CodecProxy : public Tsh
{
    Q_OBJECT

public:
    explicit CodecProxy(QString host, QString username, QObject *parent = 0);
    virtual ~CodecProxy();

    void processCommand(QByteArray command);
    void start();
    void sendWelcomeMessage();
    QString host() const {return m_host;}
    QString username() const {return m_username;}

signals:
    void replyReceived(Message reply);
    void quit();

private slots:
    void onIncomingData();
    void onReplyParsed();

private:
    void connectToCodec(QString host, QString username);

    QProcess * m_tsh;
    QString m_username;
    QString m_host;
    Parser * m_parser;
};

#endif

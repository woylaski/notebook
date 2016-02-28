#ifndef TSH_H
#define TSH_H

#include "message.h"

#include <QByteArray>
#include <QObject>

class Tsh : public QObject
{
    Q_OBJECT

public:
    Tsh(QObject * parent = 0);
    virtual ~Tsh();

    virtual void processCommand(QByteArray command) = 0;
    virtual void start() = 0;
    virtual void sendWelcomeMessage() = 0;

// signals:
//    void replyReceived(Message reply) = 0;
//    void quit() = 0;
};

#endif // TSH_H

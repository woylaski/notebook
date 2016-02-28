#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "tsh.h"
#include "message.h"

#include <QObject>

class Parser;

class Simulator : public Tsh
{
    Q_OBJECT

public:
    explicit Simulator(QObject *parent = 0);
    virtual ~Simulator() {}
    void processCommand(QByteArray command);
    void start();
    void sendWelcomeMessage();
    void setDirectory(QString directory) {m_currentDirectory = directory;}

signals:
    void replyReceived(Message reply);
    void quit();

public slots:

private slots:
    void onReplyParsed();

private:
    void outputFile(QString filename);
    void sendData(QByteArray data);
    void sendFile(QString filename);
    QByteArray emptyMessage(int resultId) const;
    QByteArray getWelcomeMessage() const;

    int m_msgCount;
    QString m_currentDirectory;
    Parser * m_parser;
};

#endif // SIMULATOR_H

#ifndef RECORDER_H
#define RECORDER_H

#include "message.h"

#include <QObject>

class Recorder : public QObject
{
    Q_OBJECT
public:
    explicit Recorder(QObject *parent = 0);
    static QString makeMessageName(QString command);

signals:

public slots:
    void startRecording(QString directory);
    void stopRecording();
    void onNewCommand(Message msg);
    void onNewReply(Message msg);

private:
    QString m_currentRecordingDirectory;
    QString m_currentRecordingFile;
};

#endif // RECORDER_H

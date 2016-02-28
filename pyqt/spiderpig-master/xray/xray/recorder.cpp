#include "recorder.h"

#include <QFile>
#include <QDebug>


Recorder::Recorder(QObject *parent) :
    QObject(parent)
{
}

QString Recorder::makeMessageName(QString command)
{
    int firstPipe = command.indexOf('|');
    if (firstPipe > -1)
        command = command.left(firstPipe);

    int firstColon = command.indexOf(':');
    if (firstColon > -1)
        command = command.left(firstColon);

    return command.trimmed().replace(" ", "_").replace("\"", "") + ".xml";
}

void Recorder::startRecording(QString directory) {
    m_currentRecordingDirectory = directory;
}

void Recorder::stopRecording() {
    m_currentRecordingDirectory = "";
}

void Recorder::onNewCommand(Message msg)
{
    m_currentRecordingFile = m_currentRecordingDirectory + "/" + makeMessageName(msg.data);
}

void Recorder::onNewReply(Message msg)
{
    if (m_currentRecordingDirectory.isEmpty())
        return;

    QFile file(m_currentRecordingFile);
    if (! file.open(QIODevice::Append))
    {
        qWarning() << "Couldn't save to " << m_currentRecordingFile;
    }

    file.write(msg.data.trimmed() + "\n\n");
}

#include "logmodel.h"

#include <QStringList>

LogModel::LogModel(QObject *parent) :
    QAbstractListModel(parent)
  , m_filterFrequentMessages(true)
  , m_messageCount(0)
{
}

int LogModel::rowCount(const QModelIndex &) const
{
    return m_messages.size();
}

QVariant LogModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() >= m_messages.size())
        return QVariant();

    if (role == Qt::DisplayRole)
        return m_messages.at(index.row()).name;
    else
        return QVariant();
}

Message LogModel::message(const QModelIndex &index)
{
    if (index.isValid() && index.row() < m_messages.size())
        return m_messages.at(index.row());

    Message empty;
    return empty;
}

bool LogModel::shouldBeFiltered(Message msg)
{
    if (msg.name == "Command")
        return false; // The command status is vital and will match almost any regexp, so don't filter

    if (msg.name == "Event")
    {
        if (msg.data.contains("BYODSnapshotTaken") || msg.data.contains("WebSnapshotTaken") || msg.data.contains("MailLEDEvent"))
            return true;
    }

    // Don't want to filter away the main status message, only the ones that _only_ contain diagnostics stuff
    else if (msg.name == "Status" && msg.data.contains("Diagnostics") && ! msg.data.contains("SystemUnit"))
        return true;

    else if (msg.name == "PeripheralsHeartBeatResult")
        return true;
    else if (msg.name.contains("xcommand Experimental Peripherals HeartBeat") // Pralines
             || msg.name.contains("xcom Experimental Peripherals HeartBeat")) // Ocean
        return true;
    else if (msg.name == "ResetResult")
        return true;
    else if (msg.name.contains("xcommand Experimental TakeWebSnapshot"))
        return true;
    else if (msg.name == "TakeWebSnapshotResult")
        return true;
    else if (msg.name.contains("xcom Standby ResetTimer Delay"))
        return true;
    else if (msg.name == "")
        return true;

    return false;
}

void LogModel::onResultParsed(Message msg)
{
    if (m_filterFrequentMessages && shouldBeFiltered(msg))
        return;

    msg.name = QString("%1. %2").arg(++m_messageCount).arg(msg.name);
    m_messages.append(msg);
    emit replySaved(msg);
    emit layoutChanged();
}

void LogModel::onCommandParsed(Message msg)
{
    if (m_filterFrequentMessages && shouldBeFiltered(msg))
        return;

    msg.name = QString("%1. %2").arg(++m_messageCount).arg(msg.name);
    m_messages.append(msg);
    emit commandSaved(msg);
    emit layoutChanged();
}

void LogModel::removeAllItems()
{
    m_messages.clear();
    m_messageCount = 0;
    emit layoutChanged();
}



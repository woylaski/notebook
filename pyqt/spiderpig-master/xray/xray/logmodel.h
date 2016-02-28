#ifndef LOGMODEL_H
#define LOGMODEL_H

#include "message.h"

#include <QAbstractListModel>
#include <QObject>
#include <QList>

class LogModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit LogModel(QObject *parent = 0);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    void removeAllItems();
    Message message(const QModelIndex &index);
    void filterFrequentMessages(bool enabled) {m_filterFrequentMessages = enabled;}
    void onResultParsed(Message msg);
    void onCommandParsed(Message msg);

signals:
    void commandSaved(Message command);
    void replySaved(Message reply);

private:
    bool shouldBeFiltered(Message msg);

    QList<Message> m_messages;
    bool m_filterFrequentMessages;
    Message m_currentReply;
    int m_messageCount;
};

#endif

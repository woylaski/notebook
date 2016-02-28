#ifndef LOGVIEWER_H
#define LOGVIEWER_H

#include <QWidget>

namespace Ui {
    class LogViewer;
}

class LogModel;
class QModelIndex;

class LogViewer : public QWidget
{
    Q_OBJECT
    
public:
    explicit LogViewer(LogModel * commands, LogModel * replies, QWidget *parent = 0);
    ~LogViewer();

signals:
    void sendCustomCommandToCodec(QByteArray command);
    void sendCustomReplyToClient(QByteArray reply);

public slots:
    void on_saveReplies_clicked();
    void on_saveCommands_clicked();
    void on_clearCommands_clicked();
    void on_clearReplies_clicked();
    void on_sendToCodec_clicked();
    void on_sendToClient_clicked();

private slots:
    void onReplySelected(const QModelIndex &);
    void onCommandSelected(const QModelIndex &);
    void clearReplyContentBox();
    void clearCommandContentBox();
    void onReplySelectionChanged();
    void onCommandSelectionChanged();

private:
    bool writeRepliesToFile(QString fileName);
    bool writeCommandsToFile(QString fileName);

    Ui::LogViewer *ui;
    LogModel * m_commands;
    LogModel * m_replies;
};

#endif // LOGVIEWER_H

#ifndef MESSAGEBROWSER_H
#define MESSAGEBROWSER_H

#include <QWidget>
#include <QString>

namespace Ui{
    class Form;
}
class QModelIndex;


class MessageBrowser : public QWidget
{
    Q_OBJECT

public:
    explicit MessageBrowser(QWidget *parent = 0);
    virtual ~MessageBrowser();

signals:
    void sendCustomReply(QByteArray data);

public slots:

private slots:
    void on_chooseDirectory_clicked();
    void on_sendMessage_clicked();
    void on_saveToFile_clicked();
    void onFileClicked(const QModelIndex &);
    void onFileDoubleClicked(const QModelIndex &);

private:
    void loadDirectory(QString directory);
    void saveLastDir(QString dir);
    QString loadLastDir() const;

    Ui::Form * m_messageBrowser;
    QString m_currentPath;
};

#endif // MESSAGEBROWSER_H

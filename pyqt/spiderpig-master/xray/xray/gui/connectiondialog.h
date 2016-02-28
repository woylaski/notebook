#ifndef CONNECTIONDIALOG_H
#define CONNECTIONDIALOG_H

#include <QWidget>

namespace Ui {
class connectionDialog;
}

class ConnectionDialog : public QWidget
{
    Q_OBJECT
    
public:
    explicit ConnectionDialog(QWidget *parent = 0);
    ~ConnectionDialog();

    bool isCodecSelected() const;
    QString codecIp() const;
    QString username() const;

public slots:
    void simulatorConnected(QString dir);
    void codecConnected(QString host, QString username);

private slots:
    void saveValues();
    void onConnectClicked();
    void onSimulatorDirectoryClicked();

signals:
    void simulatorSelected(QString dir);
    void codecSelected(QString host, QString username);
    void connectClicked();

private:
    Ui::connectionDialog *ui;
};

#endif // CONNECTIONDIALOG_H

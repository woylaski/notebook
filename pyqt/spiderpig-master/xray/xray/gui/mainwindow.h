#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

class Server;
class QCloseEvent;
class QAction;
class QCheckBox;

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(Server * server, QWidget *parent = 0);
    virtual ~MainWindow();

public slots:
    void showConnectionDialog();

protected:
    void closeEvent(QCloseEvent *event);

private slots:
    void codecSelected(QString host, QString username);
    void simulatorSelected(QString dir);
    void openMessageBrowser();
    void toggleFilter(bool);
    void recordingToggled(bool enabled);
    void clientConnected(QString name);
    void clientDisconnected();

private:
    void setupMenuBar();

    bool m_isShowingConnectDialog;
    Server * m_server;
    QWidget * m_messageBrowser;
    QAction * m_connectionButton;
    QCheckBox * m_recordingCheckbox;
};

#endif // MAINWINDOW_H

#include "mainwindow.h"

#include "gui/logviewer.h"
#include "server.h"
#include "simulator.h"
#include "codecproxy.h"
#include "messagebrowser.h"
#include "connectiondialog.h"
#include "logmodel.h"
#include "settings.h" // TODO shouldnt be necessary

#include <QToolBar>
#include <QAction>
#include <QString>
#include <QStatusBar>
#include <QDialog>
#include <QList>
#include <QInputDialog>
#include <QHBoxLayout>
#include <QCheckBox>
#include <QFileDialog>

#include <QDebug>

MainWindow::MainWindow(Server * server, QWidget *parent) :
    QMainWindow(parent)
  , m_isShowingConnectDialog(false)
  , m_server(server)
  , m_messageBrowser(0)
  , m_connectionButton(0)
{
    LogViewer * logViewer = new LogViewer(server->commands(), server->replies(), this);
    setCentralWidget(logViewer);

    connect(logViewer, SIGNAL(sendCustomReplyToClient(QByteArray)),
            m_server, SLOT(sendCustomDataToClient(QByteArray)));
    connect(logViewer, SIGNAL(sendCustomCommandToCodec(QByteArray)),
            m_server, SLOT(sendCustomDataToTsh(QByteArray)));
    connect(m_server, SIGNAL(clientConnected(QString)),
            this, SLOT(clientConnected(QString)));
    connect(m_server, SIGNAL(clientDisconnected()),
            this, SLOT(clientDisconnected()));

    setupMenuBar();
    clientDisconnected();
}

MainWindow::~MainWindow()
{
}

void MainWindow::setupMenuBar()
{
    QToolBar* simulator = addToolBar("Simulator");
    simulator->setMovable(false);

    QAction * connectionDialog = new QAction("(No connection)", this);
    connectionDialog->setShortcut(tr("Ctrl+o"));
    connectionDialog->setToolTip("Show connection dialog (Ctrl+o)");
    connect(connectionDialog, SIGNAL(triggered()), SLOT(showConnectionDialog()));

    QAction * openMessageBrowser = new QAction("&Message files", this);
    openMessageBrowser->setShortcut(tr("Ctrl+m"));
    openMessageBrowser->setToolTip("Show message browser (Ctrl+m)");
    connect(openMessageBrowser, SIGNAL(triggered()), SLOT(openMessageBrowser()));

    QCheckBox * filter = new QCheckBox("Filter");
    filter->setShortcut(tr("Ctrl+f"));
    filter->setToolTip("Filter frequent periodic messages such as heartbeat, resettimer etc (Ctrl+f)");
    filter->setChecked(true);
    connect(filter, SIGNAL(toggled(bool)), SLOT(toggleFilter(bool)));

    QCheckBox * sendBackReplies = new QCheckBox("Send back replies");
    sendBackReplies->setToolTip("Send replies back to client. Turn off to modify them and send back manually instead.");
    sendBackReplies->setChecked(m_server->forwardRepliesToClient());
    connect(sendBackReplies, SIGNAL(toggled(bool)), m_server, SLOT(setForwardRepliesToClient(bool)));

    QCheckBox * recording = new QCheckBox("Recording");
    recording->setToolTip("Record all replies from codec/simulator to a file automatically naming they by associated command (Ctrl+r)");
    recording->setShortcut(tr("Ctrl+r"));
    connect(recording, SIGNAL(toggled(bool)), SLOT(recordingToggled(bool)));
    m_recordingCheckbox = recording;

    simulator->addAction(connectionDialog);
    simulator->addSeparator();
    simulator->addAction(openMessageBrowser);
    simulator->addSeparator();
    simulator->addWidget(filter);
    simulator->addSeparator();
    simulator->addWidget(sendBackReplies);
    simulator->addSeparator();
    simulator->addWidget(recording);

    m_connectionButton = connectionDialog;
}

void MainWindow::recordingToggled(bool enabled)
{
    if (enabled)
    {
        QString current = Settings::getInstance().lastDir();
        QString directory = QFileDialog::getExistingDirectory(this, "Choose directory to record to. Warning: Will overwrite existing files", current);
        if (! directory.isEmpty())
        {
            m_server->startRecording(directory);
            Settings::getInstance().saveLastDir(directory);
        }
        else
            m_recordingCheckbox->setChecked(false);
    }
    else
        m_server->stopRecording();
}

void MainWindow::toggleFilter(bool enabled)
{
    m_server->commands()->filterFrequentMessages(enabled);
    m_server->replies()->filterFrequentMessages(enabled);
}

void MainWindow::showConnectionDialog()
{
    QDialog window;
    ConnectionDialog dialog(&window);

    connect(&dialog, SIGNAL(simulatorSelected(QString)), this, SLOT(simulatorSelected(QString)));
    connect(&dialog, SIGNAL(codecSelected(QString,QString)), this, SLOT(codecSelected(QString,QString)));
    connect(&dialog, SIGNAL(connectClicked()), &window, SLOT(accept()));

    // init the current connection value
    // TODO this is some crappy stuff; remove or change the way we do connections
    if (qobject_cast<Simulator *>(m_server->tsh()))
        dialog.simulatorConnected(Settings::getInstance().lastDir());
    else if (qobject_cast<CodecProxy *>(m_server->tsh()))
    {
        CodecProxy * codec = qobject_cast<CodecProxy *>(m_server->tsh());
        dialog.codecConnected(codec->host(), codec->username());
    }

    window.exec();
}

void MainWindow::openMessageBrowser()
{
    if (m_messageBrowser == 0)
    {
        m_messageBrowser = new MessageBrowser;
        m_server->connect(m_messageBrowser, SIGNAL(sendCustomReply(QByteArray)), SLOT(sendCustomDataToClient(QByteArray)));
    }
    m_messageBrowser->show();
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    QMainWindow::closeEvent(event);
    qApp->quit();
}

void MainWindow::clientConnected(QString)
{
    statusBar()->showMessage("Client connected");
}

void MainWindow::clientDisconnected()
{
    statusBar()->showMessage("No client connected");
}

void MainWindow::simulatorSelected(QString dir)
{
    Simulator * tsh = new Simulator(this);
    tsh->setDirectory(dir);
    m_server->connectTsh(tsh);
    m_connectionButton->setText("Connection: Simulator");
}

void MainWindow::codecSelected(QString host, QString username)
{
    Tsh * tsh = new CodecProxy(host, username, this);
    m_server->connectTsh(tsh);
    m_connectionButton->setText(QString("Connection: %1").arg(host));
    Settings::getInstance().addRecentCodec(host);
}

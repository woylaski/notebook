#include "messagebrowser.h"
#include "ui_messageList.h"

#include "settings.h"

#include <QFileDialog>
#include <QFileSystemModel>
#include <QModelIndex>
#include <QSettings>
#include <QDebug>

MessageBrowser::MessageBrowser(QWidget *parent) :
    QWidget(parent),
    m_messageBrowser(new Ui::Form)
{
    m_messageBrowser->setupUi(this);
    connect(m_messageBrowser->messageList, SIGNAL(clicked(const QModelIndex &)), SLOT(onFileClicked(const QModelIndex &)));
    connect(m_messageBrowser->messageList, SIGNAL(doubleClicked(const QModelIndex &)), SLOT(onFileDoubleClicked(const QModelIndex &)));
    m_currentPath = loadLastDir();
    loadDirectory(m_currentPath);
}

MessageBrowser::~MessageBrowser()
{
    delete m_messageBrowser;
}

void MessageBrowser::onFileClicked(const QModelIndex & index)
{
    QString fileName = m_currentPath + "/" + m_messageBrowser->messageList->model()->data(index).toString();
    QFile file(fileName);
    if (file.open(QIODevice::ReadOnly))
        m_messageBrowser->messageContent->setPlainText(file.readAll());
}

void MessageBrowser::onFileDoubleClicked(const QModelIndex & )
{
    on_sendMessage_clicked();
}

void MessageBrowser::on_saveToFile_clicked()
{
    QString fileName = QFileDialog::getSaveFileName(this, "Save data to file", m_currentPath);
    if (fileName.isEmpty())
        return;

    QFile file(fileName);
    if (file.open(QIODevice::WriteOnly))
        file.write(m_messageBrowser->messageContent->toPlainText().toAscii());

    m_messageBrowser->messageList->clearSelection();

}

void MessageBrowser::on_chooseDirectory_clicked()
{
    QString directory = QFileDialog::getExistingDirectory(this, "Choose directory with xml commands", m_currentPath);
    if (! directory.isEmpty())
        loadDirectory(directory);
}

void MessageBrowser::on_sendMessage_clicked()
{
    emit sendCustomReply(m_messageBrowser->messageContent->toPlainText().toAscii() + "\n");
}

void MessageBrowser::loadDirectory(QString directory)
{
    m_currentPath = directory;
    saveLastDir(directory);
    m_messageBrowser->directory->setText(directory);

    QFileSystemModel * files = new QFileSystemModel(this);
    files->setRootPath(directory);
    files->setFilter(QDir::Files);
    m_messageBrowser->messageList->setModel(files);
    m_messageBrowser->messageList->setRootIndex(files->index(directory));
}

void MessageBrowser::saveLastDir(QString dir)
{
    Settings::getInstance().saveLastDir(dir);
}

QString MessageBrowser::loadLastDir() const
{
    return Settings::getInstance().lastDir();
}

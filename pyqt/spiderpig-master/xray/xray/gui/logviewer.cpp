#include "logviewer.h"
#include "ui_logviewer.h"

#include "settings.h"
#include "logmodel.h"
#include "message.h"

#include <QFile>
#include <QMessageBox>
#include <QFileDialog>
#include <QDebug>

LogViewer::LogViewer(LogModel * commands, LogModel * replies, QWidget *parent) :
    QWidget(parent)
  , ui(new Ui::LogViewer)
  , m_commands(commands)
  , m_replies(replies)
{
    ui->setupUi(this);
    ui->commands->setModel(commands);
    ui->replies->setModel(replies);

    connect(ui->replies, SIGNAL(clicked(const QModelIndex &)), SLOT(onReplySelected(const QModelIndex &)));
    connect(ui->commands, SIGNAL(clicked(const QModelIndex &)), SLOT(onCommandSelected(const QModelIndex &)));

    // For keyboard navigation:
    connect(ui->replies->selectionModel(), SIGNAL(currentChanged(QModelIndex,QModelIndex)), SLOT(onReplySelected(const QModelIndex &)));
    connect(ui->commands->selectionModel(), SIGNAL(currentChanged(QModelIndex,QModelIndex)), SLOT(onCommandSelected(const QModelIndex &)));

    connect(ui->replies->selectionModel(), SIGNAL(selectionChanged(QItemSelection,QItemSelection)), SLOT(onReplySelectionChanged()));
    connect(ui->commands->selectionModel(), SIGNAL(selectionChanged(QItemSelection,QItemSelection)), SLOT(onCommandSelectionChanged()));
}

LogViewer::~LogViewer()
{
    delete ui;
}

void LogViewer::on_sendToCodec_clicked()
{
    emit sendCustomCommandToCodec(ui->commandContent->toPlainText().toAscii());
    clearCommandContentBox();
}

void LogViewer::on_sendToClient_clicked()
{
    emit sendCustomReplyToClient(ui->replyContent->toPlainText().toAscii());
    clearReplyContentBox();
}


void LogViewer::on_saveCommands_clicked()
{
    QModelIndexList selected = ui->commands->selectionModel()->selectedIndexes();
    if (selected.size() == 0)
    {
        ui->commands->selectAll();
        ui->commands->selectionModel()->selectedIndexes();
    }

    QString fileName = QFileDialog::getSaveFileName(this, tr("Save data to file"), Settings::getInstance().lastDir());
    if (fileName.isEmpty())
        return;

    bool ok = writeCommandsToFile(fileName);
    if (!ok)
    {
        QMessageBox error;
        error.setText(tr("Couldn't save to ").arg(fileName));
    }
}

void LogViewer::onReplySelectionChanged()
{
    QModelIndexList selected = ui->replies->selectionModel()->selectedIndexes();
    if (selected.count() != 1)
        clearReplyContentBox();
}

void LogViewer::onCommandSelectionChanged()
{
    QModelIndexList selected = ui->commands->selectionModel()->selectedIndexes();
    if (selected.count() != 1)
        clearCommandContentBox();
}

void LogViewer::on_saveReplies_clicked()
{
    QModelIndexList selected = ui->replies->selectionModel()->selectedIndexes();
    if (selected.size() == 0)
    {
        ui->replies->selectAll();
        ui->replies->selectionModel()->selectedIndexes();
    }

    QString fileName = QFileDialog::getSaveFileName(this, tr("Save data to file"), Settings::getInstance().lastDir());
    if (fileName.isEmpty())
        return;

    bool ok = writeRepliesToFile(fileName);
    if (!ok)
    {
        QMessageBox error;
        error.setText(tr("Couldn't save to ").arg(fileName));
    }
}

void LogViewer::clearCommandContentBox()
{
    ui->commandContent->setPlainText("");
}

void LogViewer::clearReplyContentBox()
{
    ui->replyContent->setPlainText("");
}

void LogViewer::on_clearCommands_clicked()
{
    m_commands->removeAllItems();
    clearCommandContentBox();
    ui->commands->reset();
}

void LogViewer::on_clearReplies_clicked()
{
    m_replies->removeAllItems();
    clearReplyContentBox();
    ui->replies->reset();
}

void LogViewer::onReplySelected(const QModelIndex & index)
{
    if (ui->replies->selectionModel()->selectedRows().count() > 1)
        clearReplyContentBox();
    else
        ui->replyContent->setPlainText(m_replies->message(index).data);
}

void LogViewer::onCommandSelected(const QModelIndex & index)
{
    if (ui->commands->selectionModel()->selectedRows().count() > 1)
        clearCommandContentBox();
    else
        ui->commandContent->setPlainText(m_commands->message(index).data);
}

bool LogViewer::writeRepliesToFile(QString fileName)
{
    QFile file(fileName);
    if (! file.open(QIODevice::WriteOnly | QFile::Truncate))
    {
        qWarning() << "Couldn't save to " << fileName;
        return false;
    }

    QModelIndexList selected = ui->replies->selectionModel()->selectedIndexes();
    QModelIndex index;
    foreach (index, selected)
    {
        file.write(m_replies->message(index).data.trimmed() + "\n\n");
    }

    QFileInfo info(fileName);
    Settings::getInstance().saveLastDir(info.absolutePath());

    return true;
}

bool LogViewer::writeCommandsToFile(QString fileName)
{
    QFile file(fileName);
    if (! file.open(QIODevice::WriteOnly | QFile::Truncate))
    {
        qWarning() << "Couldn't save to " << fileName;
        return false;
    }

    QModelIndexList selected = ui->commands->selectionModel()->selectedIndexes();
    QModelIndex index;
    foreach (index, selected)
    {
        file.write(m_commands->message(index).data.trimmed() + "\n\n");
    }

    QFileInfo info(fileName);
    Settings::getInstance().saveLastDir(info.absolutePath());

    return true;
}


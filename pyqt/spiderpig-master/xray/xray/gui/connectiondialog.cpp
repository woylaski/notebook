#include "connectiondialog.h"
#include "ui_connectiondialog.h"

#include "settings.h"

#include <QFileDialog>

#include <QDebug>

ConnectionDialog::ConnectionDialog(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::connectionDialog)
{
    ui->setupUi(this);
    connect(ui->radioCodec, SIGNAL(toggled(bool)), ui->codecIp, SLOT(setEnabled(bool)));
    connect(ui->radioCodec, SIGNAL(toggled(bool)), ui->codecUsername, SLOT(setEnabled(bool)));

    ui->radioSimulator->setChecked(false);
    ui->radioCodec->setChecked(false);
    ui->codecIp->setEnabled(false);
    ui->codecUsername->setEnabled(false);

    QString ip = Settings::getInstance().value("lastCodecIp", "").toString().trimmed();
    QString username = Settings::getInstance().value("lastCodecUsername", "").toString().trimmed();
    if ( ! ip.isEmpty())
    {
        ui->codecIp->setText(ip);
        ui->codecUsername->setText(username);
    }

    connect(ui->connect, SIGNAL(clicked()), SLOT(saveValues()));
    connect(ui->connect, SIGNAL(clicked()), SLOT(onConnectClicked()));
    connect(ui->connect, SIGNAL(clicked()), SIGNAL(connectClicked()));
    connect(ui->radioSimulator, SIGNAL(clicked()), SLOT(onSimulatorDirectoryClicked()));
    connect(ui->radioSimulator, SIGNAL(toggled(bool)), ui->simulatorDirectory, SLOT(setEnabled(bool)));

    QString lastDir = Settings::getInstance().lastDir();
    ui->simulatorDirectory->setText(lastDir);
}

void ConnectionDialog::simulatorConnected(QString dir)
{
    ui->radioSimulator->setChecked(true);
    ui->simulatorDirectory->setText(dir);
}

void ConnectionDialog::codecConnected(QString ip, QString username)
{
    ui->radioCodec->setChecked(true);
    ui->codecIp->setText(ip);
    ui->codecUsername->setText(username);
}

void ConnectionDialog::saveValues()
{
    Settings::getInstance().saveValue("lastCodecIp", ui->codecIp->text());
    Settings::getInstance().saveValue("lastCodecUsername", ui->codecUsername->text());
    Settings::getInstance().saveLastDir(ui->simulatorDirectory->text());
}

void ConnectionDialog::onSimulatorDirectoryClicked()
{
    QString current = Settings::getInstance().lastDir();
    QString directory = QFileDialog::getExistingDirectory(this, "Choose directory with xml commands", current);
    if (! directory.isEmpty())
        ui->simulatorDirectory->setText(directory);
}

void ConnectionDialog::onConnectClicked()
{
    if (isCodecSelected())
        emit codecSelected(codecIp(), username());
    else
        emit simulatorSelected(ui->simulatorDirectory->text());
}

bool ConnectionDialog::isCodecSelected() const
{
    return ui->radioCodec->isChecked();
}

QString ConnectionDialog::codecIp() const
{
    return ui->codecIp->text();
}

QString ConnectionDialog::username() const
{
    return ui->codecUsername->text();
}


ConnectionDialog::~ConnectionDialog()
{
    delete ui;
}

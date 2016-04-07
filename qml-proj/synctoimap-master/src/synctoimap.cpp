/*
 *  Copyright 2013 Ruediger Gad
 *
 *  This file is part of SyncToImap.
 *
 *  SyncToImap is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  SyncToImap is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with SyncToImap.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "synctoimap.h"

#include "envvarhelper.h"
#include "filehelper.h"
#include "imapaccounthelper.h"
#include "imapaccountlistmodel.h"
#include "imapstorage.h"

#include <QDebug>
#include <QFile>
#include <QtQml>

#include <unistd.h>



QString SyncToImap::ownLibPathStr = "";
QString SyncToImap::ownPathStr = "";
QProcess *SyncToImap::messageServerProcess = NULL;
bool SyncToImap::messageServerStarted = false;



SyncToImap::SyncToImap()
{
}

int SyncToImap::init() {
    qmlRegisterType<FileHelper>("SyncToImap", 1, 0, "FileHelper");
    qmlRegisterType<ImapAccountHelper>("SyncToImap", 1, 0, "ImapAccountHelper");
    qmlRegisterType<ImapAccountListModel>("SyncToImap", 1, 0, "ImapAccountListModel");
    qmlRegisterType<ImapStorage>("SyncToImap", 1, 0, "ImapStorage");

    if (SyncToImap::setEnvironmentVariables() == 0) {
        return SyncToImap::startMessageServer();
    }

    return -1;
}

int SyncToImap::setEnvironmentVariables() {
    qDebug("Setting SyncToImap environment variables...");

    ownPathStr = EnvVarHelper::getOwnPath();
    ownLibPathStr = EnvVarHelper::getOwnLibPath(ownPathStr);
    if (ownLibPathStr.isEmpty()) {
        qErrnoWarning("getOwnLibPath returned non zero value. Not setting up QMF environment variables.");
        return -1;
    }

#ifdef LINUX_DESKTOP
    QString libDirPath = ownLibPathStr + "/qmf/lib";
    QString qmfPluginsEnvVar = ownLibPathStr + "/qmf/lib/qmf/plugins5";

    if (! qmfPluginsEnvVar.isEmpty()) {
        EnvVarHelper::setEnvironmentVariable("QMF_PLUGINS", qmfPluginsEnvVar);
    }

    if (! libDirPath.isEmpty()) {
        EnvVarHelper::appendToEnvironmentVariable("LD_LIBRARY_PATH", libDirPath);
    }
#endif

    return 0;
}

int SyncToImap::shutdown() {
    return stopMessageServer();
}

int SyncToImap::startMessageServer() {
    QString messageServerRunningQuery;
    QString messageServerExecutable;

#if defined(WINDOWS_DESKTOP)
    messageServerRunningQuery = "tasklist | find /N \"messageserver.exe\"";
    messageServerExecutable = "messageserver.exe";
#elif defined(LINUX_DESKTOP)
    messageServerRunningQuery = "ps -el | grep messageserver5";
    messageServerExecutable = ownLibPathStr + "/qmf/bin/messageserver5";
#else
    return -1;
#endif

    QProcess queryMessageServerRunning;
    queryMessageServerRunning.start(messageServerRunningQuery);
    queryMessageServerRunning.waitForFinished(-1);

    if (queryMessageServerRunning.exitCode() != 0) {
        qDebug("Starting messageserver...");
        messageServerProcess = new QProcess();
        messageServerProcess->start(messageServerExecutable);
        messageServerStarted = true;
    } else {
        qDebug("Messageserver is already running.");
    }

    return 0;
}

int SyncToImap::stopMessageServer() {
    if (messageServerStarted) {
        qDebug("Stopping messageserver...");
        messageServerProcess->kill();
    }

    return 0;
}

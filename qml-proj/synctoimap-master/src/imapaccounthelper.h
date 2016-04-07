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

#ifndef IMAPACCOUNTHELPER_H
#define IMAPACCOUNTHELPER_H

#include <QObject>

#ifdef QT5_BUILD
#include <qmfclient5/qmailaccountconfiguration.h>
#else
#include <qmfclient/qmailaccountconfiguration.h>
#endif

class ImapAccountHelper : public QObject
{
    Q_OBJECT
public:
    explicit ImapAccountHelper(QObject *parent = 0);

    Q_INVOKABLE int encryptionSetting(qulonglong accId);
    Q_INVOKABLE int imapAuthenticationType(qulonglong accId);
    Q_INVOKABLE QString imapPassword(qulonglong accId);
    Q_INVOKABLE QString imapPort(qulonglong accId);
    Q_INVOKABLE QString imapServer(qulonglong accId);
    Q_INVOKABLE QString imapUserName(qulonglong accId);

    Q_INVOKABLE void addAccount(QString accountName, QString userName, QString password,
                                QString server, QString port, int encryptionSetting, int authType);
    Q_INVOKABLE void removeAccount(qulonglong accId);
    Q_INVOKABLE void updateAccount(qulonglong accId, QString userName, QString password,
                                   QString server, QString port, int encryptionSetting, int authType);

    Q_INVOKABLE qulonglong getSyncAccount();
    Q_INVOKABLE void setSyncAccount(qulonglong accId);
    
signals:
    
public slots:
    
private:
    QMailAccountConfiguration::ServiceConfiguration imapConfig(qulonglong accId);
};

#endif // IMAPACCOUNTHELPER_H

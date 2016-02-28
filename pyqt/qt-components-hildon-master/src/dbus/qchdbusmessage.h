/*
 * Copyright (C) 2016 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef QCHDBUSMESSAGE_H
#define QCHDBUSMESSAGE_H

#include "qchdbus.h"
#include <QObject>
#include <qdeclarative.h>

class QDBusMessage;
class QDBusError;
class QchDBusMessagePrivate;

class QchDBusMessage : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString serviceName READ serviceName WRITE setServiceName NOTIFY serviceNameChanged)
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QString interfaceName READ interfaceName WRITE setInterfaceName NOTIFY interfaceNameChanged)
    Q_PROPERTY(QString methodName READ methodName WRITE setMethodName NOTIFY methodNameChanged)
    Q_PROPERTY(QVariantList arguments READ arguments WRITE setArguments NOTIFY argumentsChanged)
    Q_PROPERTY(QchDBus::BusType bus READ bus WRITE setBus NOTIFY busChanged)
    Q_PROPERTY(MessageType type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(Status status READ status NOTIFY statusChanged)
    Q_PROPERTY(QVariant reply READ reply NOTIFY statusChanged)

    Q_ENUMS(MessageType Status)

public:
    enum MessageType {
        MethodCallMessage = 0,
        SignalMessage,
        ReplyMessage,
        ErrorMessage
    };

    enum Status {
        Null = 0,
        Loading,
        Ready,
        Error
    };

    explicit QchDBusMessage(QObject *parent = 0);
    ~QchDBusMessage();

    QString serviceName() const;
    void setServiceName(const QString &name);

    QString path() const;
    void setPath(const QString &path);

    QString interfaceName() const;
    void setInterfaceName(const QString &name);

    QString methodName() const;
    void setMethodName(const QString &name);

    QVariantList arguments() const;
    void setArguments(const QVariantList &args);

    QchDBus::BusType bus() const;
    void setBus(QchDBus::BusType bus);

    MessageType type() const;
    void setType(MessageType type);

    Status status() const;

    QVariant reply() const;
    
public Q_SLOTS:
    void send();

Q_SIGNALS:
    void serviceNameChanged();
    void pathChanged();
    void interfaceNameChanged();
    void methodNameChanged();
    void argumentsChanged();
    void busChanged();
    void typeChanged();
    void statusChanged();

protected:
    QchDBusMessage(QchDBusMessagePrivate &dd, QObject *parent = 0);

    QScopedPointer<QchDBusMessagePrivate> d_ptr;

    Q_DECLARE_PRIVATE(QchDBusMessage)

    Q_PRIVATE_SLOT(d_func(), void _q_onReplyFinished(QDBusMessage))
    Q_PRIVATE_SLOT(d_func(), void _q_onReplyError(QDBusError))

private:
    Q_DISABLE_COPY(QchDBusMessage)
};

QML_DECLARE_TYPE(QchDBusMessage)

#endif // QCHDBUSMESSAGE_H

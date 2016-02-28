#ifndef SHAREDOBJECT_H
#define SHAREDOBJECT_H

#include <QTimer>
#include <QObject>
#include <QString>
#include <QTcpServer>
#include <QTcpSocket>
#include <QUdpSocket>
#include <QByteArray>
#include <QDateTime>
#include <QFile>
#include <QSettings>
#include <QElapsedTimer>

#include "QQmlMimeIconsHelper.h"
#include "QQmlObjectListModel.h"
#include "QQmlVarPropertyHelpers.h"
#include "QQmlPtrPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

typedef  void (QTcpSocket::*SockErrSignal) (QTcpSocket::SocketError);

class SharedObject;
class UsersModelItem;
class TransfersModelItem;

class TransfersModelItem : public QObject {
    Q_OBJECT
    Q_ENUMS (TransferMode)
    Q_ENUMS (TransferStatus)
    QML_READONLY_VAR_PROPERTY    (int, mode)
    QML_READONLY_VAR_PROPERTY    (int, status)
    QML_READONLY_VAR_PROPERTY    (bool, paused)
    QML_READONLY_CSTREF_PROPERTY (QString, fileUrl)
    QML_READONLY_CSTREF_PROPERTY (QString, fileName)
    QML_READONLY_CSTREF_PROPERTY (QString, mimeIcon)
    QML_READONLY_VAR_PROPERTY    (quint64, currentSize)
    QML_READONLY_VAR_PROPERTY    (quint64, totalSize)
    QML_READONLY_VAR_PROPERTY    (qreal, speed)
    QML_READONLY_PTR_PROPERTY    (UsersModelItem, peer)

public:
    enum TransferMode {
        Undef,
        Sending,
        Receiving,
    };

    enum TransferStatus {
        Pending,
        Asked,
        Started,
        Finished,
        Failed,
    };

    explicit TransfersModelItem (const TransferMode mode = Undef,
                                 const QString & fileUrl = "",
                                 UsersModelItem * peer = Q_NULLPTR,
                                 QTcpSocket * socket = Q_NULLPTR,
                                 SharedObject * parent = Q_NULLPTR);

    static const QString ACTION_START;
    static const QString ACTION_ACCEPT;
    static const QString ACTION_REFUSE;
    static const QString ACTION_BLOCK;
    static const QString ACTION_ACK;
    static const QString ACTION_END;

public slots:
    void start  (void);
    void pause  (void);
    void stop   (void);
    void accept (void);
    void refuse (void);

signals:
    void started  (void);
    void asked    (void);
    void finished (void);
    void failed   (void);

protected slots:
    void onClientConnected    (void);
    void onClientRecv         (void);
    void onClientDisconnected (void);
    void onClientError        (QAbstractSocket::SocketError err);

private slots:
    void doSendJsonToSock (const QVariantMap & info);
    void doDetachSocket   (void);

private:
    QFile         m_file;
    QTcpSocket *  m_tcpClient;
    QElapsedTimer m_timer;
};

class UsersModelItem : public QObject {
    Q_OBJECT
    Q_ENUMS (UserType)
    QML_READONLY_VAR_PROPERTY    (int, type)
    QML_READONLY_VAR_PROPERTY    (quint16, tcpPort)
    QML_READONLY_CSTREF_PROPERTY (QString, guid)
    QML_READONLY_CSTREF_PROPERTY (QString, userName)
    QML_READONLY_CSTREF_PROPERTY (QString, hostName)
    QML_READONLY_CSTREF_PROPERTY (QString, machineType)
    QML_READONLY_CSTREF_PROPERTY (QString, ipAddress)
    QML_READONLY_CSTREF_PROPERTY (QDateTime, lastSeen)
    QML_OBJMODEL_PROPERTY        (TransfersModelItem, modelTransfers)

public:
    enum UserType {
        Local,
        Remote,
    };

    explicit UsersModelItem (QObject * parent = Q_NULLPTR);
};

class SharedObject : public QObject {
    Q_OBJECT
    QML_CONSTANT_CSTREF_PROPERTY (QString, guid)
    QML_CONSTANT_CSTREF_PROPERTY (QString, localHostName)
    QML_WRITABLE_CSTREF_PROPERTY (QString, localUserName)
    QML_WRITABLE_CSTREF_PROPERTY (QString, localMachineType)
    QML_OBJMODEL_PROPERTY        (UsersModelItem, modelUsers)
    QML_CONSTANT_PTR_PROPERTY    (QQmlMimeIconsHelper, mimeHelper)
    QML_OBJMODEL_PROPERTY        (TransfersModelItem, modelTransfers)

public:
    explicit SharedObject (QObject * parent = Q_NULLPTR);

    static const quint16 UDP_PORT  = 12345;
    static const quint64 UDP_DELAY =  1000;

    Q_INVOKABLE QString formatSize (const qint64 num) const;

public slots:
    void sendFile (const QString & fileUrl, UsersModelItem * target);

protected slots:
    void onLocalUserNameChanged    (void);
    void onLocalMachineTypeChanged (void);
    void doBroadcastPresence       (void);
    void doCleanInfos              (void);
    void onUdpDatagram             (void);
    void onIncomingConnection      (void);
    void onTransferStarted         (void);
    void onTransferFinished        (void);
    void onTransferFailed          (void);

private slots:
    void sendPresence     (const QHostAddress & fromIp, const QHostAddress & toIp);
    void registerTransfer (TransfersModelItem * transfer);

private:
    QTimer *     m_timer;
    QSettings *  m_settings;
    QTcpServer * m_tcpServer;
    QUdpSocket * m_udpListener;
    QUdpSocket * m_udpBroadcast;
    QList<TransfersModelItem *> m_unconfirmedTransfers;
};

#endif // SHAREDOBJECT_H

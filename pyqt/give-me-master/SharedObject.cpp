
#include "SharedObject.h"

#include <QCryptographicHash>
#include <QNetworkInterface>
#include <QNetworkAddressEntry>
#include <QStringBuilder>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QHostAddress>
#include <QHostInfo>
#include <QDebug>
#include <QFile>
#include <QDir>
#include <QUrl>

/************************ SHARED OBJECT ***************************/

SharedObject::SharedObject (QObject * parent) : QObject (parent)
  , m_tcpServer    (Q_NULLPTR)
  , m_udpListener  (Q_NULLPTR)
  , m_udpBroadcast (Q_NULLPTR)
{
    m_mimeHelper = new QQmlMimeIconsHelper (this);
    m_modelUsers = new QQmlObjectListModel<UsersModelItem> (this, "", "guid");
    m_modelTransfers = new QQmlObjectListModel<TransfersModelItem> (this);
    m_localHostName = QHostInfo::localHostName ();
    m_guid = QString::fromLocal8Bit (
                 QCryptographicHash::hash (
                     QDateTime::currentDateTimeUtc ()
                     .toString ("yyyy-MM-dd hh:mm:ss.zzz")
                     .toLocal8Bit (),
                     QCryptographicHash::Md5)
                 .toHex ());
    m_timer = new QTimer (this);
    m_settings = new QSettings (QDir::homePath () % "/GiveMe/conf.ini", QSettings::IniFormat, this);
    m_localUserName = m_settings->value ("LOCAL_USER_NAME", "Unamed").toString ();
    m_localMachineType = m_settings->value ("LOCAL_MACHINE_TYPE", "laptop").toString ();
    m_tcpServer = new QTcpServer (this);
    m_udpListener = new QUdpSocket (this);
    m_udpBroadcast = new QUdpSocket (this);
    connect (this, &SharedObject::localUserNameChanged, this, &SharedObject::onLocalUserNameChanged);
    connect (this, &SharedObject::localMachineTypeChanged, this, &SharedObject::onLocalMachineTypeChanged);
    connect (m_tcpServer, &QTcpServer::newConnection, this, &SharedObject::onIncomingConnection);
    connect (m_udpListener, &QUdpSocket::readyRead, this, &SharedObject::onUdpDatagram);
    connect (m_timer, &QTimer::timeout, this, &SharedObject::doCleanInfos);
    connect (m_timer, &QTimer::timeout, this, &SharedObject::doBroadcastPresence);
    m_udpListener->bind (QHostAddress::AnyIPv4, UDP_PORT, QUdpSocket::ReuseAddressHint);
    m_tcpServer->listen (QHostAddress::AnyIPv4, 0);
    m_timer->setSingleShot (true);
    m_timer->start (0);
}

QString SharedObject::formatSize (const qint64 num) const {
    static const qreal KiB = 1024;
    static const qreal MiB = (1024 * KiB);
    static const qreal GiB = (1024 * MiB);
    static const qreal TiB = (1024 * GiB);
    QString total;
    if (num >= TiB) {
        total = QStringLiteral ("%1TiB").arg (QString::number (qreal (num) / TiB, 'f', 4));
    }
    else if (num >= GiB) {
        total = QStringLiteral ("%1GiB").arg (QString::number (qreal (num) / GiB, 'f', 3));
    }
    else if (num >= MiB) {
        total = QStringLiteral ("%1MiB").arg (QString::number (qreal (num) / MiB, 'f', 2));
    }
    else if (num >= KiB) {
        total = QStringLiteral ("%1KiB").arg (QString::number (qreal (num) / KiB, 'f', 1));
    }
    else {
        total = QStringLiteral ("%1B").arg (num);
    }
    return total;
}

void SharedObject::onLocalUserNameChanged (void) {
    m_settings->setValue ("LOCAL_USER_NAME", m_localUserName);
}

void SharedObject::onLocalMachineTypeChanged (void) {
    m_settings->setValue ("LOCAL_MACHINE_TYPE", m_localMachineType);
}

void SharedObject::sendPresence (const QHostAddress & fromIp, const QHostAddress & toIp) {
    //qWarning () << "BROADCAST" << "from" << fromIp << "to" << toIp;
    QVariantMap info;
    info.insert ("guid", m_guid);
    info.insert ("addr", fromIp.toString ());
    info.insert ("port", m_tcpServer->serverPort ());
    info.insert ("user", m_localUserName);
    info.insert ("host", m_localHostName);
    info.insert ("type", m_localMachineType);
    const QByteArray frame = QJsonDocument::fromVariant (info).toJson (QJsonDocument::Compact);
    m_udpBroadcast->writeDatagram (frame, toIp, UDP_PORT);
    m_udpBroadcast->flush ();
}

void SharedObject::registerTransfer (TransfersModelItem * transfer) {
    m_unconfirmedTransfers.append (transfer);
    connect (transfer, &TransfersModelItem::started,  this, &SharedObject::onTransferStarted);
    connect (transfer, &TransfersModelItem::finished, this, &SharedObject::onTransferFinished);
    connect (transfer, &TransfersModelItem::failed,   this, &SharedObject::onTransferFailed);
}

void SharedObject::doBroadcastPresence (void) {
    QList<QNetworkInterface> list = QNetworkInterface::allInterfaces ();
    foreach (const QNetworkInterface & iface, list) { // NOTE : send to all interfaces
        if (iface.flags ().testFlag (QNetworkInterface::CanBroadcast)) {
            QList<QNetworkAddressEntry> entries = iface.addressEntries ();
            foreach (QNetworkAddressEntry entry, entries) {
                if (!entry.broadcast ().isNull () && !entry.ip ().isNull ()) {
                    sendPresence (entry.ip (), entry.broadcast ());
                }
            }
        }
    }
    sendPresence (QHostAddress::LocalHost, QHostAddress::LocalHost); // NOTE : Send to localhost
    m_timer->start (UDP_DELAY);
}

void SharedObject::onUdpDatagram (void) {
    QUdpSocket * listener = qobject_cast<QUdpSocket *> (sender ());
    if (listener) {
        const QDateTime now = QDateTime::currentDateTimeUtc ();
        while (listener->hasPendingDatagrams ()) {
            quint16 senderPort;
            QHostAddress senderHost;
            QByteArray frame (int (listener->pendingDatagramSize ()), 0x00);
            listener->readDatagram (frame.data (), frame.size (), &senderHost, &senderPort);
            const QVariantMap data = QJsonDocument::fromJson (frame).toVariant ().toMap ();
            const QString addr = senderHost.toString ();
            const quint16 port = data.value ("port",  0).value<quint16> ();
            const QString guid = data.value ("guid", "").value<QString> ();
            if (!guid.isEmpty () && port != 0) {
                UsersModelItem * item = m_modelUsers->getByUid (guid);
                if (item == Q_NULLPTR) {
                    item = new UsersModelItem;
                    item->update_type (guid == m_guid ? UsersModelItem::Local : UsersModelItem::Remote);
                    item->update_guid (guid);
                    item->update_tcpPort (port);
                    item->update_ipAddress (data.value ("addr",  addr).value<QString> ());
                    m_modelUsers->append (item);
                }
                item->update_userName (data.value ("user", "<username>").value<QString> ());
                item->update_hostName (data.value ("host", "<hostname>").value<QString> ());
                item->update_machineType (data.value ("type", "<machine type>").value<QString> ());
                item->update_lastSeen (now);
            }
        }
    }
}

void SharedObject::doCleanInfos (void) {
    if (m_udpListener->hasPendingDatagrams ()) {
        m_udpListener->readyRead ();
    }
    const QDateTime now = QDateTime::currentDateTimeUtc ();
    foreach (UsersModelItem * item, m_modelUsers->toList ()) {
        if (item != Q_NULLPTR) {
            if (item->get_lastSeen ().msecsTo (now) > qint64 (UDP_DELAY * 3)) {
                m_modelUsers->remove (item);
            }
        }
    }
}

void SharedObject::sendFile (const QString & fileUrl, UsersModelItem * target) {
    if (target != Q_NULLPTR) {
        TransfersModelItem * transfer = new TransfersModelItem (TransfersModelItem::Sending,
                                                                fileUrl,
                                                                target,
                                                                Q_NULLPTR,
                                                                this);
        transfer->update_mimeIcon (m_mimeHelper->getIconNameForUrl (fileUrl));
        registerTransfer (transfer);
        const bool immediate = target->get_modelTransfers ()->isEmpty ();
        //qWarning () << "ENQUEUE PENDING TRANSFER";
        target->get_modelTransfers ()->append (transfer);
        if (immediate) {
            transfer->start ();
        }
    }
}

void SharedObject::onIncomingConnection (void) {
    while (m_tcpServer->hasPendingConnections ()) {
        QTcpSocket * client = m_tcpServer->nextPendingConnection ();
        if (client != Q_NULLPTR) {
            TransfersModelItem * transfer = new TransfersModelItem (TransfersModelItem::Receiving,
                                                                    "",
                                                                    Q_NULLPTR,
                                                                    client,
                                                                    this);
            //qWarning () << "ACCEPT INCOMING TRANSFER";
            registerTransfer (transfer);
        }
    }
}

void SharedObject::onTransferStarted (void) {
    //qWarning () << "TRANSFER STARTED";
    TransfersModelItem * transfer = qobject_cast<TransfersModelItem *> (sender ());
    if (transfer != Q_NULLPTR) {
        m_unconfirmedTransfers.removeAll (transfer);
    }
}

void SharedObject::onTransferFinished (void) {
    //qWarning () << "TRANSFER FINISHED";
    TransfersModelItem * transfer = qobject_cast<TransfersModelItem *> (sender ());
    if (transfer != Q_NULLPTR) {
        m_modelTransfers->append (transfer);
        transfer->get_peer ()->get_modelTransfers ()->remove (transfer);
        if (!transfer->get_peer ()->get_modelTransfers ()->isEmpty ()) {
            transfer->get_peer ()->get_modelTransfers ()->first ()->start ();
        }
    }
}

void SharedObject::onTransferFailed (void) {
    //qWarning () << "TRANSFER FAILED";
    TransfersModelItem * transfer = qobject_cast<TransfersModelItem *> (sender ());
    if (transfer != Q_NULLPTR) {
        m_modelTransfers->append (transfer);
        transfer->get_peer ()->get_modelTransfers ()->remove (transfer);
        if (!transfer->get_peer ()->get_modelTransfers ()->isEmpty ()) {
            transfer->get_peer ()->get_modelTransfers ()->first ()->start ();
        }
    }
}

/********************* USER PEER *******************************/

UsersModelItem::UsersModelItem (QObject * parent) : QObject (parent)
  , m_type     (Remote)
  , m_tcpPort  (0)
  , m_lastSeen (QDateTime::currentDateTimeUtc ())
{
    m_modelTransfers = new QQmlObjectListModel<TransfersModelItem> (this);
}

/*********************** TRANSFER *****************************/

const QString TransfersModelItem::ACTION_START  = QStringLiteral ("START");
const QString TransfersModelItem::ACTION_ACCEPT = QStringLiteral ("ACCEPT");
const QString TransfersModelItem::ACTION_REFUSE = QStringLiteral ("REFUSE");
const QString TransfersModelItem::ACTION_BLOCK  = QStringLiteral ("BLOCK");
const QString TransfersModelItem::ACTION_ACK    = QStringLiteral ("ACK");
const QString TransfersModelItem::ACTION_END    = QStringLiteral ("END");

TransfersModelItem::TransfersModelItem (const TransfersModelItem::TransferMode mode,
                                        const QString & fileUrl,
                                        UsersModelItem * peer,
                                        QTcpSocket * socket,
                                        SharedObject * parent)
    : QObject       (parent)
    , m_mode        (mode)
    , m_status      (Pending)
    , m_paused      (false)
    , m_fileUrl     (fileUrl)
    , m_currentSize (0)
    , m_totalSize   (0)
    , m_peer        (peer)
    , m_tcpClient   (socket)
{
    if (m_tcpClient == Q_NULLPTR) {
        m_tcpClient = new QTcpSocket (this);
    }
    m_file.setFileName (QUrl (m_fileUrl).toLocalFile ());
    update_fileName (m_fileUrl.split ('/').last ());
    connect (m_tcpClient, &QTcpSocket::connected,              this, &TransfersModelItem::onClientConnected);
    connect (m_tcpClient, &QTcpSocket::readyRead,              this, &TransfersModelItem::onClientRecv);
    connect (m_tcpClient, &QTcpSocket::disconnected,           this, &TransfersModelItem::onClientDisconnected);
    connect (m_tcpClient, (SockErrSignal)(&QTcpSocket::error), this, &TransfersModelItem::onClientError);
}

void TransfersModelItem::doSendJsonToSock (const QVariantMap & info) {
    if (m_tcpClient != Q_NULLPTR) {
        const QByteArray frame = QJsonDocument::fromVariant (info).toJson (QJsonDocument::Compact);
        m_tcpClient->write (frame % "\r\n");
        m_tcpClient->flush ();
    }
}

void TransfersModelItem::doDetachSocket (void) {
    if (m_tcpClient != Q_NULLPTR) {
        disconnect (m_tcpClient, Q_NULLPTR, this,        Q_NULLPTR);
        disconnect (this,        Q_NULLPTR, m_tcpClient, Q_NULLPTR);
        //m_tcpClient->deleteLater ();
        //m_tcpClient = Q_NULLPTR;
    }
}

void TransfersModelItem::start (void) {
    if (m_paused) {
        m_paused = false;
        onClientRecv ();
    }
    else {
        if (m_file.open (QFile::ReadOnly)) {
            update_totalSize (quint64 (m_file.size ()));
            //qWarning () << "TRY CONNECT...";
            m_tcpClient->connectToHost (m_peer->get_ipAddress (), m_peer->get_tcpPort ());
        }
        else {
            qCritical () << "ERROR :" << "Can't open" << m_file.fileName () << "!" << m_file.errorString ();
            doDetachSocket ();
            update_status (Failed);
            emit failed ();
        }
    }
}

void TransfersModelItem::pause (void) {
    update_paused (true);
}

void TransfersModelItem::stop (void) {
    // TODO : send ABORT
}

void TransfersModelItem::accept (void) {
    const QString path = QStringLiteral ("%1/GiveMe/%2@%3")
                         .arg (QDir::homePath ())
                         .arg (m_peer->get_userName ())
                         .arg (m_peer->get_hostName ());
    QFile::remove (path % '/' % m_fileName);
    QDir ().mkpath (path);
    m_file.setFileName (path % '/' % m_fileName);
    if (m_file.open (QFile::WriteOnly | QFile::Append)) {
        QVariantMap infoAccept;
        infoAccept.insert ("action", ACTION_ACCEPT);
        //qWarning () << "SEND ACCEPT";
        doSendJsonToSock (infoAccept);
        m_timer.start ();
        update_fileUrl (QUrl::fromLocalFile (m_file.fileName ()).toString ());
        update_status (Started);
        emit started ();
    }
    else {
        qCritical () << "ERROR" << m_file.errorString ();
        doDetachSocket ();
        update_status (Failed);
        emit failed ();
    }
}

void TransfersModelItem::refuse (void) {
    QVariantMap infoRefuse;
    infoRefuse.insert ("action", ACTION_REFUSE);
    //qWarning () << "SEND REFUSE";
    doSendJsonToSock (infoRefuse);
    doDetachSocket ();
    update_status (Failed);
    emit failed ();
}

void TransfersModelItem::onClientConnected (void) {
    //qWarning () << "CONNECTED";
    switch (m_mode) {
        case Sending: {
            SharedObject * sharedObj = qobject_cast<SharedObject *> (parent ());
            if (sharedObj != Q_NULLPTR) {
                QVariantMap infoStart;
                infoStart.insert ("action",     ACTION_START);
                infoStart.insert ("fileName",   m_fileName);
                infoStart.insert ("mimeIcon",   m_mimeIcon);
                infoStart.insert ("totalSize",  m_totalSize);
                infoStart.insert ("senderGuid", sharedObj->get_guid ());
                //qWarning () << "SEND START";
                doSendJsonToSock (infoStart);
                m_timer.start ();
                update_status (Asked);
                emit started ();
            }
            else {
                qCritical () << "ERROR" << "Can't find Shared Object !";
                doDetachSocket ();
                update_status (Failed);
                emit failed ();
            }
            break;
        }
        case Receiving: {
            // NOTE : wait for START frame
            break;
        }
        default: break;
    }
}

void TransfersModelItem::onClientRecv (void) {
    if (m_tcpClient != Q_NULLPTR && m_tcpClient->canReadLine () && !m_paused) {
        const QByteArray line = m_tcpClient->readLine ();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson (line);
        if (jsonDoc.isObject ()) {
            const QJsonObject jsonObj = jsonDoc.object ();
            const QString action = jsonObj.value ("action").toString ();
            switch (m_mode) {
                case Sending: {
                    if (action == ACTION_ACCEPT || action == ACTION_ACK) {
                        //qWarning () << "RECV ACCEPT/ACK";
                        if (m_currentSize < m_totalSize) {
                            static const quint64 BLOCK_SIZE = 8192;
                            const QByteArray block = m_file.read (BLOCK_SIZE);
                            QVariantMap infoBlock;
                            infoBlock.insert ("action", ACTION_BLOCK);
                            infoBlock.insert ("offset", m_currentSize);
                            infoBlock.insert ("data",   block.toBase64 ());
                            //qWarning () << "SEND BLOCK";
                            doSendJsonToSock (infoBlock);
                            update_currentSize (quint64 (m_file.pos ()));
                            update_speed (m_timer.elapsed ()
                                          ? qreal (m_currentSize * 1000) / qreal (m_timer.elapsed ())
                                          : 0.0);
                            update_status (Started);
                        }
                        else {
                            m_file.close ();
                            QVariantMap infoEnd;
                            infoEnd.insert ("action", ACTION_END);
                            // TODO : CRC ?
                            //qWarning () << "SEND END";
                            doSendJsonToSock (infoEnd);
                            doDetachSocket ();
                            update_status (Finished);
                            emit finished ();
                        }
                    }
                    else if (action == ACTION_REFUSE) {
                        //qWarning () << "RECV REFUSE";
                        m_file.close ();
                        doDetachSocket ();
                        update_status (Failed);
                        emit failed ();
                    }
                    else { }
                    break;
                }
                case Receiving: {
                    if (action == ACTION_START) {
                        //qWarning () << "RECV START";
                        const QString senderGuid = jsonObj.value ("senderGuid").toString ();
                        SharedObject * sharedObj = qobject_cast<SharedObject *> (parent ());
                        if (sharedObj != Q_NULLPTR) {
                            m_peer = sharedObj->get_modelUsers ()->getByUid (senderGuid);
                            if (m_peer != Q_NULLPTR) {
                                m_peer->get_modelTransfers ()->append (this);
                                update_fileName (jsonObj.value ("fileName").toString ());
                                update_mimeIcon (jsonObj.value ("mimeIcon").toString ());
                                update_totalSize (quint64 (jsonObj.value ("totalSize").toInt ()));
                                update_status (Asked);
                                emit asked ();
                            }
                            else {
                                qCritical () << "ERROR" << "Can't find peer" << senderGuid << "!";
                                doDetachSocket ();
                                update_status (Failed);
                                emit failed ();
                            }
                        }
                        else {
                            qCritical () << "ERROR" << "Can't find Shared Object !";
                            doDetachSocket ();
                            update_status (Failed);
                            emit failed ();
                        }
                    }
                    else if (action == ACTION_BLOCK) {
                        //qWarning () << "RECV BLOCK";
                        const QString data = jsonObj.value ("data").toString ();
                        //const quint64 offset = quint64 (jsonObj.value ("offset").toInt ());
                        const QByteArray bytes = QByteArray::fromBase64 (data.toLocal8Bit ());
                        m_file.write (bytes);
                        update_currentSize (quint64 (m_currentSize + bytes.size ()));
                        update_speed (m_timer.elapsed ()
                                      ? qreal (m_currentSize * 1000) / qreal (m_timer.elapsed ())
                                      : 0.0);
                        QVariantMap infoAck;
                        infoAck.insert ("action", ACTION_ACK);
                        //qWarning () << "SEND ACK";
                        doSendJsonToSock (infoAck);
                        update_status (Started);
                    }
                    else if (action == ACTION_END) {
                        //qWarning () << "RECV END";
                        m_file.flush ();
                        m_file.close ();
                        doDetachSocket ();
                        m_tcpClient->close ();
                        update_status (Finished);
                        emit finished ();
                    }
                    else { }
                    break;
                }
                default: break;
            }
        }
    }
}

void TransfersModelItem::onClientDisconnected (void) {
    //qWarning () << "DISONNECTED";
    doDetachSocket ();
}

void TransfersModelItem::onClientError (QAbstractSocket::SocketError err) {
    Q_UNUSED (err)
    if (m_tcpClient != Q_NULLPTR) {
        const QString msg = m_tcpClient->errorString ();
        doDetachSocket ();
        qCritical () << "ERROR :" << msg;
        update_status (Failed);
        emit failed ();
    }
}

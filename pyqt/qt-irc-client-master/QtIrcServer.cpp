
#include "QtIrcServer.h"
#include "QtIrcChannel.h"
#include "QtIrcMessage.h"
#include "QtIrcIdentity.h"

#include <QGuiApplication>

enum ControlCode {
    Bold            = 0x02,     /**< Bold */
    Color           = 0x03,     /**< Color */
    Italic          = 0x09,     /**< Italic */
    StrikeThrough   = 0x13,     /**< Strike-Through */
    Reset           = 0x0f,     /**< Reset */
    Underline       = 0x15,     /**< Underline */
    Underline2      = 0x1f,     /**< Underline */
    Reverse         = 0x16      /**< Reverse */
};

inline QString stringFromIrcByteArray (QByteArray data) {
    QString tmp = QString::fromUtf8 (data);
    QString ret;
    foreach (const QChar chr, tmp) {
        if (chr != Bold &&
            chr != Italic &&
            chr != StrikeThrough &&
            chr != Underline &&
            chr != Underline2 &&
            chr != Reverse &&
            chr != Reset &&
            chr != Color) {
            ret.append (chr);
        }
    }
    return ret;
}

QtIrcServer::QtIrcServer (QObject * parent)
    : QObject               (parent)
    , m_autoConnect         (true)
    , m_online              (false)
    , m_port                (0)
    , m_host                (QString ())
    , m_nickname            (QString ())
    , m_defaultChannelEntry (NULL)
{
    m_channels = QQmlObjectListModel::create<QtIrcChannel> (this);
    m_channels->setRoleNameForUid (QByteArrayLiteral ("name"));

    m_timerKeepAlive = new QTimer (this);
    m_timerKeepAlive->setInterval (30000);

    m_socket = new QTcpSocket (this);

    connect (m_socket, &QTcpSocket::connected,    this, &QtIrcServer::onSocketConnected);
    connect (m_socket, &QTcpSocket::disconnected, this, &QtIrcServer::onSocketDisconnected);
    connect (m_socket, &QTcpSocket::readyRead,    this, &QtIrcServer::onSocketReadyRead);
    connect (m_socket, &QTcpSocket::bytesWritten, this, &QtIrcServer::onSocketBytesWritten);

    connect (m_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(onSocketError()));

    connect (this, &QtIrcServer::hostChanged, this, &QtIrcServer::onNetworkInfoChanged);
    connect (this, &QtIrcServer::portChanged, this, &QtIrcServer::onNetworkInfoChanged);

    connect (m_timerKeepAlive, &QTimer::timeout, this, &QtIrcServer::sendPing);

    m_timerKeepAlive->start ();
}

void QtIrcServer::tryConnect () {
    if (!m_host.isEmpty () && m_port > 0) {
        QHostInfo info = QHostInfo::fromName (m_host);
        m_socket->connectToHost (info.addresses ().first (), m_port);
    }
}

void QtIrcServer::tryDisconnect () {
    m_socket->disconnectFromHost ();
}

void QtIrcServer::sendMessage (QString data, QtIrcChannel * channelEntry) {
    qDebug () << "IrcSocket::sendMessage :" << data << channelEntry;
    QString channel;
    if (channelEntry != NULL) {
        channel = channelEntry->get_name ();
    }
    QStringList frames;
    foreach (QString chunk, data.split ('\n')) {
        if (chunk.startsWith ('/')) { // command message
            if (chunk.startsWith ("/join ")) {
                frames << chunk.replace ("/join", "JOIN");
            }
            else if (chunk.startsWith ("/me ")) {
                frames << QString("PRIVMSG %1 :\001ACTION %2\001").arg (channel).arg (chunk.remove ("/me "));
                QtIrcMessage * messageEntry = new QtIrcMessage;
                messageEntry->update_content (data.replace ("/me", m_nickname));
                messageEntry->update_toMe    (false);
                messageEntry->update_fromMe  (true);
                messageEntry->update_type    (QtIrcMessage::Status);
                channelEntry->get_messages ()->append (messageEntry);
            }
            else if (chunk.startsWith ("/nick ")) {
                QString nick = chunk.split (' ', QString::SkipEmptyParts).last ();
                frames << QString ("NICK %1").arg (nick);
                frames << QString ("USER %1 0 * 'QtIRC client'").arg (nick);
                update_nickname (nick);
            }
            else if (chunk.startsWith ("/part")) {
                frames << QString ("PART %1").arg (channel);
            }
            else if (chunk.startsWith ("/msg ")) {
                QString to  = chunk.split (' ', QString::SkipEmptyParts).at (1);
                QString msg = chunk.mid (chunk.indexOf (to) + to.size ()).trimmed ();
                frames << QString ("PRIVMSG %1 :%2").arg (to).arg (msg);
                channelEntry = addChannelIfNotExists (to);
                QtIrcMessage * messageEntry = new QtIrcMessage;
                messageEntry->update_content (msg);
                messageEntry->update_from    (m_nickname);
                messageEntry->update_toMe    (false);
                messageEntry->update_fromMe  (true);
                messageEntry->update_type    (QtIrcMessage::Normal);
                channelEntry->get_messages ()->append (messageEntry);
            }
            else if (chunk.startsWith ("/topic ")) {
                frames << QString ("TOPIC %1 :%2").arg (channel).arg (chunk.remove ("/topic "));
            }
            else if (chunk.startsWith("/ping")) {
                frames << QString ("PING %1").arg (m_nickname);
            }
        }
        else {
            // chat message
            frames << QString ("PRIVMSG %1 :%2").arg (channel).arg (chunk);
            QtIrcMessage * messageEntry = new QtIrcMessage;
            messageEntry->update_content (chunk);
            messageEntry->update_from    (m_nickname);
            messageEntry->update_toMe    (false);
            messageEntry->update_fromMe  (true);
            messageEntry->update_type    (QtIrcMessage::Normal);
            channelEntry->get_messages ()->append (messageEntry);
        }
    }
    foreach (QString frame, frames) {
        if (!frame.isEmpty ()) {
            qDebug () << "frame:" << frame;
            m_socket->write (frame.append ("\r\n").toUtf8 ());
            m_socket->flush ();
            //m_socket->waitForBytesWritten();
        }
    }
}

void QtIrcServer::sendPing () {
    sendMessage (QStringLiteral ("/ping"));
}

QtIrcChannel * QtIrcServer::addChannelIfNotExists (QString name) {
    QtIrcChannel * channelEntry = qobject_cast<QtIrcChannel *>(m_channels->getByUid (name));
    if (channelEntry == NULL) {
        channelEntry = new QtIrcChannel;
        channelEntry->update_name (name);
        if (m_realHostname.isEmpty ()) {
            m_realHostname = name;
            update_defaultChannelEntry (channelEntry);
        }
        m_channels->append (channelEntry);
    }
    return channelEntry;
}

void QtIrcServer::onNetworkInfoChanged () {
    qDebug () << "QtIrcServer::onNetworkInfoChanged";
    if (m_autoConnect) {
        tryDisconnect ();
        tryConnect    ();
    }
}

void QtIrcServer::onSocketConnected () {
    qDebug () << "QtIrcServer::onSocketConnected";
    update_online (true);
    emit connected ();
}

void QtIrcServer::onSocketDisconnected () {
    qDebug () << "QtIrcServer::onSocketDisconnected";
    update_online (false);
    emit disconnected ();
}

void QtIrcServer::onSocketError () {
    qDebug () << "QtIrcServer::onSocketError" << m_socket->errorString ();
    emit errorMessage (m_socket->errorString ());
}

void QtIrcServer::onSocketReadyRead () {
    qDebug () << "QtIrcServer::onSocketReadyRead";
    while (m_socket->canReadLine ()) {
        QByteArray line = m_socket->readLine ().trimmed ();
        qDebug () << "line:" << line;
        if (line.startsWith (':')) { // a server message
            int endHeaderPos = line.indexOf (" :", 1);
            QByteArray header;
            QByteArray msg;
            if (endHeaderPos > -1) {
                header = line.mid (1, endHeaderPos -1);
                msg    = line.mid (endHeaderPos +2);
            }
            else {
                header = line.mid (1);
                msg = "";
            }
            qDebug () << "header:" << header;
            qDebug () << "msg:"    << msg;
            QList<QByteArray> parts = header.split (' ');
            qDebug () << "parts:" << parts;
            QString commandStr = QString::fromLocal8Bit (parts.at (1));
            qDebug () << "commandStr:" << commandStr;
            if (commandStr == QByteArrayLiteral ("PRIVMSG")) {
                QString from    = QString::fromLocal8Bit (header.split ('!').first ());
                QString channel = QString::fromLocal8Bit (parts.at (2));
                QString body    = stringFromIrcByteArray (msg);
                QtIrcMessage * messageEntry = new QtIrcMessage;
                messageEntry->update_toMe      (body.contains (m_nickname));
                messageEntry->update_fromMe    (from == m_nickname);
                if (body.startsWith ("ACTION ")) {
                    messageEntry->update_content   (body.replace ("ACTION", from));
                    messageEntry->update_type      (QtIrcMessage::Status);
                }
                else {
                    messageEntry->update_content   (body);
                    messageEntry->update_from      (from);
                    messageEntry->update_type      (QtIrcMessage::Normal);
                }
                QtIrcChannel * channelEntry = NULL;
                if (channel == m_nickname) { // private msg to me
                    qDebug() << "private msg to me from" << from;
                    channelEntry = addChannelIfNotExists (from);
                }
                else { // normal one to all message
                    qDebug() << "msg to channel from" << from;
                    channelEntry = addChannelIfNotExists (channel);
                }
                channelEntry->get_messages ()->append (messageEntry);
            }
            else if (commandStr == QByteArrayLiteral ("353")) { // NAMES LIST
                QString commandChannel = QString::fromLocal8Bit (parts.at (4));
                QStringList members    = QString::fromLocal8Bit (msg).split (' ');
                QtIrcChannel * channelEntry = addChannelIfNotExists (commandChannel);
                foreach (QString nickname, members) {
                    if (!channelEntry->get_members ()->getByUid (nickname)) {
                        QtIrcIdentity * identityEntry = new QtIrcIdentity;
                        identityEntry->update_nickname (nickname);
                        channelEntry->get_members ()->append (identityEntry);
                    }
                }
            }
            else if (commandStr == QByteArrayLiteral ("332")) { // TOPIC SET
                QString commandChannel = QString::fromLocal8Bit (parts.at (3));
                QString topic          = stringFromIrcByteArray (msg);
                QtIrcChannel * channelEntry = addChannelIfNotExists (commandChannel);
                channelEntry->update_topic (topic);
            }
            else if (commandStr == QByteArrayLiteral ("433")) {
                QString oldnick =  QString::fromLocal8Bit(parts.at (2));
                QString newnick =  QString::fromLocal8Bit(parts.at (3));
                QtIrcChannel * channelEntry = addChannelIfNotExists (m_realHostname);
                QtIrcMessage * messageEntry = new QtIrcMessage;
                messageEntry->update_content (QString ("Unable to change %1 to %2, nickname already in use !").arg (oldnick).arg (newnick));
                messageEntry->update_from    (m_realHostname);
                messageEntry->update_type    (QtIrcMessage::Error);
                messageEntry->update_toMe    (false);
                messageEntry->update_fromMe  (false);
                channelEntry->get_messages ()->append (messageEntry);
                m_nickname = oldnick; // FIXME
            }
            else if (commandStr == QByteArrayLiteral ("JOIN")) {
                QString from           = QString::fromLocal8Bit (header.split ('!').first ());
                QString commandChannel = QString::fromLocal8Bit (parts.at (2));
                QtIrcChannel * channelEntry = qobject_cast<QtIrcChannel *>(m_channels->getByUid (commandChannel));
                if (!channelEntry) {
                    channelEntry = addChannelIfNotExists (commandChannel);
                }
                if (from != m_nickname) { // someone else joined channel
                    QtIrcMessage * messageEntry = new QtIrcMessage;
                    messageEntry->update_content (QString ("%1 has joined the channel.").arg (from));
                    messageEntry->update_type    (QtIrcMessage::Status);
                    messageEntry->update_toMe    (false);
                    messageEntry->update_fromMe  (false);
                    channelEntry->get_messages ()->append (messageEntry);
                }
                if (!channelEntry->get_members ()->getByUid (from)) {
                    QtIrcIdentity * identityEntry = new QtIrcIdentity;
                    identityEntry->update_nickname (from);
                    channelEntry->get_members ()->append (identityEntry);
                }
            }
            else if (commandStr == QByteArrayLiteral ("PART")) {
                QString from = QString::fromLocal8Bit(header.split('!').first());
                QString commandChannel = QString::fromLocal8Bit(parts.at (2));
                QtIrcChannel * channelEntry = qobject_cast<QtIrcChannel *>(m_channels->getByUid (commandChannel));
                if (channelEntry != NULL) {
                    if (from == m_nickname) { // me leaved channel
                        m_channels->remove (channelEntry);
                    }
                    else { // someone else leaved channel
                        QtIrcMessage * messageEntry = new QtIrcMessage;
                        messageEntry->update_content (QString ("%1 has leaved the channel.").arg (from));
                        messageEntry->update_type    (QtIrcMessage::Status);
                        messageEntry->update_toMe    (false);
                        messageEntry->update_fromMe  (false);
                        channelEntry->get_messages ()->append (messageEntry);
                        QtIrcIdentity * identityEntry = qobject_cast<QtIrcIdentity *> (channelEntry->get_members ()->getByUid (from));
                        if (identityEntry != NULL) {
                            channelEntry->get_members ()->remove (identityEntry);
                        }
                    }
                }
            }
            else if (commandStr == QByteArrayLiteral ("NOTICE")) {  // notice msg to me
                QString from = QString::fromLocal8Bit (parts.first ().split ('!').first ());
                qDebug() << "notice msg to me from" << from;
                QtIrcChannel * channelEntry = addChannelIfNotExists (from);
                QtIrcMessage * messageEntry = new QtIrcMessage;
                messageEntry->update_content (stringFromIrcByteArray (msg));
                messageEntry->update_from    (from);
                messageEntry->update_type    (QtIrcMessage::Normal);
                messageEntry->update_toMe    (false);
                messageEntry->update_fromMe  (false);
                channelEntry->get_messages ()->append (messageEntry);
            }
            else if (commandStr == QByteArrayLiteral ("PONG")) {
                // TODO ?
            }
            else if (commandStr == QByteArrayLiteral ("PING")) {
                QString from = QString::fromLocal8Bit(header.split('!').first ());
                m_socket->write (QString ("PONG %1 :%2").arg (from).arg (QString::fromLocal8Bit (msg)).toLocal8Bit ());
            }
            else if (commandStr == QByteArrayLiteral ("TOPIC")) {
                QString commandChannel = QString::fromLocal8Bit (parts.at (2));
                QString topic          = stringFromIrcByteArray (msg);
                QtIrcChannel * channelEntry = addChannelIfNotExists (commandChannel);
                channelEntry->update_topic (topic);
            }
            else if (commandStr == QByteArrayLiteral ("NICK")) {
                QString oldnick = QString::fromLocal8Bit (header.split ('!').first ());
                QString newnick = QString::fromLocal8Bit (msg);
                if (oldnick == m_nickname) {
                    update_nickname (newnick);
                }
                for (int channelIdx = 0; channelIdx > m_channels->count (); channelIdx++) {
                    QtIrcChannel * channelEntry = qobject_cast<QtIrcChannel *> (m_channels->get (channelIdx));
                    if (channelEntry != NULL) {
                        QtIrcIdentity * identityEntry = qobject_cast<QtIrcIdentity *> (channelEntry->get_members ()->getByUid (oldnick));
                        if (identityEntry != NULL) {
                            identityEntry->update_nickname (newnick);
                            QtIrcMessage * messageEntry = new QtIrcMessage;
                            messageEntry->update_content (QString ("%1 is now know as %2.").arg (oldnick).arg (newnick));
                            messageEntry->update_type    (QtIrcMessage::Status);
                            messageEntry->update_toMe    (false);
                            messageEntry->update_fromMe  (false);
                            channelEntry->get_messages ()->append (messageEntry);
                        }
                    }
                }
            }
            else if (commandStr == QByteArrayLiteral ("QUIT")) {
                QString from = QString::fromLocal8Bit(header.split('!').first ());
                if (from == m_nickname) {
                    QGuiApplication::quit ();
                }
            }
        }
    }
}

void QtIrcServer::onSocketBytesWritten () { }

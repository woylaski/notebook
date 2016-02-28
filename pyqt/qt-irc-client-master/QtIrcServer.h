#ifndef QTIRCSERVER_H
#define QTIRCSERVER_H

#include <QObject>
#include <QHostAddress>
#include <QHostInfo>
#include <QTimer>
#include <QTcpSocket>
#include <QQmlHelpers>
#include <QQmlObjectListModel>

class QtIrcChannel;
class QtIrcServer : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (bool, autoConnect)
    QML_READONLY_PROPERTY (bool, online)
    QML_READONLY_PROPERTY (quint16, port)
    QML_READONLY_PROPERTY (QString, host)
    QML_READONLY_PROPERTY (QString, nickname)
    QML_READONLY_PROPERTY (QtIrcChannel *, defaultChannelEntry)
    QML_CONSTANT_PROPERTY (QQmlObjectListModel *, channels)

public:
    explicit QtIrcServer (QObject * parent = NULL);

public slots:
    void tryConnect    (void);
    void tryDisconnect (void);
    void sendMessage   (QString data, QtIrcChannel * channelEntry = NULL);

signals:
    void connected     (void);
    void disconnected  (void);
    void errorMessage  (QString msg);

protected:
    void sendPing (void);
    QtIrcChannel * addChannelIfNotExists (QString name);

private slots:
    void onNetworkInfoChanged (void);
    void onSocketConnected    (void);
    void onSocketDisconnected (void);
    void onSocketError        (void);
    void onSocketReadyRead    (void);
    void onSocketBytesWritten (void);

private:
    QString      m_realHostname;
    QTimer     * m_timerKeepAlive;
    QTcpSocket * m_socket;
};

#endif // QTIRCSERVER_H

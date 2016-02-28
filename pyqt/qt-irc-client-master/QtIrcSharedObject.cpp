
#include "QtIrcSharedObject.h"
#include "QtIrcServer.h"

QtIrcSharedObject::QtIrcSharedObject(QObject *parent) :
    QObject(parent)
{
    m_servers = QQmlObjectListModel::create<QtIrcServer> (this);
    m_servers->setRoleNameForUid (QByteArrayLiteral ("host"));
}

void QtIrcSharedObject::addNewServer (QString host, quint16 port) {
    QtIrcServer * serverEntry = new QtIrcServer;
    serverEntry->update_host (host);
    serverEntry->update_port (port);
    m_servers->append (serverEntry);
}

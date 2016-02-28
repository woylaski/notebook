
#include "QtIrcChannel.h"
#include "QtIrcIdentity.h"
#include "QtIrcMessage.h"

QtIrcChannel::QtIrcChannel (QObject * parent)
    : QObject             (parent)
    , m_hasUnreadMessages (false)
{
    m_members  = QQmlObjectListModel::create<QtIrcIdentity> (this);
    m_members->setRoleNameForUid (QByteArrayLiteral ("nickname"));

    m_messages = QQmlObjectListModel::create<QtIrcMessage>  (this);
}

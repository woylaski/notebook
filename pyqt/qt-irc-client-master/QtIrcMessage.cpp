
#include "QtIrcMessage.h"

QtIrcMessage::QtIrcMessage (QObject * parent)
    : QObject     (parent)
    , m_toMe      (false)
    , m_fromMe    (false)
    , m_type      (Normal)
    , m_from      (QString ())
    , m_content   (QString ())
    , m_timestamp (QDateTime::currentDateTime ())
{

}

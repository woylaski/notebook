
#include "QtGitBranchEntry.h"

QtGitBranchEntry::QtGitBranchEntry (QObject * parent)
    : QObject         (parent)
    , m_name          (QString ())
    , m_upstreamName  (QString ())
    , m_isLocal       (true)
    , m_isHead        (false)
    , m_hasRemote     (false)
{

}

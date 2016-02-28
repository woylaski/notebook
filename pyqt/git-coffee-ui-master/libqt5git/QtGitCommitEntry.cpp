
#include "QtGitCommitEntry.h"
#include "QtGitDiffObject.h"

QtGitCommitEntry::QtGitCommitEntry (QObject * parent)
    : QObject          (parent)
    , m_objectId       (QString ())
    , m_messageSummary (QString ())
    , m_messageBody    (QString ())
    , m_authorMail     (QString ())
    , m_authorName     (QString ())
{
    m_diffFromParents = new QtGitDiffObject (this);
}

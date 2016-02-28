
#include "QtGitLineEntry.h"

QtGitLineEntry::QtGitLineEntry (QObject * parent)
    : QObject      (parent)
    , m_oldLineNum (-1)
    , m_newLineNum (-1)
    , m_added      (false)
    , m_removed    (false)
    , m_content    (QString ())
{

}

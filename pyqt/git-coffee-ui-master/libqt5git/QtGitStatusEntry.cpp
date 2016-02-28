
#include "QtGitStatusEntry.h"
#include "QtGitDiffObject.h"

QtGitStatusEntry::QtGitStatusEntry (QObject * parent)
    : QObject     (parent)
    , m_path      (QString ())
    , m_oldPath   (QString ())
    , m_type      (File)
    , m_nesting   (0)
    , m_unchanged (false)
    , m_ignored   (false)
    , m_untracked (false)
    , m_moved     (false)
    , m_modified  (false)
    , m_chmoded   (false)
    , m_deleted   (false)
    , m_shown     (false)
    , m_opened    (false)
{
    m_diffFromHead = new QtGitDiffObject (this);
}

bool QtGitStatusEntry::hasChanged () const {
    return (m_deleted || m_chmoded || m_modified || m_untracked || m_moved);
}

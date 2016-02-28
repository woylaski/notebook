
#include "QtGitDeltaEntry.h"
#include "QtGitHunkEntry.h"

QtGitDeltaEntry::QtGitDeltaEntry (QObject * parent)
    : QObject         (parent)
    , m_status        (Unknown)
    , m_addedCount    (0)
    , m_removedCount  (0)
    , m_isBinary      (false)
    , m_oldFilePath   (QString ())
    , m_newFilePath   (QString ())
{
    m_hunksModel = new QQmlObjectListModel<QtGitHunkEntry> (this);
}

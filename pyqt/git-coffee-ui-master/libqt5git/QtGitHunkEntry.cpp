
#include "QtGitHunkEntry.h"
#include "QtGitLineEntry.h"

QtGitHunkEntry::QtGitHunkEntry (QObject * parent)
    : QObject    (parent)
    , m_header   (QString ())
{
    m_linesModel = new QQmlObjectListModel<QtGitLineEntry> (this);
}

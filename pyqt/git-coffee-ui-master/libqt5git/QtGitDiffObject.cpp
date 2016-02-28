
#include "QtGitDiffObject.h"
#include "QtGitDeltaEntry.h"

QtGitDiffObject::QtGitDiffObject (QObject * parent)
    : QObject (parent)
{
    m_deltaModel = new QQmlObjectListModel<QtGitDeltaEntry> (this);
}

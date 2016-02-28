
#include "SharedObject.h"
#include "QtGitRepository.h"

#include <QDir>
#include <QDebug>
#include <QStringList>
#include <QStringBuilder>
#include <QProcess>
#include <QCoreApplication>

static const QString & configKeyLastRepos = QStringLiteral ("lastRepositories");
static const QString & homeDirShortPath   = QStringLiteral ("~/");

SharedObject::SharedObject (QObject * parent)
    : QObject          (parent)
    , m_isReposOpened  (false)
    , m_gitReposObj    (Q_NULLPTR)
    , m_gitConfig      (Q_NULLPTR)
{
    git_libgit2_init ();
    git_buf path = { Q_NULLPTR, 0, 0 };
    if (git_config_find_global (&path) == GIT_OK) {
        if (git_config_open_ondisk (&m_gitConfig, path.ptr) == GIT_OK) { }
    }
    m_lastRepositoriesModel = new QQmlVariantListModel (this);
    m_settings              = new QSettings            (this);
    if (m_settings->contains (configKeyLastRepos)) {
        const QVariant tmp = m_settings->value (configKeyLastRepos);
        QStringList list = tmp.value<QStringList> ();
        if (!list.isEmpty ()) {
            foreach (const QString & prettyPath, list) {
                if (QFile::exists (QString (prettyPath).replace (homeDirShortPath, QDir::homePath () % '/'))) {
                    m_lastRepositoriesModel->append (QVariant::fromValue (prettyPath));
                }
                else {
                    list.removeAll (prettyPath);
                }
            }
        }
        m_settings->setValue (configKeyLastRepos, list);
    }
}

SharedObject::~SharedObject () {
    git_libgit2_shutdown ();
}

void SharedObject::setConfigValue (const QString & key, const QString & value) {
    const QByteArray name = key.toLatin1 ();
    const QByteArray data = value.toLatin1 ();
    if (git_config_set_string (m_gitConfig, name.constData (), data.constData ()) == GIT_OK) { }
}

QString SharedObject::getConfigValue (const QString & key) {
    const QByteArray name = key.toLatin1 ();
    QString ret = QStringLiteral ("undefined");
    git_buf data = { Q_NULLPTR, 0, 0};
    if (git_config_get_string_buf (&data, m_gitConfig, name.constData ()) == GIT_OK) {
        ret = QString::fromUtf8 (data.ptr, int (data.size));
    }
    return ret;
}

QString SharedObject::getGitLibVersion () {
    int maj, min, rev;
    git_libgit2_version (&maj, &min, &rev);
    return QStringLiteral ("v%1.%2 r%3").arg (maj).arg (min).arg (rev);
}

bool SharedObject::containsGitRepository (QString directoryPath) {
    bool ret = false;
    if (!directoryPath.isEmpty ()) {
        QByteArray tmp = directoryPath.toUtf8 ();
        if (git_repository_open_ext (NULL, tmp.constData (), GIT_REPOSITORY_OPEN_NO_SEARCH, NULL) == GIT_OK) {
            ret = true;
        }
    }
    return ret;
}

void SharedObject::tryOpenGitRepository (QString directoryPath) {
    const QString prettyPath = directoryPath.replace (homeDirShortPath, QDir::homePath () % '/');
    if (!prettyPath.isEmpty () && QFile::exists (prettyPath)) {
        const QByteArray tmp = prettyPath.toUtf8 ();
        git_repository * gitReposHandle = Q_NULLPTR;
        if (git_repository_open (&gitReposHandle, tmp.constData ()) == GIT_OK) {
            QtGitRepository * reposObj = new QtGitRepository (gitReposHandle, this);
            connect (reposObj, &QtGitRepository::message,          this, &SharedObject::message);
            connect (reposObj, &QtGitRepository::repositoryOpened, this, &SharedObject::addRepositoryToRecentList);
            reposObj->initialize ();
            update_gitReposObj   (reposObj);
            update_isReposOpened (true);
            emit message (QtGitRepository::Info, tr ("The GIT repository is opened and valid."));
        }
        else {
            update_isReposOpened (false);
            emit message (QtGitRepository::Error, tr ("No GIT repository to open in this directory !"));
        }
    }
}

void SharedObject::addRepositoryToRecentList (QString directoryPath) {
    const QString prettyPath = directoryPath.replace (QDir::homePath () % '/', homeDirShortPath);
    QStringList list;
    if (m_settings->contains (configKeyLastRepos)) {
        const QVariant tmp = m_settings->value (configKeyLastRepos);
        list = tmp.value<QStringList> ();
    }
    if (list.contains (prettyPath)) {
        list.removeAll (prettyPath);
    }
    list.prepend (prettyPath);
    m_settings->setValue (configKeyLastRepos, list);
}

void SharedObject::launchInAnotherInstance (const QString & directoryPath) {
    QProcess::startDetached (qApp->applicationFilePath (), QStringList () << directoryPath);
}

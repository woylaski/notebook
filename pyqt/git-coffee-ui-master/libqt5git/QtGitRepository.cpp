
#include "QtGitRepository.h"
#include "QtGitStatusEntry.h"
#include "QtGitBranchEntry.h"
#include "QtGitCommitEntry.h"
#include "QtGitRemoteEntry.h"
#include "QtGitDeltaEntry.h"
#include "QtGitHunkEntry.h"
#include "QtGitLineEntry.h"
#include "QtGitDiffObject.h"
#include "QtGitTagEntry.h"

#include <QStringBuilder>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QGuiApplication>

inline const QByteArray strFromOid (const git_oid * gitOid) {
    QByteArray ret (GIT_OID_HEXSZ +1, '\0');
    git_oid_tostr (ret.data (), ret.size (), gitOid);
    return ret;
}

void getFileInfoRecursive (const QString & path, QList<QFileInfo> & ret, QDir::Filters filters) {
    QFileInfoList list = QDir (path).entryInfoList (QDir::Files |
                                                    QDir::Dirs |
                                                    QDir::Hidden |
                                                    QDir::NoSymLinks |
                                                    QDir::NoDotAndDotDot,
                                                    QDir::DirsFirst);
    foreach (const QFileInfo & fileInfo, list) {
        ret << fileInfo;
        if (fileInfo.isDir ()) {
            getFileInfoRecursive (fileInfo.filePath (), ret, filters);
        }
    }
}

QtGitRepository::QtGitRepository (git_repository * gitReposHandle, QObject * parent)
    : QObject            (parent)
    , m_isBareRepository (false)
    , m_repositoryPath   (QString ())
    , m_workingDirPath   (QString ())
    , m_gitReposHandle   (gitReposHandle)
{
    m_workTreeModel = new QQmlObjectListModel<QtGitStatusEntry> (this, "", "path");
    m_branchesModel = new QQmlObjectListModel<QtGitBranchEntry> (this, "", "name");
    m_commitsModel  = new QQmlObjectListModel<QtGitCommitEntry> (this, "", "objectId");
    m_remotesModel  = new QQmlObjectListModel<QtGitRemoteEntry> (this, "", "name");
    m_tagsModel     = new QQmlObjectListModel<QtGitTagEntry>    (this, "", "name");
}

QtGitRepository::~QtGitRepository (void) {
    git_repository_free (m_gitReposHandle);
}

void QtGitRepository::initialize (void) {
    if (m_gitReposHandle) {
        update_isBareRepository (bool (git_repository_is_bare              (m_gitReposHandle)));
        update_repositoryPath   (QString::fromUtf8 (git_repository_path    (m_gitReposHandle)));
        update_workingDirPath   (QString::fromUtf8 (git_repository_workdir (m_gitReposHandle)));
        QList<QFileInfo> tmp;
        tmp.reserve (10000);
        getFileInfoRecursive (get_workingDirPath (),
                              tmp,
                              QDir::Files |
                              QDir::Dirs |
                              QDir::Hidden |
                              QDir::NoSymLinks |
                              QDir::NoDotAndDotDot);
        quint64 totalSize = 0;
        foreach (const QFileInfo & info, tmp) {
            //qDebug () << info.filePath () << info.size ();
            totalSize += quint64 (info.size ());
        }
        qDebug () << "repos size:" << totalSize;
    }
    emit repositoryOpened (m_repositoryPath);
}

void QtGitRepository::refreshWorkingDirectory (void) {
    m_workTreeModel->clear ();
    QList<QtGitStatusEntry *> tmp;
    QHash<QString, QtGitStatusEntry *> hash;
    emit message (Debug, tr ("Iterating status log..."));
    git_status_options gitStatusOptions = {
        GIT_STATUS_OPTIONS_VERSION,
        GIT_STATUS_SHOW_INDEX_AND_WORKDIR,
        (GIT_STATUS_OPT_INCLUDE_UNTRACKED
        | GIT_STATUS_OPT_INCLUDE_IGNORED
        | GIT_STATUS_OPT_INCLUDE_UNMODIFIED
        | GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS
        | GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY),
        { NULL, 0 }
    };
    git_status_list * gitStatusList;
    if (git_status_list_new (&gitStatusList, m_gitReposHandle, &gitStatusOptions) == GIT_OK) {
        emit message (Debug, tr ("Status log iterated."));
        unsigned int count = git_status_list_entrycount (gitStatusList);
        for (unsigned int idx = 0; idx < count; idx++) {
            bool isSubModule = false;
            const git_status_entry * gitStatusEntry = git_status_byindex (gitStatusList, idx);
            if (gitStatusEntry) {
                int status_flags = gitStatusEntry->status;
                const char * old_path, * new_path;
                if (gitStatusEntry->head_to_index) {
                    old_path    = gitStatusEntry->head_to_index->old_file.path;
                    new_path    = gitStatusEntry->head_to_index->new_file.path;
                    isSubModule = (gitStatusEntry->head_to_index->new_file.mode == GIT_FILEMODE_COMMIT);
                }
                else if (gitStatusEntry->index_to_workdir) {
                    old_path    = gitStatusEntry->index_to_workdir->old_file.path;
                    new_path    = gitStatusEntry->index_to_workdir->new_file.path;
                    isSubModule = (gitStatusEntry->index_to_workdir->new_file.mode == GIT_FILEMODE_COMMIT);
                }
                else {
                    old_path = "";
                    new_path = "";
                }
                QString oldPathStr = QString::fromUtf8 (old_path);
                QString newPathStr = QString::fromUtf8 (new_path);
                int level = 0;
                QStringList pathList;
                if (newPathStr.contains ('/')) { // subpath
                    QStringList parts = newPathStr.split ('/', QString::SkipEmptyParts);
                    parts.removeLast ();
                    QString curr;
                    foreach (QString word, parts) {
                        curr.append (word);
                        curr.append ('/');
                        pathList << curr;
                        if (!hash.keys ().contains (curr)) {
                            QtGitStatusEntry * folderEntryObj = new QtGitStatusEntry;
                            folderEntryObj->blockSignals     (true);
                            folderEntryObj->update_type      (QtGitStatusEntry::Folder);
                            folderEntryObj->update_path      (curr);
                            folderEntryObj->update_nesting   (level);
                            folderEntryObj->update_unchanged (true);
                            folderEntryObj->set_opened       (false);
                            folderEntryObj->set_shown        (level == 0);
                            folderEntryObj->blockSignals     (false);
                            tmp << folderEntryObj;
                            hash.insert (curr, folderEntryObj);
                        }
                        level++;
                    }
                }
                if (isSubModule) {
                    // TODO : maybe detect more correclty if submodule has changed and needs commit
                    QtGitStatusEntry * submoduleEntryObj = new QtGitStatusEntry;
                    submoduleEntryObj->blockSignals     (true);
                    submoduleEntryObj->update_type      (QtGitStatusEntry::SubModule);
                    submoduleEntryObj->update_path      (newPathStr);
                    submoduleEntryObj->update_oldPath   (oldPathStr);
                    submoduleEntryObj->update_nesting   (level);
                    submoduleEntryObj->update_unchanged (status_flags == GIT_STATUS_CURRENT);
                    submoduleEntryObj->update_ignored   (status_flags &  GIT_STATUS_IGNORED);
                    submoduleEntryObj->update_untracked (status_flags &  GIT_STATUS_WT_NEW        || status_flags & GIT_STATUS_INDEX_NEW);
                    submoduleEntryObj->update_moved     (status_flags &  GIT_STATUS_WT_RENAMED    || status_flags & GIT_STATUS_INDEX_RENAMED);
                    submoduleEntryObj->update_modified  (status_flags &  GIT_STATUS_WT_MODIFIED   || status_flags & GIT_STATUS_INDEX_MODIFIED);
                    submoduleEntryObj->update_chmoded   (status_flags &  GIT_STATUS_WT_TYPECHANGE || status_flags & GIT_STATUS_INDEX_TYPECHANGE);
                    submoduleEntryObj->update_deleted   (status_flags &  GIT_STATUS_WT_DELETED    || status_flags & GIT_STATUS_INDEX_DELETED);
                    submoduleEntryObj->set_shown        (level == 0);
                    submoduleEntryObj->set_opened       (false);
                    submoduleEntryObj->blockSignals     (false);
                    tmp << submoduleEntryObj;
                    hash.insert (newPathStr, submoduleEntryObj);
                }
                else {
                    QtGitStatusEntry * fileEntryObj = new QtGitStatusEntry;
                    fileEntryObj->blockSignals     (true);
                    fileEntryObj->update_type      (QtGitStatusEntry::File);
                    fileEntryObj->update_path      (newPathStr);
                    fileEntryObj->update_oldPath   (oldPathStr);
                    fileEntryObj->update_nesting   (level);
                    fileEntryObj->update_unchanged (status_flags == GIT_STATUS_CURRENT);
                    fileEntryObj->update_ignored   (status_flags &  GIT_STATUS_IGNORED);
                    fileEntryObj->update_untracked (status_flags &  GIT_STATUS_WT_NEW        || status_flags & GIT_STATUS_INDEX_NEW);
                    fileEntryObj->update_moved     (status_flags &  GIT_STATUS_WT_RENAMED    || status_flags & GIT_STATUS_INDEX_RENAMED);
                    fileEntryObj->update_modified  (status_flags &  GIT_STATUS_WT_MODIFIED   || status_flags & GIT_STATUS_INDEX_MODIFIED);
                    fileEntryObj->update_chmoded   (status_flags &  GIT_STATUS_WT_TYPECHANGE || status_flags & GIT_STATUS_INDEX_TYPECHANGE);
                    fileEntryObj->update_deleted   (status_flags &  GIT_STATUS_WT_DELETED    || status_flags & GIT_STATUS_INDEX_DELETED);
                    fileEntryObj->set_shown        (level == 0);
                    fileEntryObj->set_opened       (false);
                    fileEntryObj->blockSignals     (false);
                    tmp << fileEntryObj;
                    hash.insert (newPathStr, fileEntryObj);
                    if (fileEntryObj->hasChanged ()) {
                        foreach (QString folder, pathList) {
                            QtGitStatusEntry * folderEntryObj = hash.value (folder);
                            if (folderEntryObj) {
                                folderEntryObj->update_modified (true);
                            }
                        }
                    }
                }
            }
            QGuiApplication::processEvents ();
        }
        git_status_list_free (gitStatusList);
    }
    else {
        emit message (Error, tr ("Status log list couldn't be iterated !"));
    }
    m_workTreeModel->append (tmp);
}

void QtGitRepository::refreshBranches (void) {
    m_branchesModel->clear ();
    emit message (Debug, tr ("Iterating branches..."));
    QList<QtGitBranchEntry *> tmp;
    tmp.reserve (1000);
    git_strarray gitRefsStrList = { NULL, 0 };
    if (git_reference_list (&gitRefsStrList, m_gitReposHandle) == GIT_OK) {
        for (unsigned int idx = 0; idx < gitRefsStrList.count; idx++) {
            git_reference * gitRefHandle;
            if (git_reference_lookup (&gitRefHandle, m_gitReposHandle, gitRefsStrList.strings [idx]) == GIT_OK) {
                const bool isRemote = git_reference_is_remote (gitRefHandle);
                const bool isBranch = git_reference_is_branch (gitRefHandle);
                if (isBranch || isRemote) { // local branch
                    QtGitBranchEntry * branchEntry = new QtGitBranchEntry;
                    branchEntry->blockSignals (true);
                    branchEntry->update_isHead (git_branch_is_head (gitRefHandle));
                    branchEntry->update_isLocal (!isRemote);
                    const char * gitBranchName;
                    if (git_branch_name (&gitBranchName, gitRefHandle) == GIT_OK) {
                        branchEntry->update_name (QString::fromUtf8 (gitBranchName));
                    }
                    if (!isRemote) {
                        git_reference * gitRefUpstreamHandle;
                        if (git_branch_upstream (&gitRefUpstreamHandle, gitRefHandle) == GIT_OK) {
                            branchEntry->update_hasRemote (true);
                            const char * gitUpstreamBranchName;
                            if (git_branch_name (&gitUpstreamBranchName, gitRefUpstreamHandle) == GIT_OK) {
                                branchEntry->update_upstreamName (QString::fromUtf8 (gitUpstreamBranchName));
                            }
                        }
                    }
                    branchEntry->blockSignals (false);
                    tmp << branchEntry;
                }
            }
        }
        emit message (Debug, tr ("Branches iterated."));
    }
    else {
        qWarning () << "QtGit >> creating branch list : FAILED !";
    }
    m_branchesModel->append (tmp);
    git_strarray_free (&gitRefsStrList);
}

void QtGitRepository::refreshRemotes (void) {
    m_remotesModel->clear ();
    emit message (Debug, tr ("Listing remotes..."));
    git_strarray gitRemotesStrList = { NULL, 0 };
    if (git_remote_list (&gitRemotesStrList, m_gitReposHandle) == GIT_OK) {
        for (unsigned int idx = 0; idx < gitRemotesStrList.count; idx++) {
            QtGitRemoteEntry * remoteEntry = new QtGitRemoteEntry;
            remoteEntry->update_name (QString::fromLatin1 (gitRemotesStrList.strings [idx]));
            m_remotesModel->append (remoteEntry);
        }
        emit message (Debug, tr ("Remotes listed."));
    }
    else {
        emit message (Warning, tr ("Remotes couldn't be listed !"));
    }
    git_strarray_free (&gitRemotesStrList);
}

void QtGitRepository::refreshCommits (void) {
    m_commitsModel->clear ();
    QList<QtGitCommitEntry *> tmp;
    tmp.reserve (10000);
    emit message (Debug, tr ("Creating RevWalker..."));
    git_revwalk * gitRevWalkerHandle;
    if (git_revwalk_new (&gitRevWalkerHandle, m_gitReposHandle) == GIT_OK) {
        emit message (Debug, tr ("RevWalker created."));
        git_revwalk_sorting (gitRevWalkerHandle, GIT_SORT_TOPOLOGICAL | GIT_SORT_TIME);
        //git_revwalk_push_range (gitRevWalkerHandle, "HEAD~25..HEAD");
        //git_revwalk_simplify_first_parent (gitRevWalkerHandle);
        git_revwalk_push_head (gitRevWalkerHandle);
        git_oid gitCommitOid;
        while (git_revwalk_next (&gitCommitOid, gitRevWalkerHandle) == GIT_OK) {
            QtGitCommitEntry * commitEntry = new QtGitCommitEntry;
            commitEntry->blockSignals (true);
            git_commit * gitCommitHandle = NULL;
            git_commit_lookup (&gitCommitHandle, m_gitReposHandle, &gitCommitOid);
            commitEntry->update_objectId       (QString::fromLocal8Bit (strFromOid (&gitCommitOid)));
            commitEntry->update_messageSummary (QString::fromUtf8 (git_commit_summary (gitCommitHandle)));
            const git_signature * gitSignature = git_commit_author (gitCommitHandle);
            commitEntry->update_authorMail     (QString::fromUtf8 (gitSignature->email));
            commitEntry->update_authorName     (QString::fromUtf8 (gitSignature->name));
            commitEntry->update_authorWhen     (QDateTime::fromMSecsSinceEpoch (gitSignature->when.time * 1000));
            git_commit_free (gitCommitHandle);
            commitEntry->blockSignals (false);
            tmp << commitEntry;
            QGuiApplication::processEvents ();
        }
        git_revwalk_free (gitRevWalkerHandle);
    }
    else {
        emit message (Warning, tr ("RevWalker couldn't be created !"));
    }
    m_commitsModel->append (tmp);
}

void QtGitRepository::refreshTags (void) {
    m_tagsModel->clear ();
    emit message (Debug, tr ("Listing tags..."));
    git_strarray gitTagsStrList = { NULL, 0 };
    if (git_tag_list (&gitTagsStrList, m_gitReposHandle) == GIT_OK) {
        for (unsigned int idx = 0; idx < gitTagsStrList.count; idx++) {
            QtGitTagEntry * tagEntry = new QtGitTagEntry;
            tagEntry->update_name (QString::fromLatin1 (gitTagsStrList.strings [idx]));
            m_tagsModel->append (tagEntry);
        }
        emit message (Debug, tr ("Tags listed."));
    }
    else {
        emit message (Warning, tr ("Tags couldn't be listed !"));
    }
    git_strarray_free (&gitTagsStrList);
}

void QtGitRepository::loadDetailsForCommit (QtGitCommitEntry * commitEntry) {
    if (commitEntry != NULL && commitEntry->get_diffFromParents ()->get_deltaModel ()->isEmpty ()) {
        QByteArray tmp = commitEntry->get_objectId ().toLocal8Bit ();
        git_oid gitCommitOid;
        if (git_oid_fromstr (&gitCommitOid, tmp.constData ()) == GIT_OK) {
            git_commit * gitCommitHandle = NULL;
            if (git_commit_lookup (&gitCommitHandle, m_gitReposHandle, &gitCommitOid) == GIT_OK) {
                QStringList parentsIds;
                commitEntry->update_messageBody (QString::fromUtf8 (git_commit_message (gitCommitHandle)));
                git_tree * gitCommitTreeHandle = NULL;
                git_commit_tree (&gitCommitTreeHandle, gitCommitHandle);
                if (git_commit_parentcount (gitCommitHandle) > 0) {
                    for (unsigned int parentIdx = 0; parentIdx < git_commit_parentcount (gitCommitHandle); parentIdx++) {
                        git_commit * gitCommitParentHandle = NULL;
                        if (git_commit_parent (&gitCommitParentHandle, gitCommitHandle, parentIdx) == GIT_OK) {
                            const git_oid * gitCommitParentOid = git_commit_id (gitCommitParentHandle);
                            parentsIds << QString::fromLocal8Bit (strFromOid (gitCommitParentOid));
                            git_tree * gitCommitParentTreeHandle = NULL;
                            if (git_commit_tree (&gitCommitParentTreeHandle, gitCommitParentHandle) == GIT_OK) {
                                git_diff * gitDiffHandle = NULL;
                                if (git_diff_tree_to_tree (&gitDiffHandle, m_gitReposHandle, gitCommitParentTreeHandle, gitCommitTreeHandle, NULL) == GIT_OK) {
                                    fillDiffObjectWithGitDiff (commitEntry->get_diffFromParents (), gitDiffHandle);
                                    git_diff_free (gitDiffHandle);
                                }
                                git_tree_free (gitCommitParentTreeHandle);
                            }
                            git_commit_free (gitCommitParentHandle);
                        }
                    }
                }
                else {
                    git_diff * gitDiffHandle = NULL;
                    if (git_diff_tree_to_tree (&gitDiffHandle, m_gitReposHandle, NULL, gitCommitTreeHandle, NULL) == GIT_OK) {
                        fillDiffObjectWithGitDiff (commitEntry->get_diffFromParents (), gitDiffHandle);
                        git_diff_free (gitDiffHandle);
                    }
                }
                commitEntry->update_parentsIds (parentsIds);
                git_tree_free (gitCommitTreeHandle);
                git_commit_free (gitCommitHandle);
            }
            else {
                qWarning () << "Couldn't lookup commit from OID !";
            }
        }
        else {
            qWarning () << "Couldn't create OID from string !" << tmp;
        }
    }
    else {
        qWarning () << "Couldn't diff an invalid commit entry or with invalid diff object!";
    }
}

void QtGitRepository::loadDiffToHeadForStatus (QtGitStatusEntry * statusEntry) {
    if (statusEntry != NULL) {
        if (statusEntry->get_diffFromHead ()->get_deltaModel ()->isEmpty ()) {
            git_reference * gitHeadRef = NULL;
            if (git_repository_head (&gitHeadRef, m_gitReposHandle) == GIT_OK) {
                git_object * gitHeadObject = NULL;
                if (git_reference_peel (&gitHeadObject, gitHeadRef, GIT_OBJ_TREE) == GIT_OK) {
                    git_tree * gitHeadTree = NULL;
                    if (git_tree_lookup (&gitHeadTree, m_gitReposHandle, git_object_id (gitHeadObject)) == GIT_OK) {
                        QByteArray tmp = statusEntry->get_path ().toUtf8 ();
                        char * str = tmp.data ();
                        git_diff_options gitDiffOpt = {
                            GIT_DIFF_OPTIONS_VERSION,
                            GIT_DIFF_NORMAL,
                            GIT_SUBMODULE_IGNORE_UNSPECIFIED,
                            { &str, 1 },
                            NULL, NULL,
                            3, 0, 7,
                            (8 * 1024 * 1024),
                            "a", "b"
                        };
                        git_diff * gitDiffHandle = NULL;
                        if (git_diff_tree_to_workdir_with_index (&gitDiffHandle, m_gitReposHandle, gitHeadTree, &gitDiffOpt) == GIT_OK) {
                            fillDiffObjectWithGitDiff (statusEntry->get_diffFromHead (), gitDiffHandle);
                            git_diff_free (gitDiffHandle);
                        }
                        git_tree_free (gitHeadTree);
                    }
                    else {
                        qWarning () << "Couldn't lookup treeish object for HEAD !";
                    }
                    git_object_free (gitHeadObject);
                }
                else {
                    qWarning () << "Couldn't get object tree from HEAD !";
                }
                git_reference_free (gitHeadRef);
            }
            else {
                qWarning () << "Couldn't get reference to HEAD !";
            }
        }
    }
    else {
        qWarning () << "Couldn't diff an invalid status entry !";
    }
}

int QtGitRepository::callbackForEachBin (const git_diff_delta * gitDeltaStruct, const git_diff_binary * binary, void * payload) {
    Q_UNUSED (gitDeltaStruct)
    Q_UNUSED (binary)
    Q_UNUSED (payload)
    return GIT_OK;
}

int QtGitRepository::callbackForEachDelta (const git_diff_delta * gitDeltaStruct, float progress, void * payload) {
    Q_UNUSED (progress)
    QtGitDiffObject * diffObj = (QtGitDiffObject *) payload;
    if (diffObj) {
        QtGitDeltaEntry * deltaEntry = new QtGitDeltaEntry;
        deltaEntry->blockSignals (true);
        switch (gitDeltaStruct->status) {
            case GIT_DELTA_UNMODIFIED:
                deltaEntry->update_status (QtGitDeltaEntry::UnModified);
                break;
            case GIT_DELTA_ADDED:
                deltaEntry->update_status (QtGitDeltaEntry::Added);
                break;
            case GIT_DELTA_DELETED:
                deltaEntry->update_status (QtGitDeltaEntry::Deleted);
                break;
            case GIT_DELTA_MODIFIED:
                deltaEntry->update_status (QtGitDeltaEntry::Modified);
                break;
            case GIT_DELTA_RENAMED:
                deltaEntry->update_status (QtGitDeltaEntry::Renamed);
                break;
            case GIT_DELTA_COPIED:
                deltaEntry->update_status (QtGitDeltaEntry::Copied);
                break;
            case GIT_DELTA_IGNORED:
                deltaEntry->update_status (QtGitDeltaEntry::Ignored);
                break;
            case GIT_DELTA_UNTRACKED:
                deltaEntry->update_status (QtGitDeltaEntry::UnTracked);
                break;
            case GIT_DELTA_TYPECHANGE:
                deltaEntry->update_status (QtGitDeltaEntry::TypeChanged);
                break;
            default:
                deltaEntry->update_status (QtGitDeltaEntry::Unknown);
                break;
        }
        deltaEntry->update_oldFilePath (QString::fromUtf8 (gitDeltaStruct->old_file.path));
        deltaEntry->update_newFilePath (QString::fromUtf8 (gitDeltaStruct->new_file.path));
        deltaEntry->update_isBinary    (!(gitDeltaStruct->flags & GIT_DIFF_FLAG_NOT_BINARY));
        deltaEntry->blockSignals (false);
        diffObj->get_deltaModel ()->append (deltaEntry);
    }
    return GIT_OK;
}

int QtGitRepository::callbackForEachHunk (const git_diff_delta * gitDeltaStruct, const git_diff_hunk * gitHunkStruct, void * payload) {
    Q_UNUSED (gitDeltaStruct)
    QtGitDiffObject * diffObj = (QtGitDiffObject *) payload;
    if (diffObj) {
        QtGitDeltaEntry * deltaEntry = qobject_cast<QtGitDeltaEntry *> (diffObj->get_deltaModel ()->last ());
        if (deltaEntry) {
            QtGitHunkEntry * hunkEntry = new QtGitHunkEntry;
            hunkEntry->blockSignals  (true);
            hunkEntry->update_header (QStringLiteral ("@@ -%1,%2 +%3,%4 @@")
                                      .arg (gitHunkStruct->old_start)
                                      .arg (gitHunkStruct->old_lines)
                                      .arg (gitHunkStruct->new_start)
                                      .arg (gitHunkStruct->new_lines));
            hunkEntry->blockSignals  (false);
            deltaEntry->get_hunksModel ()->append (hunkEntry);
        }
    }
    return GIT_OK;
}

int QtGitRepository::callbackForEachLine (const git_diff_delta * gitDeltaStruct, const git_diff_hunk * gitHunkStruct, const git_diff_line * gitLineStruct, void * payload) {
    Q_UNUSED (gitDeltaStruct)
    Q_UNUSED (gitHunkStruct)
    QtGitDiffObject * diffObj = (QtGitDiffObject *) payload;
    if (diffObj) {
        QtGitDeltaEntry * deltaEntry = qobject_cast<QtGitDeltaEntry *> (diffObj->get_deltaModel ()->last ());
        if (deltaEntry) {
            QtGitHunkEntry * hunkEntry = qobject_cast<QtGitHunkEntry *> (deltaEntry->get_hunksModel ()->last ());
            if (hunkEntry) {
                QtGitLineEntry * lineEntry = new QtGitLineEntry;
                lineEntry->blockSignals (true);
                lineEntry->update_oldLineNum (gitLineStruct->old_lineno);
                if (lineEntry->get_oldLineNum () == -1) {
                    lineEntry->update_added (true);
                    deltaEntry->update_addedCount (deltaEntry->get_addedCount () +1);
                }
                lineEntry->update_newLineNum (gitLineStruct->new_lineno);
                if (lineEntry->get_newLineNum () == -1) {
                    lineEntry->update_removed (true);
                    deltaEntry->update_removedCount (deltaEntry->get_removedCount () +1);
                }
                lineEntry->update_content (QString::fromUtf8 (gitLineStruct->content, gitLineStruct->content_len));
                lineEntry->blockSignals (false);
                hunkEntry->get_linesModel ()->append (lineEntry);
            }
        }
    }
    return GIT_OK;
}

void QtGitRepository::fillDiffObjectWithGitDiff (QtGitDiffObject * diffObj, git_diff * gitDiffHandle) {
    git_diff_foreach (gitDiffHandle,
                      &callbackForEachDelta,
                      &callbackForEachBin,
                      &callbackForEachHunk,
                      &callbackForEachLine,
                      diffObj);
}

#ifndef QTGITREPOSITORY_H
#define QTGITREPOSITORY_H

#include <QObject>
#include <QDateTime>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlPtrPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"
#include "QQmlObjectListModel.h"
#include "QQmlVariantListModel.h"

#include "git2.h"

#define FAKE_CONSTRUCTOR(T)  T (QObject * parent = NULL) : QObject (parent) { qFatal ("Don't use this fake constructor !!!"); }

class QtGitCommitEntry;
class QtGitBranchEntry;
class QtGitStatusEntry;
class QtGitRemoteEntry;
class QtGitTagEntry;
class QtGitDiffObject;

class QtGitRepository : public QObject {
    Q_OBJECT
    Q_ENUMS (MessageLevel)
    QML_READONLY_VAR_PROPERTY (bool, isBareRepository)
    QML_READONLY_CSTREF_PROPERTY (QString, repositoryPath)
    QML_READONLY_CSTREF_PROPERTY (QString, workingDirPath)
    QML_OBJMODEL_PROPERTY (QtGitStatusEntry, workTreeModel)
    QML_OBJMODEL_PROPERTY (QtGitBranchEntry, branchesModel)
    QML_OBJMODEL_PROPERTY (QtGitCommitEntry, commitsModel)
    QML_OBJMODEL_PROPERTY (QtGitRemoteEntry, remotesModel)
    QML_OBJMODEL_PROPERTY (QtGitTagEntry, tagsModel)

public:
    FAKE_CONSTRUCTOR (QtGitRepository)
    explicit QtGitRepository (git_repository * gitReposHandle, QObject * parent = NULL);
    virtual ~QtGitRepository ();

    void initialize ();

    enum MessageLevel {
        Debug,
        Info,
        Warning,
        Error
    };

public slots:
    void refreshWorkingDirectory (void);
    void refreshBranches         (void);
    void refreshRemotes          (void);
    void refreshCommits          (void);
    void refreshTags             (void);
    void loadDetailsForCommit    (QtGitCommitEntry * commitEntry);
    void loadDiffToHeadForStatus (QtGitStatusEntry * statusEntry);

signals:
    void message                 (MessageLevel level, const QString & msg);
    void repositoryOpened        (QString directoryPath);

protected:
    static int callbackForEachBin   (const git_diff_delta * gitDeltaStruct, const git_diff_binary * binary, void * payload);
    static int callbackForEachDelta (const git_diff_delta * gitDeltaStruct, float progress, void * payload);
    static int callbackForEachHunk  (const git_diff_delta * gitDeltaStruct, const git_diff_hunk * gitHunkStruct, void * payload);
    static int callbackForEachLine  (const git_diff_delta * gitDeltaStruct, const git_diff_hunk * gitHunkStruct, const git_diff_line * gitLineStruct, void * payload);
    static void fillDiffObjectWithGitDiff (QtGitDiffObject * diffObj, git_diff * gitDiffHandle);

private:
    git_repository * m_gitReposHandle;
};

#endif // QTGITREPOSITORY_H

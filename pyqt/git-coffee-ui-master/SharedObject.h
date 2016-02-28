#ifndef SHAREDOBJECT_H
#define SHAREDOBJECT_H

#include <QObject>
#include <QSettings>

#include "QQmlVarPropertyHelpers.h"
#include "QQmlPtrPropertyHelpers.h"
#include "QQmlVariantListModel.h"

#include "git2.h"

class QtGitRepository;

class SharedObject : public QObject {
    Q_OBJECT
    Q_ENUMS (MessageLevel)
    QML_READONLY_VAR_PROPERTY (bool,                 isReposOpened)
    QML_READONLY_PTR_PROPERTY (QtGitRepository,      gitReposObj)
    QML_CONSTANT_PTR_PROPERTY (QQmlVariantListModel, lastRepositoriesModel)

public:
    explicit SharedObject (QObject * parent = NULL);
    ~SharedObject ();

    Q_INVOKABLE QString getConfigValue (const QString & key);
    Q_INVOKABLE void    setConfigValue (const QString & key, const QString & value);

public slots:
    QString getGitLibVersion          (void);
    bool    containsGitRepository     (QString directoryPath);
    void    tryOpenGitRepository      (QString directoryPath);
    void    addRepositoryToRecentList (QString directoryPath);
    void    launchInAnotherInstance   (const QString & directoryPath);

signals:
    void message (int level, QString msg);

protected:
    QString getGitConfigStringValue (const QByteArray & value, const QString & fallback);

private:
    git_config * m_gitConfig;
    QSettings * m_settings;
};

#endif // SHAREDOBJECT_H

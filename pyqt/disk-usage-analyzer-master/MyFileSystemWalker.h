#ifndef MYFILESYSTEMWALKER_H
#define MYFILESYSTEMWALKER_H

#include <QObject>
#include <QString>
#include <QVariant>
#include <QFileInfo>
#include <QFileInfoList>
#include <QDir>
#include <QList>
#include <QHash>
#include <QColor>
#include <QFuture>
#include <QTimer>
#include <QListIterator>
#include <QtConcurrent>
#include <QDateTime>

class MyFileSystemNodeItem : public QObject {
    Q_OBJECT
    Q_PROPERTY (bool    dir  READ isDir   CONSTANT)
    Q_PROPERTY (qreal   size READ getSize CONSTANT)
    Q_PROPERTY (QString path READ getPath CONSTANT)
    Q_PROPERTY (QString name READ getName CONSTANT)

public:
    explicit MyFileSystemNodeItem (const QFileInfo & info, QObject * parent = NULL);

    static MyFileSystemNodeItem * getInstanceByPath (const QString & path);

    static quint64 getInstancesCount (void);

    static void reserveInstances (quint64 count);

    bool    isDir   (void) const;
    qreal   getSize (void) const;
    QString getPath (void) const;
    QString getName (void) const;

protected:
    static QHash<QString, MyFileSystemNodeItem *> s_instances;

private:
    quint64   m_size;
    QFileInfo m_info;
};

class MyFileSystemWalker : public QObject {
    Q_OBJECT
    Q_PROPERTY (bool         working READ isWorking NOTIFY workingChanged)
    Q_PROPERTY (int          count   READ getCount  NOTIFY countChanged)
    Q_PROPERTY (qreal        time    READ getTime   NOTIFY timeChanged)
    Q_PROPERTY (quint64      nodes   READ getNodes  NOTIFY nodesChanged)
    Q_PROPERTY (quint64      total   READ getTotal  NOTIFY totalChanged)
    Q_PROPERTY (QString      base    READ getBase   NOTIFY baseChanged)
    Q_PROPERTY (QString      title   READ getTitle  NOTIFY titleChanged)
    Q_PROPERTY (QString      place   READ getPlace  NOTIFY placeChanged)
    Q_PROPERTY (QStringList  list    READ getList   NOTIFY listChanged)
    Q_PROPERTY (QVariantList tree    READ getTree   NOTIFY treeChanged)

public:
    explicit MyFileSystemWalker (QObject * parent = NULL);
    virtual ~MyFileSystemWalker (void);

    MyFileSystemNodeItem * initCacheWithPath (const QString & path);

    bool         isWorking (void) const;
    int          getCount  (void) const;
    qreal        getTime   (void) const;
    quint64      getNodes  (void) const;
    quint64      getTotal  (void) const;
    QString      getBase   (void) const;
    QString      getTitle  (void) const;
    QString      getPlace  (void) const;
    QStringList  getList   (void) const;
    QVariantList getTree   (void) const;

    Q_INVOKABLE int getItemIndexForAngle (qreal angle);

public slots:
    void changeTreePath (QString path);

protected slots:
    void checkWorker (void);

signals:
    void workingChanged (void);
    void countChanged   (void);
    void timeChanged    (void);
    void nodesChanged   (void);
    void totalChanged   (void);
    void baseChanged    (void);
    void titleChanged   (void);
    void placeChanged   (void);
    void listChanged    (void);
    void treeChanged    (void);

private:
    int                             m_count;
    qreal                           m_time;
    quint64                         m_nodes;
    quint64                         m_total;
    QString                         m_base;
    QString                         m_title;
    QString                         m_place;
    QTimer                       *  m_timer;
    QDateTime                       m_start;
    QStringList                     m_list;
    QVariantList                    m_tree;
    MyFileSystemNodeItem         *  m_rootItem;
    QFuture<MyFileSystemNodeItem *> m_worker;
};

#endif // MYFILESYSTEMWALKER_H

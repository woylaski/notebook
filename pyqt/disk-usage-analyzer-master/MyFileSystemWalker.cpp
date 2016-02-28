
#include "MyFileSystemWalker.h"

#include <qmath.h>

#undef USE_ITERATOR
#undef USE_FOREACH

static QFlags<QDir::Filter> filter (QDir::Dirs | QDir::Files | QDir::NoSymLinks | QDir::NoDotAndDotDot | QDir::Hidden);
static QFlags<QDir::SortFlag> sort (QDir::DirsFirst | QDir::Size);

QHash<QString, MyFileSystemNodeItem *> MyFileSystemNodeItem::s_instances;

MyFileSystemNodeItem::MyFileSystemNodeItem (const QFileInfo & info, QObject * parent)
    : QObject (parent)
    , m_size  (info.size ())
    , m_info  (info)
{
    MyFileSystemNodeItem::s_instances.insert (m_info.filePath (), this);
    if (m_info.isDir ()) {
        const QFileInfoList list (QDir (m_info.filePath ()).entryInfoList (filter, sort));
#ifdef USE_ITERATOR
        QListIterator<QFileInfo> it (list);
        while (it.hasNext ()) {
            m_size += (new MyFileSystemNodeItem (it.next (), this))->getSize ();
        }
#else
#   ifdef USE_FOREACH
        foreach (QFileInfo entry, list) {
            m_size += (new MyFileSystemNodeItem (entry, this))->getSize ();
        }

#   else
        const int nb = list.count ();
        for (int idx = 0; idx < nb; idx++) {
            m_size += (new MyFileSystemNodeItem (list.at (idx), this))->getSize ();
        }
#   endif
#endif
    }
}

MyFileSystemNodeItem * MyFileSystemNodeItem::getInstanceByPath (const QString & path) {
    return MyFileSystemNodeItem::s_instances.value (path, NULL);
}

quint64 MyFileSystemNodeItem::getInstancesCount (void) {
    return MyFileSystemNodeItem::s_instances.count ();
}

void MyFileSystemNodeItem::reserveInstances (quint64 count) {
    MyFileSystemNodeItem::s_instances.reserve (count);
}

bool MyFileSystemNodeItem::isDir (void) const {
    return m_info.isDir ();
}

qreal MyFileSystemNodeItem::getSize (void) const {
    return m_size;
}

QString MyFileSystemNodeItem::getPath (void) const {
    return m_info.filePath ();
}

QString MyFileSystemNodeItem::getName (void) const {
    return m_info.fileName ();
}

MyFileSystemWalker::MyFileSystemWalker (QObject * parent)
    : QObject    (parent)
    , m_time     (0)
    , m_nodes    (0)
    , m_total    (0)
    , m_rootItem (NULL)
{
    m_worker = QtConcurrent::run (this, &MyFileSystemWalker::initCacheWithPath, QDir::homePath ());
    m_timer = new QTimer (this);
    m_timer->setSingleShot (true);
    connect (m_timer, &QTimer::timeout, this, &MyFileSystemWalker::checkWorker);
    m_timer->start (0);
}

MyFileSystemWalker::~MyFileSystemWalker (void) {
    m_timer->stop ();
    m_worker.cancel ();
    m_tree.clear ();
    delete m_rootItem;
}

MyFileSystemNodeItem * MyFileSystemWalker::initCacheWithPath (const QString & path) {
    MyFileSystemNodeItem::reserveInstances (1000000);
    m_start = QDateTime::currentDateTime ();
    return new MyFileSystemNodeItem (path);
}

int MyFileSystemWalker::getItemIndexForAngle (qreal angle) {
    int ret = -1;
    int idx = 0;
    foreach (QVariant var, m_tree) {
        QVariantMap item = var.toMap ();
        if (item.value ("startAngle").toReal () < angle && item.value ("endAngle").toReal () > angle) {
            ret = idx;
            break;
        }
        idx++;
    }
    return ret;
}

bool MyFileSystemWalker::isWorking (void) const {
    return m_worker.isRunning ();
}

int MyFileSystemWalker::getCount (void) const {
    return m_count;
}

qreal MyFileSystemWalker::getTime (void) const {
    return m_time;
}

quint64 MyFileSystemWalker::getNodes (void) const {
    return m_nodes;
}

quint64 MyFileSystemWalker::getTotal (void) const {
    return m_total;
}

QString MyFileSystemWalker::getBase (void) const {
    return m_base;
}

QString MyFileSystemWalker::getTitle (void) const {
    return m_title;
}

QString MyFileSystemWalker::getPlace (void) const {
    return m_place;
}

QStringList MyFileSystemWalker::getList (void) const {
    return m_list;
}

QVariantList MyFileSystemWalker::getTree (void) const {
    return m_tree;
}

void MyFileSystemWalker::changeTreePath (QString path) {
    static qreal pi = 3.14159265358979323846;
#ifdef Q_OS_WIN
    if (path.startsWith ('/')) {
        path.remove (0, 1);
    }
#endif
    QFileInfo info (path);
    MyFileSystemNodeItem * item = MyFileSystemNodeItem::getInstanceByPath (info.filePath ());
    if (item) {
        m_list.clear ();
        m_tree.clear ();
        m_place = item->getPath ();
        m_title = item->getName ();
        m_total = item->getSize ();
        m_count = item->children ().count ();
        int idx = 0;
        qreal max   = 0.90;
        qreal rnd   = 0.00;
        qreal hue   = 0.00;
        qreal angle = 0.00;
        qreal ratio = 0.00;
        foreach (QObject * child, item->children ()) {
            MyFileSystemNodeItem * subitem = qobject_cast<MyFileSystemNodeItem *> (child);
            if (subitem) {
                QVariantMap data;
                data.insert ("path", subitem->getPath ());
                data.insert ("name", subitem->getName ());
                data.insert ("size", subitem->getSize ());
                data.insert ("isDir", subitem->isDir ());
                data.insert ("startAngle", angle);
                ratio = (qreal (subitem->getSize ()) / qreal (m_total));
                data.insert ("percent", ratio);
                angle += (2 * pi * ratio);
                data.insert ("endAngle", angle);
                rnd = qreal (qrand ()) / RAND_MAX;
                hue = ((idx % 2 ? max / 2 : 0.0) + rnd * (max / 2));
                data.insert ("color", QColor::fromHslF (hue, 0.45, 0.55, 1.0));
                m_tree.append (data);
                if (subitem->isDir ()) {
                    m_list.append (subitem->getName ());
                }
                idx++;
            }
        }
        emit listChanged  ();
        emit treeChanged  ();
        emit countChanged ();
        emit totalChanged ();
        emit titleChanged ();
        emit placeChanged ();
    }
}

void MyFileSystemWalker::checkWorker (void) {
    m_nodes = MyFileSystemNodeItem::getInstancesCount ();
    emit nodesChanged ();
    m_time = (qreal (m_start.msecsTo (QDateTime::currentDateTime ())) / 1000.0);
    emit timeChanged ();
    if (m_worker.isFinished ()) {
        m_rootItem = m_worker.result ();
        m_base = m_rootItem->getPath ();
        changeTreePath (m_rootItem->getPath ());
        emit workingChanged ();
        emit baseChanged ();
    }
    else {
        m_timer->start (100);
    }
}

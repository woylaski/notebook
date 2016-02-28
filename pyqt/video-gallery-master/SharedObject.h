#ifndef SHAREDOBJECT_H
#define SHAREDOBJECT_H

#include <QObject>
#include <QUrl>
#include <QProcess>
#include <QVariant>
#include <QList>
#include <QFuture>
#include <QFutureWatcher>
#include <QQuickItem>

class SharedObject : public QObject {
    Q_OBJECT
    Q_ENUMS (ThumbnailerState)
    Q_PROPERTY (QVariantList modelChapters READ getModelChapters NOTIFY modelChaptersChanged)

public:
    explicit SharedObject (QObject * parent = NULL);
    virtual ~SharedObject (void);

    QVariantList getModelChapters (void) const;

public slots:
    void updateChapters        (QUrl fileUrl = QUrl ());

    bool hasThumbnailForUrl    (QUrl fileUrl);
    QString getLocalFileForUrl (QUrl fileUrl);
    QUrl getUrlFromLocalPath   (QString path);

signals:
    void modelChaptersChanged (void);

protected slots:
    QVariantList extractMkvChapters (QUrl fileUrl);
    void onMkvChaptersExtractionFinished (void);

private:
    QString m_thumbnailsPath;
    QVariantList m_modelChapters;
    QFutureWatcher<QVariantList> m_futureWatcherChaptersList;
};

#endif // SHAREDOBJECT_H

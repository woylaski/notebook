
#include "SharedObject.h"

#include <QStringBuilder>
#include <QDebug>
#include <QDateTime>
#include <QTime>
#include <QDataStream>
#include <QFile>
#include <QtConcurrent>
#include <QCryptographicHash>

static quint64 getVariableLenghtInt (QDataStream & stream) {
    quint64 ret = 0;
    quint8 byte;
    int zeroes = 0;
    stream >> byte;
    for (int bit = 7; bit >= 0; bit--) {
        if (byte & (1 << bit)) {
            break;
        }
        else {
            zeroes++;
        }
    }
    ret |= ((byte & (0xFF >> (zeroes +1))) << (zeroes * 8));
    for (zeroes--; zeroes >= 0; zeroes--) {
        stream >> byte;
        ret |= (byte << (zeroes * 8));
    }
    return ret;
}

SharedObject::SharedObject (QObject * parent) : QObject (parent) {
    connect (&m_futureWatcherChaptersList, &QFutureWatcher<QVariantList>::finished,
             this, &SharedObject::onMkvChaptersExtractionFinished);

    m_thumbnailsPath = (QStandardPaths::writableLocation (QStandardPaths::CacheLocation) % "/VideoThumbnails");

    QDir dir;
    dir.mkpath (m_thumbnailsPath);
}

SharedObject::~SharedObject (void) { }

bool SharedObject::hasThumbnailForUrl (QUrl fileUrl) {
    return QFile::exists (getLocalFileForUrl (fileUrl));
}

QString SharedObject::getLocalFileForUrl (QUrl videoUrl) {
    QString url = videoUrl.toString ();
    QString md5 = QString::fromLocal8Bit (QCryptographicHash::hash (url.toLocal8Bit (), QCryptographicHash::Md5).toHex ());
    QString path = (m_thumbnailsPath % "/" % md5 % ".png");
    return path;
}

QUrl SharedObject::getUrlFromLocalPath (QString path) {
    return QUrl::fromLocalFile (path);
}

void SharedObject::onMkvChaptersExtractionFinished (void) {
    m_modelChapters = m_futureWatcherChaptersList.result ();
    emit modelChaptersChanged ();
}

QVariantList SharedObject::getModelChapters (void) const {
    return m_modelChapters;
}

void SharedObject::updateChapters (QUrl fileUrl) {
    if (!fileUrl.isEmpty ()) {
        m_futureWatcherChaptersList.setFuture (QtConcurrent::run (this, &SharedObject::extractMkvChapters, fileUrl));
    }
    else {
        m_modelChapters.clear ();
        emit modelChaptersChanged ();
    }
}


QVariantList SharedObject::extractMkvChapters (QUrl fileUrl) {
    QVariantList ret;
    QFile file (fileUrl.toLocalFile ());
    if (file.open (QFile::ReadOnly)) {
        QDataStream stream (&file);
        stream.setByteOrder (QDataStream::BigEndian);
        quint64 headerId = getVariableLenghtInt (stream);
        //qWarning () << "headerId" << QString::number (headerId, 16);;
        if (headerId == 0xA45DFA3) {
            //qWarning () << "EBML file header start";
            quint64 headerSize = getVariableLenghtInt (stream);
            //qWarning () << "headerSize" << headerSize << "bytes";
            qint64 headerEnd = (stream.device ()->pos () + headerSize);
            while (!stream.atEnd () && stream.device ()->pos () < headerEnd) {
                quint64 elementId = getVariableLenghtInt (stream);
                quint64 elementSize = getVariableLenghtInt (stream);
                switch (elementId) {
                    case 0x286: { // writer version
                        Q_ASSERT (elementSize == 1);
                        quint8 writerVersion;
                        stream >> writerVersion;
                        //qDebug () << "writerVersion" << writerVersion;
                        break;
                    }
                    case 0x2f7: { // min reader version
                        Q_ASSERT (elementSize == 1);
                        quint8 minReaderVersion;
                        stream >> minReaderVersion;
                        //qDebug () << "minReaderVersion" << minReaderVersion;
                        break;
                    }
                    case 0x2f2: { // max id length
                        Q_ASSERT (elementSize == 1);
                        quint8 maxIdLength;
                        stream >> maxIdLength;
                        //qDebug () << "maxIdLength" << maxIdLength;
                        break;
                    }
                    case 0x2f3: { // max size length
                        Q_ASSERT (elementSize == 1);
                        quint8 maxSizeLength;
                        stream >> maxSizeLength;
                        //qDebug () << "maxSizeLength" << maxSizeLength;
                        break;
                    }
                    case 0x282: { // doc type
                        QByteArray doctype (elementSize, 0x00);
                        stream.readRawData (doctype.data (), doctype.size ());
                        //qWarning () << "doctype" << doctype;
                        break;
                    }
                    case 0x287: { // doctype write version
                        Q_ASSERT (elementSize == 1);
                        quint8 docTypeWriterVersion;
                        stream >> docTypeWriterVersion;
                        //qDebug () << "docTypeWriterVersion" << docTypeWriterVersion;
                        break;
                    }
                    case 0x285: { // doctype min read version
                        Q_ASSERT (elementSize == 1);
                        quint8 docTypeMinReaderVersion;
                        stream >> docTypeMinReaderVersion;
                        //qDebug () << "docTypeMinReaderVersion" << docTypeMinReaderVersion;
                        break;
                    }
                    default:{
                        //qDebug () << "Unknown element ID !" << QString::number (elementId, 16);
                        //qDebug () << "Skipping" << elementSize << "bytes";
                        stream.skipRawData (elementSize);
                        break;
                    }
                }
            }
            //qDebug () << "End of header.";
            quint32 segmentId = getVariableLenghtInt (stream);
            //qDebug () << "Next element ID" << QString::number (segmentId, 16);
            if (segmentId == 0x8538067) {
                //qDebug () << "Segment start !";
                quint64 segmentSize = getVariableLenghtInt (stream);
                //qDebug () << "segmentSize" << segmentSize << "bytes";
                qint64 segmentEnd = (stream.device ()->pos () + segmentSize);
                QVariantMap entry;
                while (!stream.atEnd () && stream.device ()->pos () < segmentEnd) {
                    //qint64 blockPos = stream.device ()->pos ();
                    quint64 blockId = getVariableLenghtInt (stream);
                    //qDebug () << "block ID" << QString::number (blockId, 16);
                    quint64 blockSize = getVariableLenghtInt (stream);
                    switch (blockId) {
                        case 0x43A770: { // chapters section
                            //qDebug () << "Chapters section start";
                            break;
                        }
                        case 0x5B9: { // edition entry
                            //qDebug () << "Edition entry with size" << blockSize;
                            break;
                        }
                        case 0x5BC: { // edition UID
                            QByteArray tmp (blockSize, 0);
                            stream.readRawData (tmp.data (), tmp.size ());
                            //qDebug () << "Edition UID" << tmp.toHex ();
                            break;
                        }
                        case 0x36: { // chapter atom
                            //qDebug () << "Chapter Atom";
                            entry.clear ();
                            break;
                        }
                        case 0x11: { // chapter time start
                            QByteArray tmp (blockSize, 0);
                            stream.readRawData (tmp.data (), tmp.size ());
                            int msec = (tmp.toHex ().toULongLong (NULL, 16) / 1000000);
                            //qDebug () << "Chapter time start" << msec << "msecs";
                            entry.insert ("marker", msec);
                            break;
                        }
                        case 0x0: { // chapter title
                            //qDebug () << "Chapter title";
                            break;
                        }
                        case 0x5: { // chapter string
                            QByteArray title (blockSize, 0);
                            stream.readRawData (title.data (), title.size ());
                            //qDebug () << "Chapter string" << title << title.toHex ();
                            entry.insert ("title", QString::fromLatin1 (title));
                            break;
                        }
                        case 0x14D9B74: // seek section
                        case 0xF43B675: // cluster section
                        case 0x654AE6B: // tracks section
                        case 0xC53BB6B: // cues section
                        case 0x941A469: // attachments section
                        case 0x6C:      // void data
                        default: {
                            //qDebug () << "Unhanlded block type at pos" << blockPos << ", skipping" << blockSize << "bytes";
                            stream.skipRawData (blockSize);
                            break;
                        }
                    }
                    if (entry.contains ("title") && entry.contains ("marker")) {
                        ret.append (entry);
                        entry.clear ();
                    }
                }
            }
        }
        file.close ();
    }
    return ret;
}

#include "fileio.h"
#include <QFile>
#include <QTextStream>

//FileIO::FileIO(QQuickItem *parent): QQuickItem(parent)
FileIO::FileIO(QQuickItem *parent): QObject(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

FileIO::~FileIO()
{
}

QByteArray FileIO::read(const QString &filename)
{
    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly))
        return QByteArray();

    return file.readAll();
}

bool FileIO::write(const QString& data)
{
    if (m_source.isEmpty())
        return false;

    QFile file(m_source);
    //QFile file(m_source.toLocalFile());
    //QFile file(m_source.toString());
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();
    return true;
}


void FileIO::read()
{
    if(m_source.isEmpty()) {
        return;
    }

    QFile file(m_source);
    //QFile file(m_source.toLocalFile());
    if(!file.exists()) {
        qWarning() << "Does not exits: " << m_source;
        //qWarning() << "Does not exits: " << m_source.toLocalFile();
        return;
    }
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        m_text = stream.readAll();
        emit textChanged(m_text);
    }
}

void FileIO::write()
{
    if(m_source.isEmpty()) {
        return;
    }

    QFile file(m_source);
    //QFile file(m_source.toLocalFile());
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << m_text;
    }
}

QString FileIO::source() const
{
    return m_source;
}

QString FileIO::text() const
{
    return m_text;
}

void FileIO::setSource(QString source)
{
    if (m_source == source)
        return;

    m_source = source;
    //m_source = QUrl(source);
    //m_source = QUrl(QStringLiteral(source));
    emit sourceChanged(source);
}

void FileIO::setText(QString text)
{
    if (m_text == text)
        return;

    m_text = text;
    emit textChanged(text);
}

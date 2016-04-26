#include "manu_filesystem.h"

//ManuFileIO::ManuFileIO(QQuickItem *parent): QQuickItem(parent)
ManuFileIO::ManuFileIO(QObject *parent) :
    QObject(parent)
{
}

ManuFileIO::~ManuFileIO()
{
}

QString ManuFileIO::source()
{
    return m_source;
}

QString ManuFileIO::content()
{
    return m_source;
   //return QString(m_content);
}

void ManuFileIO::setSource(QString source)
{
    if (m_source == source)
        return;

    m_source = source;
    //m_source = QUrl(source);
    //m_source = QUrl(QStringLiteral(source));
    emit sourceChanged(source);
}

void ManuFileIO::setContent(QString data)
{
    //if (m_content  == data.toUtf8())
    if (m_content  == data)
        return;

    m_content = data;
    //m_content = data.toUtf8();
    emit contentChanged(data);
}

void urlToString()
{
    QUrl url;
    url.toLocalFile();
    url.toString().replace("file:///","");
    url.path();

    //You will need to use the following method for the conversion before passing the path to QFile:
    //QUrl QUrl::fromLocalFile(const QString & localFile)
    //Returns a QUrl representation of localFile, interpreted as a local file
}

void readFileLine(QString file)
{
    QTextStream stream(&file);
    QString line_in;
//    while( !stream.atEnd()){
//        line_in = stream.readLine();
//        qDebug() << line_in;
//    }
//    stream.seek(stream.pos());
    stream.seek(file.size());//将当前读取文件指针移动到文件末尾
    int count = 0;
    while(count < 10){
        stream << QObject::trUtf8("新建行:") <<++count<<"/n";
    }
    stream.seek(0);//将当前读取文件指针移动到文件开始
    while( !stream.atEnd()){
        line_in = stream.readLine();
        qDebug() << line_in;
    }
}

QByteArray ManuFileIO::readBytes(QString &filename)
{
    QFile file(filename);

    if(!file.exists()) {
        qWarning() << "Does not exits: " << filename;
        //qWarning() << "Does not exits: " << m_source.toLocalFile();
        return QByteArray();
    }

    if (!file.open(QIODevice::ReadOnly))
        return QByteArray();

    return file.readAll();
}

//QString ManuFileIO::readString(QString &filename)
QString ManuFileIO::readString(QString filename)
{
    qDebug()<<"readString file "<<filename<<__FILE__<<__LINE__;
    QFile file(filename.replace("file://",""));

    if(!file.exists()) {
        qWarning() << "Does not exits: " << filename;
        //qWarning() << "Does not exits: " << m_source.toLocalFile();
        return QString();
    }

    if (!file.open(QIODevice::ReadOnly))
        return QString();

    QTextStream stream(&file);
    return stream.readAll();
}

#if 0
QString ManuFileIO::readString(void)
{
    qDebug()<<"readString file "<<m_source<<__FILE__<<__LINE__;
    if (m_source.isEmpty())
        return QString();

    QFile file(m_source);
    if(!file.exists()) {
        qWarning() << "Does not exits: " << m_source;
        //qWarning() << "Does not exits: " << m_source.toLocalFile();
        return QString();
    }

    if (!file.open(QIODevice::ReadOnly))
        return QString();

    QTextStream stream(&file);
    return stream.readAll();
}

bool ManuFileIO::writeString(void)
{
    if(m_source.isEmpty()) {
        return false;
    }

    QFile file(m_source);
    if(!file.exists()) {
        return false;
    }

    if(!file.open(QIODevice::WriteOnly)) {
        return false;
    }

    QTextStream stream(&file);
    stream << m_content;
    return true;
}
#endif

bool ManuFileIO::writeString(QString &data)
{
    if(m_source.isEmpty()) {
        return false;
    }

    QFile file(m_source);
    if(!file.exists()) {
        return false;
    }

    //QIODevice::ReadWrite
    if(!file.open(QIODevice::WriteOnly)) {
        return false;
    }

    QTextStream stream(&file);
    stream << data;
    return true;
}

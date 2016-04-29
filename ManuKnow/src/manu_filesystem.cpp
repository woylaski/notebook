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

void get_fileinfo(QUrl *file)
{
    if (file->isLocalFile()) {
        QFileInfo fi(file->toLocalFile());
    }
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

void readFileLine(QString fname)
{
    QTextStream stream(&fname);
    QFile file(fname);
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

QByteArray ManuFileIO::readBytes(QString filename)
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
    QTextCodec *code=QTextCodec::codecForName("utf8");
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
    stream.setCodec(code);
    //stream.setCodec("UTF-8");
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

bool ManuFileIO::writeString(QString data)
{
    if(m_source.isEmpty()) {
        return false;
    }

    QFile file(m_source);
    if(!file.exists()) {
        return false;
    }

    //QIODevice::ReadWrite
    if(!file.open(QIODevice::WriteOnly| QIODevice::Text)) {
        return false;
    }

    QTextStream stream(&file);
    stream << data;
    file.close();
    return true;
}

bool ManuFileIO::saveFile(QString filename, QString data)
{
    QString fname = filename.replace("file://","");
    QFile file(fname);
    if(!file.exists()) {
        return false;
    }

    //QIODevice::ReadWrite
    if(!file.open(QIODevice::WriteOnly| QIODevice::Text)) {
        return false;
    }

    file.write(data.toUtf8());
    file.close();
    return true;
}

bool ManuFileIO::createFile(QString filename)
{
    QString fname = filename.replace("file://","");
    QFile file(fname);
    if(file.exists()) {
        return true;
    }

    if(!file.open(QIODevice::WriteOnly)){
        printf("create file %s error\r\n", fname.toStdString().data());
    }

    file.close();
    return true;
}

bool ManuFileIO::deleteFile(QString filename)
{
    QString fname = filename.replace("file://","");
    QFile file(fname);
    if(!file.exists()) {
        return true;
    }

    file.remove();
    return true;
}

bool ManuFileIO::listDirInfo(QString dirname)
{
    QString dname = dirname.replace("file://","");
    QDir d(dname);
    d.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks | QDir::AllDirs);//列出文件,列出隐藏文件（在Unix下就是以.开始的为文件）,不列出符号链接（不支持符号连接的操作系统会忽略）
    d.setSorting(QDir::Size | QDir::Reversed);//按文件大小排序，相反的排序顺序
    const QFileInfoList list = d.entryInfoList();//返回这个目录中所有目录和文件的QFileInfo对象的列表
    QFileInfoList::const_iterator iterator = list.begin();
    qDebug() << "目录和文件的数量: " << d.count();//返回找到的目录和文件的数量
    qDebug() << "fileName/t/t/tsize/t/t/t";
    while(iterator != list.end()){
        qDebug() << (*iterator).fileName()<<"/t/t/t"<<(*iterator).size();
        iterator++;
    }
    qDebug() << "当前目录: " << d.current();//返回应用程序当前目录。
    qDebug() << "当前目录的绝对路径" << d.currentPath();//返回应用程序当前目录的绝对路径。
//    const QList<QString> list = d.entryList(); //返回这个目录中所有目录和文件的名称的列表
//    QList<QString>::const_iterator iterator = list.begin();
//    while(iterator != list.end()){
//        qDebug() << (*iterator);
//        iterator++;
//    }
    return true;
}

bool ManuFileIO::listFileInfo(QString filename)
{
    QString fname = filename.replace("file://","");
    QFileInfo info1(fname);
    qDebug() << info1.isSymLink();
    qDebug() << info1.absoluteFilePath();
    qDebug() << info1.size();
    qDebug() << info1.symLinkTarget();
    qDebug() << "**********************";
    QFileInfo info2(info1.symLinkTarget());
    qDebug() << info2.isSymLink();
    qDebug() << info2.absoluteFilePath();
    qDebug() << info2.size();
    return true;
}

void binaryRead()
{
    QFile file("file.dat");
    file.open(QIODevice::ReadOnly);
    QDataStream in(&file);
    QString str;
    qint32 a;
    in >> str >> a;
}

void binaryWrite()
{
    QFile file("file.dat");
    file.open(QIODevice::WriteOnly);
    QDataStream out(&file);
    out << QString("the answer is");
    out << (qint32)42;
    file.close();// 如果不想关闭文件，可以使用 file.flush();
}

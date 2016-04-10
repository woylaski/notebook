#ifndef FILEIO_H
#define FILEIO_H

#include <QQuickItem>
#include <QObject>

class FileIO: public QObject
//class FileIO : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(FileIO)

    //QUrl source：属性source,类型QURL
    //READ source：读取属性的方法source()
    //WRITE setSource: 设置属性的方法 setSource
    //NOTIFY sourceChanged：属性变化的信号 sourceChanged
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

    //QString text: 属性text,类型QString
    //READ text: 读取属性的方法text()
    //WRITE setText: 设置属性的方法setText()
    //NOTIFY textChanged: 属性变化的信号 textChanged
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    FileIO(QQuickItem *parent = 0);
    ~FileIO();
    //Q_INVOKABLE对外提供的方法，也可以发射信号, 可以被QML调用
    Q_INVOKABLE void read();
    Q_INVOKABLE void write();
    Q_INVOKABLE QByteArray read(const QString &filename);
    Q_INVOKABLE bool write(const QString& data);

    //属性读取的方法
    QString source() const;
    QString text() const;

public slots:
    //槽函数，用于设置属性，同时发射信号，同样可以被QML调用
    //当信号发出后，连接的槽就会被调用。槽是普通的c++函数，可以正常的调用；槽唯一的特性就是信号可以和它连接
    void setSource(QString source);
    //void setSource(QUrl source);
    void setText(QString text);

signals:
    //信号，属性变化时发射的信号
    void sourceChanged(QString arg);
    void textChanged(QString arg);

private:
    //属性在类里面的体现
    QString m_source;
    QString m_text;
};

#endif // FILEIO_H


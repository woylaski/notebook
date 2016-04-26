#ifndef FILE_SYSTEM_H
#define FILE_SYSTEM_H

#include "manu_common.h"

class ManuFileIO: public QObject
{
    Q_OBJECT
    //Q_DISABLE_COPY(ManuFileIO)
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)

public:
    explicit ManuFileIO(QObject *parent = 0);
    //ManuFileIO(QQuickItem *parent = 0);
    ~ManuFileIO();

    //Q_INVOKABLE对外提供的方法，也可以发射信号, 可以被QML调用
    //Q_INVOKABLE  QString readString(void);
    Q_INVOKABLE  QByteArray readBytes(QString &filename);
    Q_INVOKABLE  QString readString(QString filename);
    //Q_INVOKABLE  QString readString(QString &filename);
    //Q_INVOKABLE  bool writeString(void);
    Q_INVOKABLE  bool writeString(QString& data);

    //属性读取的方法
    QString source();
    QString content();

public slots:
    //槽函数，用于设置属性，同时发射信号，同样可以被QML调用
    //当信号发出后，连接的槽就会被调用。槽是普通的c++函数，可以正常的调用；槽唯一的特性就是信号可以和它连接
    void setSource(QString source);
    //void setSource(QUrl source);
    void setContent(QString data);

signals:
    //信号，属性变化时发射的信号
    void sourceChanged(QString fname);
    void contentChanged(QString data);

private:
    //属性在类里面的体现
    QString m_source;
    QString m_content;
};

#endif // FILE_SYSTEM_H

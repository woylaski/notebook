#ifndef PROCESS_H
#define PROCESS_H

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QString>
#include <QDebug>

//Qt之信号与槽
//http://blog.sina.com.cn/s/blog_a6fb6cc90101epbg.html

/*
信号与槽的连接方式看起来会是这样的：
Qt5之前：
    connect(sender, SIGNAL(signal), receiver, SLOT(slot));
Qt5开始：
    connect(sender, &Sender::signal, receiver, &Receiver::slot);
前者：
    sender和receiver是指向QObject的指针，signal和slot是不带参数的函数名。SIGNAL()宏和SLOT()宏会把他们的参数转换成相应的字符串。
后者：
    （1）编译器，检查信号与槽是否存在，参数类型检查，Q_OBJECT宏是否存在
    （2）信号可以和普通函数、类的普通成员函数、lambda函数连接（不在局限于信号和槽函数）
    （3）参数可以是typedef的或者使用不同的namespace specifier
    （4）可以允许一些自动类型的转换（即信号和槽函数类型不必完全匹配
*/

//直接继承QObject通常是不行的，需要编写一个类继承QObject， 然后再编写实体类继承这个抽象类
//http://blog.csdn.net/muyuyuzhong/article/details/8736069
class Shell: public QObject
{
    Q_OBJECT

public:
    explicit Shell(QObject *parent = 0);
    ~Shell();
    bool run(QString script, QStringList list);
    void readOutput_noslot();

private slots:
    //qt5之前只有槽函数才能连接信号
    void readOutput();//从进程中读取数据槽

private:
    QProcess *pro;//创建一个进程对象
    QString out;
};

#endif // PROCESS_H


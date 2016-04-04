#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QString>
#include <QDebug>
#include "process.h"

Shell::Shell(QObject *parent)
{
    this->pro = new QProcess;
    ////当准备从进程里读取数据的时候触发输出数据的槽
    //QObject::connect(pro,SIGNAL(readyRead()),this,SLOT(readOutput()));
    QObject::connect(pro, &QProcess::readyRead, this, &Shell::readOutput_noslot);
}

Shell::~Shell()
{

}

bool Shell::run(QString script, QStringList list)
{
    pro->start(script, list);
    if(!pro->waitForStarted())
    {
        qDebug()<<"start error";
        return false;
    }

    //pro->waitForFinished();
    return true;
}

void Shell::readOutput_noslot()
{
    int i = 0;
    QStringList result;
    qDebug()<<"not slot readOutput";

    out = pro->readAll();
    //out += pro->readAll();

    result=out.split('\n');
    qDebug()<<out<<endl;

    for(i=0;i<result.count();i++)
    {
        qDebug()<<result[i];
    }
}

void Shell::readOutput()
{
    int i = 0;
    QStringList result;
    qDebug()<<"slot readOutput";

    out = pro->readAll();
    //out += pro->readAll();

    result=out.split('\n');
    qDebug()<<out<<endl;

    for(i=0;i<result.count();i++)
    {
        qDebug()<<result[i];
    }
}

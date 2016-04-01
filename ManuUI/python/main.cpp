#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include <QString>
#include <QDebug>
#include "process.h"
/*
void process_1(void)
{
    QObject *parent;
    QString program = "./path/to/Qt/examples/widgets/analogclock";
    QStringList arguments;
    arguments << "-style" << "fusion";

    QProcess *myProcess = new QProcess(parent);
    myProcess->start(program, arguments);
}

void process_2(void)
{
    QProcess gzip;
    gzip.start("gzip", QStringList() << "-c");
    if (!gzip.waitForStarted())
        return false;

    gzip.write("Qt rocks!");
    gzip.closeWriteChannel();

    if (!gzip.waitForFinished())
        return false;

    QByteArray result = gzip.readAll();
}

//command1 | command2
void process_3(void)
{
    QProcess process1;
    QProcess process2;

    process1.setStandardOutputProcess(&process2);

    process1.start("command1");
    process2.start("command2");
}

void process_4(void)
{
    QProcess process;
    process.start("dir \"My Documents\"");
    process.start("dir \"Epic 12\"\"\" Singles\"");
}

void process_5(void)
{
    QProcess p;
    QStringList params;

    params << "script.py -arg1 arg1"
    p.start("python", params);
    p.waitForFinished(-1);

    QString p_stdout = p.readAll();

    //ui->lineEdit->setText(p_stdout);
}
*/
//python嵌入到C++的一些理解
//http://www.cnblogs.com/bluebbc/p/4291251.html
// qt 使用 pythonqt报错python34_d.lib
//http://blog.csdn.net/jk007/article/details/44839079
//http://www.cmi.ac.in/~madhavan/courses/prog2-2015/docs/python-3.4.2-docs-html/extending/embedding.html
//https://doc.qt.io/archives/qq/qq23-pythonqt.html
//https://github.com/Orochimarufan/PythonQt
//C++与Python的混合编程-C++调用Python
//http://www.udpwork.com/item/10422.html

/*
QProcess *pProces = new QProcess(this);
connect(pProces, SIGNAL(readyRead()),this, SLOT(on_read()));
QStringList list;
pProces->start("Shutdown.exe", list);

void on_read()
{
  QProcess *pProces = (QProcess *)sender();
  QString result = pProces->readAll();
  QMessageBox::warning(NULL, "", result);
}
*/

bool process_ls(void)
{
    int i=0;
    QProcess process;
    QString result;
    QStringList results;

/*
    process.start("ls E:\\");
    if (!process.waitForStarted())
    {
        qDebug()<<"ls start error";
        return false;
    }

    if (!process.waitForFinished())
    {
        qDebug()<<"ls finish error";
        return false;
    }
    result = process.readAll();
    results=result.split('\n');
    for(i=0;i<results.count();i++){
        qDebug()<<results[i];
        //qDebug()<<results.at(i);
    }
*/
    QProcess p(0);
    p.start("ipconfig");
    p.waitForStarted();
    p.waitForFinished();
    qDebug()<<QString::fromLocal8Bit(p.readAllStandardOutput());

    qDebug()<<"---------------"<<endl;

    //QProcess p(0);
    p.start("cmd");
    p.waitForStarted();
    p.write("dir\n");
    p.closeWriteChannel();
    p.waitForFinished();
    qDebug()<<QString::fromLocal8Bit(p.readAllStandardOutput());

    qDebug()<<"---------------"<<endl;

    //QProcess p(0);
    p.start("cmd", QStringList()<<"/c"<<"dir");
    p.waitForStarted();
    p.waitForFinished();
    qDebug()<<QString::fromLocal8Bit(p.readAllStandardOutput());
    return true;
}

//-----------------------------------------------------


/*
void    start(const QString & program, const QStringList & arguments, OpenMode mode = ReadWrite)//较常用，直接启动运行某个进程并传入参数
void    start(OpenMode mode = ReadWrite)
void    start(const QString & command, OpenMode mode = ReadWrite)

QByteArray  readAllStandardError()//从输出中得到被操作程序的输出内容。输出时有标准错误输出和标准输出两个管道
QByteArray  readAllStandardOutput()

void    setStandardErrorFile(const QString & fileName, OpenMode mode = Truncate)//与readAllStandardXXX函数相似，只是将程序的输出保存到文件中。设置以下几个后，就read不到相应管道中的内容了。
void    setStandardInputFile(const QString & fileName)
void    setStandardOutputFile(const QString & fileName, OpenMode mode = Truncate)
void    setStandardOutputProcess(QProcess * destination)
void    setWorkingDirectory(const QString & dir)

void    setProgram(const QString & program)//设置需要打开的进程
void    setArguments(const QStringList & arguments)//设置参数部分
void    setInputChannelMode(InputChannelMode mode)
void    setReadChannel(ProcessChannel channel)//设置输出通道。下边解释1
void    setNativeArguments(const QString & arguments)
void    setProcessChannelMode(ProcessChannelMode mode)
void    setProcessEnvironment(const QProcessEnvironment & environment)

QProcess::ProcessState  state() const
bool    waitForFinished(int msecs = 30000)
bool    waitForStarted(int msecs = 30000)
QString workingDirectory() const

QStringList arguments() const
void    closeReadChannel(ProcessChannel channel)
void    closeWriteChannel()
QProcess::ProcessError  error() const
int exitCode() const
QProcess::ExitStatus    exitStatus() const
InputChannelMode    inputChannelMode() const
QString nativeArguments() const
Q_PID   pid() const
ProcessChannelMode  processChannelMode() const
QProcessEnvironment processEnvironment() const
QString program() const
ProcessChannel  readChannel() const
*/

/*
,enum QProcess::ProcessChannel
Constant	 Value	 Description
QProcess::StandardOutput默认	0	 standard output (stdout) 标准输出
QProcess::StandardError	1	 standard error (stderr) 标准错误输出
对于一些继承来的操作函数，如：read(), readAll(), readLine(), 和 getChar()，它们读取时，只能从两个通道中的一个读取得到被操纵程序的标准输出。
*/

/*
可以通过连接信号得到progress的状态：

Signals

void	error(QProcess::ProcessError error)
void	finished(int exitCode, QProcess::ExitStatus exitStatus)
void	readyReadStandardError()
void	readyReadStandardOutput()
void	started()
void	stateChanged(QProcess::ProcessState newState)
*/

/*
QString program = "/usr/bin/mentohust";
QStringList arguments;
arguments << "-h";

QProcess *myProcess = new QProcess(parent);
myProcess->start(program, arguments);
*/
//可以用write函数向其写入内容，
//通过readyReadStandardOutput()等信号连到槽函数，
//然后用readAllStandardOutput()等读函数读取输出进行处理。

/*
用QProcess调用外部程序时，可直接指定命令行参数
QProcess process;
process.start("./process", QStringList()<<"a"<<"b");
process.start("./process a b");
后一种写法看起来写起来比较简洁，但是程序路径或参数中包括空格时，就不如第一种方便了。
注：在Windows平台的某些情况（比如QTBUG7620）下，你可能需要使用
QProcess::setNativeArguments()
*/

/*
在QProcess下，我们使用
QProcess::readAllStandardOutput ()
获取标准输出
QProcess::setStandardOutputFile()
设置输出到的文件，相当于前面的重定向
 QProcess process;
process.start("./process", QStringList()<<"a"<<"b");
process.readAllStandardOutput();
可以使用：
QProcess::setStandardOutputProcess()
将标准输出作为另个进程的标准输入。形成 ls -l | more 这样的管道操作
由于QProcess是QIODevice的派生类，故：
read()
readLine()
...
都可以直接用获取被调用程序的标准输出。
*/

/*
用QProcess读取标准出错，和前面标准输出是类似的：
QProcess::readAllStandardError()
QProcess::setStandardErrorFile()
QProcess process;
process.start("./process", QStringList()<<"a"<<"b");
process.readAllStandardOutput();
但是，QProcess作为QIODevice的派生类，read()/readAll()只能读标准输出，不读标准出错，有点说不过去哈。
恩QProcess在这方面足够灵活，你可以通过
QProcess::setReadChannel()
*/

/*
在QProcess中，直接使用QIODevice的write()函数
QProcess process;
process.start("./process")
process.write("intput");
也可以设置文件作为输入
QProcess::setStandardInputFile()
*/

/*
获得返回值。
在QProcess下，则通过：
int QProcess::execute()
int QProcess::exitCode()
*/

/*
在Qt下，使用 QProcess::setProcessEnvironment() 设置进程的环境变量
QProcess process;
QProcessEnvironment env;
env.insert("MYPATH", "/home/dbzhang800");
process.setProcessEnvironment(env);
process.start("./process");
*/

bool process_python(const char *script)
{
    QProcess p;
    p.start("python");
    if(!p.waitForStarted()){
        qDebug()<<"start error";
        return false;
    }

    //p.write(script.toStdString());
    p.write(script);
    p.closeWriteChannel();

    if(!p.waitForFinished()){
        qDebug()<<"finish error";
        return false;
    }
    qDebug()<<QString::fromLocal8Bit(p.readAllStandardOutput());
    return true;
}

bool process_python2(QString script)
{
    QProcess p;
    p.start(script);
    p.waitForStarted();
    //p.write("dir\n");
    p.closeWriteChannel();
    p.waitForFinished();
    qDebug()<<QString::fromLocal8Bit(p.readAllStandardOutput());
    return true;
}

void process_python3()
{
    QProcess process;
    QString scriptFile =  QCoreApplication::applicationDirPath() + "../../scriptPath/script.py";

    QString pythonCommand = "python " + scriptFile + " -f " +
                        "parameter1" + \
                        " -t parameter2" + \
                        " -v parameter3" + \
                        " -e " + "parameter4";

    printf("PyCommand: %s\n", pythonCommand.toStdString().c_str());

    process.start (pythonCommand);
}

//http://stackoverflow.com/questions/32831775/start-process-with-qprocess-on-windows-error-timers-can-only-be-used-with-thre
//http://stackoverflow.com/questions/4180394/how-do-i-create-a-simple-qt-console-application-in-c
int main(int argc, char *argv[])
{
    Shell ashell;
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    //process_ls();
    //process_real_output();
    //ashell.run("ls", QStringList()<<"\c"<<"E:\\");
    //ashell.run("python", QStringList()<<"E:\\all-qml\\test.py");
    ashell.run("python", QStringList()<<"-i"<<"E:\\all-qml\\test2.py");
    //process_python("print('hello!'\n)");
    return app.exec();
}

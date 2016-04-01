#include <QApplication>
#include <QProcess>
#include <QString>
#include <iostream>

/*
在 Qt 中，我们使用 QProcess 来表示一个进程。QProcess类可以允许我们的应用程序开启一个新的外部程序，并且与这个程序进行通讯。
启动一个新进程的方式：把待启动的程序名称和启动参数传递给start（）函数即可。
例如：
点击(此处)折叠或打开
QProcess *parent；
QString program = “tar”；
QStringList arguments；
arguments << "czvf" << "backup.tar.gz" << "/home";
QProcess *myProcess = new QProcess(parent);
QProcess->start(program,arguments);
当调用start（）函数后，QProcess 进入Starting 状态；当程序开始执行之后，QProcess 进入 Running 状态，并且发出 started() 信号。
QProcess 允许你将一个进程当做一个顺序访问的 I/O 设备。我们可以使用write() 函数将数据提供给进程的标准输入；使用 read()、readLine()或者 getChar() 函数获取其标准输出。
当进程退出时，QProcess 进入 NotRunning状态（也是初始状态），并且发出 finished() 信号。finished() 信号以参数的形式提供进程的退出代码和退出状态。其中“退出状态”只有正常退出和进程崩溃两种，分别对应值QProcess::NormalExit(值0)和Qprocess::CrashExit（值1）。如果发送错误，QProcess 会发出 error() 信号
Qt定义了如下的错误类型代码：
错误常量                        值      描述
QProcess::FailedToStart        0       进程启动失败
QProcess::Crashed              1       进程成功启动后崩溃
QProcess::Timedout             2       最后一次调用waitFor...()函数超时.此时QProcess状态不变,并可以再次调用waitFor()类型的函数
QProcess::WriteError           3       向进程写入时出错.如进程尚未启动,或者输入通道被关闭时
QProcess::ReadError            4       从进程中读取数据时出错.如进程尚未启动时
QProcess::UnknownError         5       未知错误.这也是error()函数返回的默认值

进程通常有两个预定义的通道：标准输出通道（stdout）和标准错误通道（stderr）。前者就是常规控制台的输出，后者则是由进程输出的错误信息。这两个通道都是独立的数据流，我们可以通过使用 setReadChannel() 函数来切换这两个通道。当进程的当前通道可用时，QProcess 会发出readReady() 信号。当有了新的标准输出数据时，QProcess 会发出readyReadStandardOutput() 信号；当有了新的标准错误数据时，则会发出 readyReadStandardError() 信号。

QProcess 提供了同步函数：
o waitForStarted()：阻塞到进程开始；
o waitForReadyRead()：阻塞到可以从进程的当前读通道读取新的数据；
o waitForBytesWritten()：阻塞到数据写入进程；
o waitForFinished()：阻塞到进程结束；
另外，QProcess 还允许我们使用 setEnvironment() 为进程设置环境变量，或者使用 setWorkingDirectory() 为进程设置工作目录。
*/

int process_test(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QProcess proc;
    QStringList arguments;
    arguments << "-na";
    proc.start("netstat", arguments);

    // 等待进程启动
    if (!proc.waitForStarted())
    {
        std::cout << "启动失败\n";
        return false;
    }
    // 关闭写通道,因为没有向进程写数据,没用到
    proc.closeWriteChannel();

    // 用于保存进程的控制台输出
    QByteArray procOutput;
    // 等待进程结束
    while (false == proc.waitForFinished())
    {
       std::cout << "结束失败\n";
       return 1;
    }
    // 读取进程输出到控制台的数据
   procOutput = proc.readAll();
   // 输出读到的数据
   std::cout << procOutput.data() << std::endl;
   // 返回
   return EXIT_SUCCESS;
}

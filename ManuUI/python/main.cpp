#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>

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

//python嵌入到C++的一些理解
//http://www.cnblogs.com/bluebbc/p/4291251.html
// qt 使用 pythonqt报错python34_d.lib
//http://blog.csdn.net/jk007/article/details/44839079
//http://www.cmi.ac.in/~madhavan/courses/prog2-2015/docs/python-3.4.2-docs-html/extending/embedding.html
//https://doc.qt.io/archives/qq/qq23-pythonqt.html
//https://github.com/Orochimarufan/PythonQt



int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

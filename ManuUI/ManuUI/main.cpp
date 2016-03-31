#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "beziercurve.h"
#include "painteditem.h"
#include "textballoon.h"
#include "eventfilter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //设置应用图标
    //app.setWindowIcon(QIcon(":/res/eye.png"));
    //给QGuiApplication安装事件过滤器，过滤BACK按键,
    //KeyBackQuit类重写eventFilter()方法来过滤Key_Back按键
    app.installEventFilter(new KeyBackQuit);

    qmlRegisterType<BezierCurve>("CustomGeometry", 1, 0, "BezierCurve");
    qmlRegisterType<PaintedItem>("CustomPaint", 1, 0, "APaintedItem");
    qmlRegisterType<TextBalloon>("CustomBalloon", 1, 0, "TextBalloon");

    QQmlApplicationEngine engine;

    //fromLocalFile 只能接受一个本地硬盘的文件
    //offlineStoragePath : QString, is QQmlApplicationEngine property
    //QUrl	fromLocalFile(const QString &localFile)
    //QString	toLocalFile() const
    QUrl offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    qDebug()<<"offlineStoragePath:"<<offlineStoragePath;

    QString new_dir="E:/github/notbook/ManuUI/ManuUI/";
    engine.setOfflineStoragePath( new_dir );
    qDebug() << "New path >> "+engine.offlineStoragePath();

    //添加import 目录
    engine.addImportPath("E:/github/notbook/ManuUI/ManuUI/");

    //如果在引用资源时使用了 QUrl 这个类，则必须在资源文件的路径前面加上「 qrc:」 ，
    //否则，QUrl 只会到本地目录去搜索
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //engine.load(QUrl(QStringLiteral("qrc:/test_circle_image.qml")));

    //QQmlContext *	rootContext() const
    engine.rootContext()->setContextProperty("offlineStoragePath", offlineStoragePath);

    return app.exec();
}


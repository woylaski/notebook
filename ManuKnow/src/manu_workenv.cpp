#include "manu_workenv.h"

QString getCurrentPath(void)
{
    QString path = QDir::currentPath();
    return path;
}

QString getParentPath(void)
{
    QString path = QDir::currentPath();
    int index=path.lastIndexOf("/");
    QString parent=path.mid(0,index+1);
    //qDebug()<<index<<topdir;
    return parent;
}

QString getWorkPath(void)
{
    QString parent=getParentPath();
    return parent+WORK_DIR;
}

//"qrc:/import", "E:/T/QMLPlugin/QMLPluginTest/", "./"
QStringList addImportPath(QQmlApplicationEngine &engine, QString path)
{
    engine.addImportPath(path);
    return engine.importPathList();
}

//"qrc:/import", "E:/T/QMLPlugin/QMLPluginTest/", "./"
QStringList addPluginPath(QQmlApplicationEngine &engine, QString path)
{
    engine.addPluginPath(path);
    return engine.pluginPathList();
}

QString setLocalStoragePath(QQmlApplicationEngine &engine, QString path)
{
    QUrl offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
    qDebug()<<"origin local storage path:"<<engine.offlineStoragePath();
    engine.setOfflineStoragePath(path);
    qDebug()<<"current local storage path:"<<engine.offlineStoragePath();
    return engine.offlineStoragePath();
}

void printSysPathInfo(QQmlApplicationEngine &engine)
{
    qDebug()<<"current path:"<<getCurrentPath();
    qDebug()<<"parent path:"<<getParentPath();
    qDebug()<<"work path:"<<getWorkPath();

    qDebug()<<"app run path:"<<QApplication::applicationDirPath();
    qDebug()<<"app file path:"<<QApplication::applicationFilePath();

    qDebug()<<"home path:"<<QDir::homePath();
    qDebug()<<"root path:"<<QDir::rootPath();
    qDebug()<<"temp path:"<<QDir::tempPath();
    qDebug()<<"local storage path:"<<engine.offlineStoragePath();
    qDebug()<<"import path list:"<<engine.importPathList();
    qDebug()<<"plugin path list:"<<engine.pluginPathList();
    qDebug()<<"base url:"<<engine.baseUrl();

    const QStringList & musicPaths = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
    const QStringList & desktopPaths = QStandardPaths::standardLocations(QStandardPaths::DesktopLocation);
    const QStringList & docPaths = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation);
    const QStringList & appPaths = QStandardPaths::standardLocations(QStandardPaths::ApplicationsLocation);
    const QStringList & moviesPaths = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation);
    const QStringList & downloadPaths = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation);
    const QStringList & picPaths = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    const QStringList & appDataPaths = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);

    qDebug()<<"musicPaths:"<<musicPaths;
    qDebug()<<"desktopPaths:"<<desktopPaths;
    qDebug()<<"docPaths:"<<docPaths;
    qDebug()<<"appPaths:"<<appPaths;
    qDebug()<<"moviesPaths:"<<moviesPaths;
    qDebug()<<"downloadPaths:"<<downloadPaths;
    qDebug()<<"picPaths:"<<picPaths;
    qDebug()<<"appDataPaths:"<<appDataPaths;
}

void setAppInfo(QApplication &app)
{
    app.setApplicationName(APP_NAME);
    app.setApplicationVersion(APP_VER);
    app.setOrganizationName(ORG_NAME);
    app.setOrganizationDomain(ORG_DOMAIN);

    app.setApplicationDisplayName(QObject::trUtf8("%1 %2 v%3").arg(APP_DISPLAY, APP_AUTHOR, app.applicationVersion()));
}

QString getLocalLanguage(void)
{
    return QLocale::system().name();
}

QString combineTranslatorPath(void)
{
    //QString localLan=QLocale::system().name();
    QString workPath=getWorkPath();
    return workPath+TRANSLATOR_DIR;
}

void loadTranslator(QApplication &app)
{
    QString localLan=getLocalLanguage();
    QString translatorPath=combineTranslatorPath();
    QTranslator translator;

    translator.load(QLocale::system().name(), translatorPath);
    //translator.load("/usr/share/Gbyzanz/translations/gbyzanz_" + QLocale::system().name());
    app.installTranslator(&translator);
}


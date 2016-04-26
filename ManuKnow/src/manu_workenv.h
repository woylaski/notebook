#ifndef WORKENV_H
#define WORKENV_H

#include "manu_common.h"

#define APP_NAME       "ManuKnow"
#define APP_VER            "0.0.1"
#define APP_AUTHOR    "JiaYuan, Zhang"
#define APP_DISPLAY     "We Want Know Everything! "
#define ORG_NAME        "MuoDouDong"
#define ORG_DOMAIN   "MuoDouDong.com"

#define WORK_DIR   "ManuKnow/"
#define TRANSLATOR_DIR "resources/translations"

QString getCurrentPath(void);
QString getWorkPath(void);
void setAppInfo(QApplication &app);
void loadTranslator(QApplication &app);
void printSysPathInfo(QQmlApplicationEngine &engine);

QStringList addImportPath(QQmlApplicationEngine &engine, QString path);
QStringList addPluginPath(QQmlApplicationEngine &engine, QString path);
QString setLocalStoragePath(QQmlApplicationEngine &engine, QString path);

#endif // WORKENV_H

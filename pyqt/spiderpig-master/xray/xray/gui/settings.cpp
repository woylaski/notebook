#include "settings.h"

#include <QSettings>

namespace
{
    QString company = "cisco";
    QString app = "tshsimulator";
    QString KeyLastDir = "lastMessageDir";
    QString KeyRecentCodecs = "recentCodecs";
}

Settings & Settings::getInstance()
{
    static Settings instance;
    return instance;
}

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

void Settings::saveLastDir(QString dir)
{
    QSettings(company, app).setValue(KeyLastDir, dir);
}

QString Settings::lastDir() const
{
    QString dir = QSettings(company, app).value(KeyLastDir, "/").toString();
    return dir;
}

void Settings::saveValue(QString key, QVariant value)
{
    QSettings(company, app).setValue(key, value);
}

QVariant Settings::value(QString key, QVariant defaultValue)
{
    return QSettings(company, app).value(key, defaultValue);
}

QStringList Settings::recentCodecs() const
{
    QStringList empty;
    return QSettings(company, app).value(KeyRecentCodecs, empty).toStringList();
}

void Settings::addRecentCodec(QString host)
{
    QStringList recents = recentCodecs();
    if (recents.contains(host))
        recents.removeOne(host);
    int topOfList = 0;
    recents.insert(topOfList, host);
    saveValue(KeyRecentCodecs, recents);
}

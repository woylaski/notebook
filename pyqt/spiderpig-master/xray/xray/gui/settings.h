#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QVariant>
#include <QStringList>

class Settings : public QObject
{
    Q_OBJECT

public:
    static Settings & getInstance();

    void saveLastDir(QString dir);
    QString lastDir() const;

    void saveValue(QString key, QVariant value);
    QVariant value(QString key, QVariant defaultValue = QVariant());
    void addRecentCodec(QString host);
    QStringList recentCodecs() const;

signals:
    
public slots:

private:
    explicit Settings(QObject *parent = 0);
    Settings (Settings const &);
    void operator=(Settings const&);

    QStringList m_recentCodecs;
};

#endif // SETTINGS_H

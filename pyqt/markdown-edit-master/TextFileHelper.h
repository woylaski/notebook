#ifndef TEXTFILEHELPER_H
#define TEXTFILEHELPER_H

#include <QObject>
#include <QString>
#include <QFile>

class TextFileHelper : public QObject {
    Q_OBJECT

public:
    explicit TextFileHelper (QObject * parent = NULL);

    Q_INVOKABLE QString read  (QString filePath);
    Q_INVOKABLE void    write (QString filePath, QString content);
};

#endif // TEXTFILEHELPER_H

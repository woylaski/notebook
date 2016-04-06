#ifndef EXEC_H
#define EXEC_H

#include <QQuickItem>

class Exec : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Exec)

public:
    Exec(QQuickItem *parent = 0);
    ~Exec();

    Q_INVOKABLE void cmd(const QString &s);
};

#endif // EXEC_H


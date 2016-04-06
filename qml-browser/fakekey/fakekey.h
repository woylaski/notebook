#ifndef FAKEKEY_H
#define FAKEKEY_H

#include <QQuickItem>

class Fakekey : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Fakekey)

public:
    Fakekey(QQuickItem *parent = 0);
    ~Fakekey();
    Q_INVOKABLE int sendKey(const QString &msg);
};

#endif // FAKEKEY_H


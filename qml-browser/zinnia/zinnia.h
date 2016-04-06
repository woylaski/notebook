#ifndef ZINNIA_H
#define ZINNIA_H

#include <QQuickItem>
#include <zinnia.h>

class Zinnia : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Zinnia)

public:
    Zinnia(QQuickItem *parent = 0);
    ~Zinnia();

    Q_INVOKABLE void clear();
    Q_INVOKABLE QString query(int s, int x, int y);

    zinnia::Recognizer *recognizer;
    zinnia::Character *character;
    zinnia::Result *result;
    QString str;
};

#endif // ZINNIA_H


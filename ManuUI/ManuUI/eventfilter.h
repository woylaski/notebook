#ifndef EVENTFILTER_H
#define EVENTFILTER_H

#include <QKeyEvent>

class KeyBackQuit: public QObject
{
public:
    KeyBackQuit(QObject *parent = 0)
        : QObject(parent)
    {}

    bool eventFilter(QObject *watched, QEvent * e)
    {
        switch(e->type())
        {
        case QEvent::KeyPress:
            if( ((QKeyEvent*)e)->key() == Qt::Key_Back )
            {
                e->accept();
                return true;
            }
            break;
        case QEvent::KeyRelease:
            if( ((QKeyEvent*)e)->key() == Qt::Key_Back )
            {
                e->accept();
                qApp->quit();
                return true;
            }
            break;
        default:
            break;
        }
        return QObject::eventFilter(watched, e);
    }

};

#endif // EVENTFILTER_H


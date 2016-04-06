#include <QDebug>
#include "fakekey.h"
#include <QGuiApplication>
#include <QQuickItem>
#include <QQuickWindow>

Fakekey::Fakekey(QQuickItem *parent):
    QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

Fakekey::~Fakekey()
{
}

int Fakekey::sendKey(const QString &msg)
{
    QQuickItem * receiver = qobject_cast<QQuickItem *>(QGuiApplication::focusObject());
    if (!receiver) {
        qDebug() << "simulateKeyPressEvent(): GuiApplication::focusObject() is 0 or not a QQuickItem.";
        return 1;
    }

    if(msg.startsWith(":enter")){
        QKeyEvent pressEvent = QKeyEvent(QEvent::KeyPress, Qt::Key_Return, Qt::NoModifier);
        QKeyEvent releaseEvent = QKeyEvent(QEvent::KeyRelease, Qt::Key_Return, Qt::NoModifier);
        receiver->window()->sendEvent(receiver, &pressEvent);
        receiver->window()->sendEvent(receiver, &releaseEvent);
        return 0;
    }

    if(msg.startsWith(":backspace")){
        QKeyEvent pressEvent = QKeyEvent(QEvent::KeyPress, Qt::Key_Backspace, Qt::NoModifier);
        QKeyEvent releaseEvent = QKeyEvent(QEvent::KeyRelease, Qt::Key_Backspace, Qt::NoModifier);
        receiver->window()->sendEvent(receiver, &pressEvent);
        receiver->window()->sendEvent(receiver, &releaseEvent);
        return 0;
    }

    QKeyEvent pressEvent = QKeyEvent(QEvent::KeyPress, 0, Qt::NoModifier, QString(msg));
    QKeyEvent releaseEvent = QKeyEvent(QEvent::KeyRelease, 0, Qt::NoModifier, QString(msg));
    receiver->window()->sendEvent(receiver, &pressEvent);
    receiver->window()->sendEvent(receiver, &releaseEvent);
    return 0;
}


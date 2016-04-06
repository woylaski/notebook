#include "exec.h"
#include <QProcess>
#include <QDebug>

Exec::Exec(QQuickItem *parent):
    QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
}

Exec::~Exec()
{
}

void Exec::cmd(const QString &s)
{
    qDebug() << s;
    QProcess::startDetached(s);
}

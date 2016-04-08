/* qjsCoreColor.cpp ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 17:48:29 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 66
 */

/* Change Log:
 *
 */

#include "qjsCoreColor.h"

#include <QtDebug>

QString qjsCoreColor::clear(void)
{
    return QString("\033[m");
}

QString qjsCoreColor::background(Qt::GlobalColor color, bool bold)
{
    int code;

    switch(color) {
    case Qt::black:   code = 40; break;
    case Qt::red:     code = 41; break;
    case Qt::green:   code = 42; break;
    case Qt::yellow:  code = 43; break;
    case Qt::blue:    code = 44; break;
    case Qt::magenta: code = 45; break;
    case Qt::cyan:    code = 46; break;
    case Qt::white:   code = 47; break;
    default:
        return qjsCoreColor::clear();
    }

    return QString("\033[%1;%2m").arg(bold).arg(QString::number(code));
}

QString qjsCoreColor::foreground(Qt::GlobalColor color, bool bold)
{
    int code;

    switch(color) {
    case Qt::black:   code = 30; break;
    case Qt::red:     code = 31; break;
    case Qt::green:   code = 32; break;
    case Qt::yellow:  code = 33; break;
    case Qt::blue:    code = 34; break;
    case Qt::magenta: code = 35; break;
    case Qt::cyan:    code = 36; break;
    case Qt::white:   code = 37; break;
    default:
        return qjsCoreColor::clear();
    }

    return QString("\033[%1;%2m").arg(bold).arg(QString::number(code));
}

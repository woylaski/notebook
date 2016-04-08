/* qjsCoreColor.h ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 17:45:32 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 35
 */

/* Change Log:
 *
 */

#pragma once

#include <QtCore>

class qjsCoreColor : public QObject
{
    Q_OBJECT

public:
    static QString clear(void);
    static QString background(Qt::GlobalColor color, bool bold = false);
    static QString foreground(Qt::GlobalColor color, bool bold = false);
};

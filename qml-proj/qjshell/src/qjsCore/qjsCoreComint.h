/* qjsCoreComint.h ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 16:19:01 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 37
 */

/* Change Log:
 *
 */

#pragma once

#include <QtCore>

class qjsCoreEngine;

class qjsCoreComint : public QObject
{
public:
     qjsCoreComint(QObject *parent = 0);
    ~qjsCoreComint(void);

public:
    void grab(qjsCoreEngine *);

public:
    void start(int argc, char **argv);
    void parse(int argc, char **argv);

private:
    void run(void);

private:
    class qjsCoreComintPrivate *d;
};

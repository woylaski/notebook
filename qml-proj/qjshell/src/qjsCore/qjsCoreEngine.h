/* qjsCoreEngine.h ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 19:43:50 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 35
 */

/* Change Log:
 *
 */

#pragma once

#include <QtQml>

class qjsCoreEngine : public QObject
{
    Q_OBJECT

public:
    enum EvaluationResult {
        Quit = 0x00,
        Fail = 0x01,
        Succ = 0x10
    };

public:
             qjsCoreEngine(QObject *parent = NULL);
    virtual ~qjsCoreEngine(void);

public:
    virtual qjsCoreEngine::EvaluationResult evaluate(const QString&);
};
